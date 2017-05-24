src_char_str="nmy"
trg_char_str="riz"

fn mat_chng src_char_str trg_char_str=
(
		loadMaterialLibrary (@"C:\temp\projects\pd\mat\char\"+src_char_str+"_map.mat")
		--fileOpenMatLib()
		for cur_mat in currentMaterialLibrary do
		(
			trg_mat="riz"+(substring cur_mat.name 4 cur_mat.name.count)
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


		if (substring currentMaterialLibrary.name (currentMaterialLibrary.name.count-7) (currentMaterialLibrary.name.count-3)) =="map" then
			
			(
				all_scn_lookup2 = getClassInstances mib_texture_lookup2

					for cur_lookup2 in all_scn_lookup2 do 
					(
						trg_bitmap_name=substituteString cur_lookup2.tex src_char_str trg_char_str
						if doesFileExist trg_bitmap_name==false then (HiddenDosCommand ("copy "+cur_lookup2.tex+" "+trg_bitmap_name))
						cur_bitmap.fileName=trg_bitmap_name
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
				)
			)
)