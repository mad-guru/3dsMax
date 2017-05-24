-- Functions for Mental Ray
-- mg_mr_tools_v02.ms

-- By Adnan Hussain
-- Mad Guru Productions
-- http://www.madguru.net

-- Jan. 6 2011
-- Now supports file names and paths with spaces.
-- Create Mip Maps:  Added Overwrite and Delete Source Check Boxes
-- Mat Change: Added options to take existing Matlib and swap out search and replace a src string with a trg string
-- usage eg Changing a character prefix for a set of materials.
-- Bitmap to Map Changer: Added Reverse Option

-- Nov. 14 2010
-- No warranty is made expressed or implied as to the safety or useability of any of the code provided. Use at your own risk.


-- DEFAULT Variable Settings
map_src_path=@"D:\projects\gul_scenes\maps\workshop\"
imf_copy_path=@"C:\Program Files\Autodesk\3ds Max 2013\NVIDIA\"
filter_str="*"
subdir=true
imf_copy_flags="-vrp"
mat_path=@"C:\temp\projects\pd\mat\char\"
-- FUNCTION imf_copy
-- given a source path with files to convert and the path to the imf_copy.exe file, along with an optional filter string, "*", "*.tga", "*.tif", "*.jpg"
-- it converts convertable files to map format and saves in the same folder

-- modified from maxscript help file to include root path
fn getFilesRecursive root pattern =
	(
	dir_array = GetDirectories (root+"/*")
	-- add root path to array
	dir_array[dir_array.count]=root
	for d in dir_array do
	join dir_array (GetDirectories (d+"/*"))
	my_files = #()
	for f in dir_array do
	join my_files (getFiles (f + pattern))
	my_files 
	)

fn imf_copy map_src_path imf_copy_path filter_str subdir imf_copy_flags delmap ovwmap=
(
	progressStart "Creating Maps..."
		--process paths
		if (substring map_src_path map_src_path.count map_src_path.count)!=@"\" then (map_src_path=map_src_path+@"\")

		if (substring imf_copy_path imf_copy_path.count imf_copy_path.count)!=@"\" then (imf_copy_path=imf_copy_path+@"\")

		if (substring imf_copy_flags 1 1)!="-" then (imf_copy_flags="-"+imf_copy_flags)
			
		cur_files_ary=#()
		if subdir==true then (cur_files_ary=(getFilesRecursive map_src_path filter_str))
		else (cur_files_ary=getfiles (map_src_path+filter_str))

		if doesFileExist (imf_copy_path+"imf_copy.exe")==true and cur_files_ary.count>0 then
			(
				for cur_num in 1 to cur_files_ary.count do
				(
					if getProgressCancel() then exit

					progressUpdate=(100*cur_num/cur_files_ary.count) as integer
					cur_file=cur_files_ary[cur_num]
					cur_map=(substring cur_file 1 (cur_file.count-3))+"map"
						
					if doesFileExist cur_map==false or ovwmap==true do 
					(
						HiddenDosCommand ("cd "+imf_copy_path+"&imf_copy.exe "+imf_copy_flags+" \""+ cur_file+"\" \""+cur_map+"\"")
						
						--imf_copy -p -r name.tga name.map 
						if doesFileExist cur_map==false then (print ("Skipped "+cur_file+". Not a convertable file format."))
						else
							(
								print ("Successfully Converted "+cur_file)
								if delmap==true then (HiddenDosCommand ("del "+cur_map))
							)
					)
				)
			)
			else
				(
				if doesFileExist (imf_copy_path+"imf_copy.exe")!=true then (print "WARNING: Could not run. Please check imf_copy.exe path.")
				if cur_files_ary.count<1 then (print "WARNING: Could not run. Please check maps path.")
				)
progressEnd()
			
)

-- FUNCTION swap_bmp_map
-- swaps all BitmapTexture maps with Mip Maps with the same name if they exist in the same folder.
/*
Maxscript does not allow access to turning on Enable Color Map button in Bitmaps, so the source material
should used a mix map to do any color map work if needed, so that the script can just replace the bitmap
with the map file and retain color mapping.
*/

fn swap_bmp_map =
	(
		all_scn_bitmaps = getClassInstances BitmapTexture

		for cur_bitmap in all_scn_bitmaps do
			(
				cur_map_file=(substring cur_bitmap.fileName 1 (cur_bitmap.fileName.count-3))+"map"
				if doesFileExist cur_map_file==true do
					(
					cur_map=(mib_texture_lookup2())
					cur_map.tex=cur_map_file
					cur_map.factor=1
					cur_map.name=cur_bitmap.name
					replaceInstances cur_bitmap cur_map
					)
			)
	)

fn swap_map_bmp cur_ext=
	(
		all_scn_lookup2 = getClassInstances mib_texture_lookup2

		for cur_lookup2 in all_scn_lookup2 do
			(
				cur_map_file=(substring cur_lookup2.tex 1 (cur_lookup2.tex.count-3))+cur_ext
				if doesFileExist cur_map_file==true do
					(
					cur_map=(BitmapTexture())
					cur_map.filename=cur_map_file
					cur_map.name=cur_map.filename
					replaceInstances cur_lookup2 cur_map
					)
			)
	)
	
	-- FUNCTION mk_scn_matlib
	-- creates a mat lib out of scene materials. Go to the Map Browser and save it manually.
	fn mk_scn_matlib =
		(
			-- create matlib from scene
			for mat in scenematerials do append currentmateriallibrary mat
		)
		
fn mat_chng src_char_str trg_char_str mtl_type mat_path=
(
				--process paths
		if (substring mat_path mat_path.count mat_path.count)!=@"\" then (mat_path=mat_path+@"\")
		loadMaterialLibrary (mat_path+src_char_str+"_"+mtl_type+".mat")
		--fileOpenMatLib()
		for cur_mat in currentMaterialLibrary do
		(
			trg_mat=trg_char_str+(substring cur_mat.name 4 cur_mat.name.count)
			if getNodeByName trg_mat!=undefined then
				(
					cur_trg_obj=getNodeByName trg_mat
					cur_trg_obj.material=copy cur_mat
					cur_trg_obj.material.name=trg_mat
				)
				else
				(
					tmp_ary=execute("$"+cur_mat.name+"*")
					if tmp_ary.count>0 do
					(
						for cur_num in 1 to tmp_ary.count do
						(
							if cur_num==1 then
								(
								cur_obj=tmp_ary[cur_num]
								cur_obj.material=cur_mat
								cur_obj.material.name=trg_mat
								)
							else (cur_obj.material=tmp_ary[1].material)
						)
					)
				)
		)


		if mtl_type =="map" then
			
			(
				all_scn_lookup2 = getClassInstances mib_texture_lookup2

					for cur_lookup2 in all_scn_lookup2 do 
					(
						trg_bitmap_name=substituteString cur_lookup2.tex src_char_str trg_char_str
						if doesFileExist trg_bitmap_name==false then (HiddenDosCommand ("copy "+cur_lookup2.tex+" "+trg_bitmap_name))
						cur_lookup2.tex=trg_bitmap_name
						cur_lookup2.name=substituteString cur_lookup2.name src_char_str trg_char_str
					)
			)
		else	
			(
					all_scn_bitmaps = getClassInstances BitmapTexture

				for cur_bitmap in all_scn_bitmaps do 
				(
					trg_bitmap_name=substituteString cur_bitmap.fileName src_char_str trg_char_str
					if doesFileExist trg_bitmap_name==false then (HiddenDosCommand ("copy "+cur_bitmap.filename+" "+trg_bitmap_name))
					cur_bitmap.fileName=trg_bitmap_name
					cur_bitmap.name=substituteString cur_bitmap.name src_char_str trg_char_str
				)
			)
)
		
--UI

rollout mg_mipmap_rollout "Mip Map Tools" width:388 height:382
(
	edittext map_src_path_label "Map Src Path" pos:[11,66] width:293 height:16
	edittext imf_copy_path_label "imf_copy Path" pos:[9,90] width:295 height:16
	dropdownList filter_str_ddl "Filter" pos:[315,65] width:53 height:40 enabled:true items:#("*", "*.tga", "*.tif", "*.png", "*.jpg", "*.exr", "*.rla", "*.rgb") selection:1
	GroupBox gmm_grp "Create Mip Maps" pos:[3,4] width:382 height:147
	button create_btn "Create" pos:[288,118] width:86 height:22
	GroupBox Bitmap_to_Map_grp "Bitmap to Map Changer" pos:[8,159] width:160 height:89
	button bmp_to_map_change "Change" pos:[25,216] width:53 height:22
	button mk_scn_matlib_btn "Make Scene Matlib" pos:[215,216] width:112 height:24
	label gen_mipmaps_lbl "Fill in paths for Map Source and imf_copy.exe. Choose a filter for which file type to convert and click convert to create .map." pos:[13,25] width:356 height:34
	label bitmap_to_map_lbl "Change scene BitmapTextures to .map files if they exist." pos:[15,179] width:149 height:29
	GroupBox mk_scn_matlib_grp "Make Scene Matlib" pos:[175,159] width:210 height:89
	label mk_scn_matlib_lbl "Create matlib from scene. Manually save it from the Material/Map Browser." pos:[182,179] width:197 height:32
	checkbox subdir_chk "Sub Folders" pos:[13,119] width:79 height:19
	edittext imf_copy_flags_edt "flags" pos:[99,120] width:85 height:16
	label about_lbl "By Adnan Hussain - Jan. 6, 2011 - mg_mr_tools_v02.ms - http://www.madguru.net" pos:[9,346] width:367 height:31
	checkbox delmap_chk "Del Src" pos:[192,114] width:41 height:30
	checkbox ovwmap_chk "Ovw Trg" pos:[239,115] width:44 height:28
	button change_rev_btn "Reverse" pos:[89,216] width:59 height:21
	edittext src_char_str_edt "src_char" pos:[13,272] width:91 height:15
	edittext trg_char_str_edt "trg_char" pos:[14,291] width:89 height:16
	dropdownList mtl_type_ddl "mtl_type" pos:[114,268] width:50 height:40 items:#("map", "bmp")
	GroupBox grp_matchng "Mat Change" pos:[8,258] width:370 height:79
	button matchng_apply_btn "apply" pos:[315,313] width:55 height:19

	edittext mat_path_label "Matlib Path" pos:[15,314] width:293 height:16 enabled:true
	label lbl21 "Loads Matlib named <src_char>_map or <src_char>_bmp and replaces src_char in texture map names to trg_char string. " pos:[174,269] width:197 height:41
	on mg_mipmap_rollout open do
	(
		map_src_path_label.text=map_src_path
		imf_copy_path_label.text=imf_copy_path
		imf_copy_flags_edt.text=imf_copy_flags
		mat_path_label.text=mat_path
	)
	on filter_str_ddl selected sel do
		(filter_str=filter_str_ddl.items[sel])
	on create_btn pressed do
	(
			-- paths not undefined or empty ""
			if (map_src_path_label.text!=undefined and map_src_path_label.text!="" and imf_copy_path_label.text!=undefined and imf_copy_path_label.text!="") then
	
			(
	
			if filter_str==undefined or filter_str=="" do (filter_str="*")
	
			imf_copy map_src_path_label.text imf_copy_path_label.text filter_str subdir_chk.checked imf_copy_flags_edt.text delmap_chk.checked ovwmap_chk.checked
	
			)
	
			else
	
			(print "Please enter paths.")
		)
	on bmp_to_map_change pressed do
		swap_bmp_map()
	on mk_scn_matlib_btn pressed do
		mk_scn_matlib()
	on change_rev_btn pressed do
	(
			swap_map_bmp "tif"
			swap_map_bmp "tga"
			swap_map_bmp "png"
		)
	on mtl_type_ddl selected sel do
		(mtl_type=mtl_type_ddl.items[sel])
	on matchng_apply_btn pressed do
	(
	if mtl_type==undefined or mtl_type=="" do (mtl_type="map")
	if mat_path_label.text!=undefined and mat_path_label.text!="" then
	(mat_chng src_char_str_edt.text trg_char_str_edt.text mtl_type mat_path)
	else
	(print "Please enter matlib path.")
	)
)

		mg_mr_tools_floater=newRolloutFloater "mg_mr_tools v2.0" 400 400
		addRollout mg_mipmap_rollout mg_mr_tools_floater