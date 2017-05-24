struct mg_shot
(
----------------------------------------------------------------------------------------------------------------------------------------------------------
--create char model paths
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_charmodel_paths root_path char_str=
	(
	--create paths
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\mdl\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\mdl\morph\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\mdl\zbrush\archive\"))
	--DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\mdl\rig\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\anm\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\cloth\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\rnd\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\xaf\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\env\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\start\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\uvw\archive\"))
	DOSCommand ("mkdir "+(root_path+@"maps\char\"+char_str+@"\archive\"))
	DOSCommand ("mkdir "+(root_path+@"psd\char\"+char_str+@"\archive\"))
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------
--create shot and render paths
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_shot_paths root_path scene_str shot_str=
	(
	--create shot paths
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\anm\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\audio\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\cache\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\cloth\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\eye\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\brw\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\msk\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\aoc\char\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\aoc\bgrd\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\nrm\char\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\nrm\bgrd\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\rpf\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\video\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\vol\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\xaf\archive\"))
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\mcp\archive\"))
		
	DOSCommand ("mkdir "+(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\maps\color\"))
	
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\color\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\comp\rnd\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\data\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\mask\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\pnt\"))
		
	--render paths
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\cmp\rnd\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\cmp\pnt\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\data\done\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\dif\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\aoc\char\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\aoc\bgrd\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\eye\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\brw\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\msk\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\nrm\char\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\nrm\bgrd\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\oid\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\pnt\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\rpf\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\shake\rnd\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\shake\pnt\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\vol\"))
	DOSCommand ("mkdir "+(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\zdp\"))
	),

----------------------------------------------------------------------------------------------------------------------------------------------------------
--create v01 scene files
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_init_scn root_path scene_str shot_str=
	(
	--suppresses path not found errors
	setsilentmode true
		
	--anm
	if doesFileExist (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\anm\"+scene_str+"_"+shot_str+"_v*.max")==false then
	(
		loadMaxFile  (root_path+@"shots\sc00\sh0000\anm\"+scene_str+"_"+shot_str+"_v01.max")
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\anm\"+scene_str+"_"+shot_str+"_v01.max")
	)
	
	--cloth
	if doesFileExist (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\cloth\"+scene_str+"_"+shot_str+"_v*.max")==false then
	(
	loadMaxFile  (root_path+@"shots\sc00\sh0000\cloth\"+scene_str+"_"+shot_str+"_v01.max")
	saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\cloth\"+scene_str+"_"+shot_str+"_v01.max")
	)
	
	),

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- setup rpf scene file based on lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_rpf root_path scene_str shot_str=
	(
	--create rpf
		
	--get info for xref
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	loadMaxFile cur_lgt_file
		
	xref_ary=#()

	if xrefs.getXRefFileCount()>0 then
	(
		for cur_num in 1 to (xrefs.getXRefFileCount()) do
			(
				if (xrefs.getXRefFile cur_num).disabled==false then
				(
				xref_ary[xref_ary.count+1]=(xrefs.getXRefFile cur_num).filename	
				)
			)
	)

	loadMaxFile  (root_path+@"shots\sc00\sh0000\rpf\sc00_sh0000_v01.max")
	renderSceneDialog.close()
	rendOutputFilename = (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\rpf\"+scene_str+"_"+shot_str+"_.rpf")

	renderSceneDialog.open()
	rnd_elm=MaxOps.GetCurRenderElementMgr ()
	rnd_elm.SetRenderElementFilename 0 (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\zdp\"+scene_str+"_"+shot_str+"_.jpg")
	renderSceneDialog.close()
		
	last_rpf_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\rpf\"+scene_str+@"_"+shot_str+@"_v*.max")
	if last_rpf_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_rpf_file
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\rpf\"+scene_str+"_"+shot_str+"_v"+up_num+".max")
	)
	else saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\rpf\"+scene_str+"_"+shot_str+"_v01.max")
	
	
	--merge all contentes of lgt file
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	mergeMAXFile cur_lgt_file

	--delete ligts
	delete lights
	
	-- set frame range
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_ary=filterString cur_cam.name "_"
	animationRange = interval (cam_ary[cam_ary.count-1] as integer) (cam_ary[cam_ary.count] as integer)
		
	-- run obj id script
	mg_rig.set_obj_ids()
		
	-- assign black material to all
	loadMaterialLibrary (root_path+@"setup\mtl_lib\"+"rpf_pass.mat")
		
	select $*
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[1]
		
	--delete eyelns
	delete $*_eyelns_*

	--add xrefs
	for cur_xref in xref_ary do
	(
	xrefs.addNewXRefFile cur_xref
	)
	
	-- save file
	saveMaxFile
	),

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- setup nrmc char scene files based on lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_nrm_char root_path scene_str shot_str=
	(
	---------------------
	--normal pass char
	---------------------
	loadMaxFile  (root_path+@"shots\sc00\sh0000\nrm\char\sc00_sh0000_v01.max")
	renderSceneDialog.close()
	rendOutputFilename = (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\nrm\char\"+scene_str+"_"+shot_str+"_.tga")
		
	last_nrm_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\nrm\char\"+scene_str+@"_"+shot_str+@"_v*.max")
	if last_nrm_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_nrm_file
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\nrm\char\"+scene_str+"_"+shot_str+"_v"+up_num+".max")
	)
	else saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\nrm\char\"+scene_str+"_"+shot_str+"_v01.max")

	--merge all contents of lgt file
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	mergeMAXFile cur_lgt_file

	--delete ligts
	delete lights
	
	-- set frame range
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_ary=filterString cur_cam.name "_"
	animationRange = interval (cam_ary[cam_ary.count-1] as integer) (cam_ary[cam_ary.count] as integer)
		
	-- assign nrm material to all
	loadMaterialLibrary (root_path+@"setup\mtl_lib\"+"nrm_char_pass.mat")
		
	select $*
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[1]

	select $*_eyelns*
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[2]

	select $*_eye_*
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[3]
		
	select $*_body_r*
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[4]

	-- save file
	saveMaxFile
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------
-- setup nrmc bgrd scene files based on lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_nrm_bgrd root_path scene_str shot_str=
	(
	---------------------
	--normal pass brgd
	---------------------
	--nrm bgrd
	
	--get info for xref
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	loadMaxFile cur_lgt_file
		
	xref_ary=#()

	if xrefs.getXRefFileCount()>0 then
	(
		for cur_num in 1 to (xrefs.getXRefFileCount()) do
			(
				if (xrefs.getXRefFile cur_num).disabled==false then
				(
				xref_ary[xref_ary.count+1]=(xrefs.getXRefFile cur_num).filename	
				)
			)
	)
	
	loadMaxFile  (root_path+@"shots\sc00\sh0000\nrm\bgrd\sc00_sh0000_v01.max")
	renderSceneDialog.close()
	rendOutputFilename = (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\nrm\bgrd\"+scene_str+"_"+shot_str+"_.tga")
	last_nrm_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\nrm\bgrd\"+scene_str+@"_"+shot_str+@"_v*.max")
	if last_nrm_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_nrm_file
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\nrm\bgrd\"+scene_str+"_"+shot_str+"_v"+up_num+".max")
	)
	else saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\nrm\bgrd\"+scene_str+"_"+shot_str+"_v01.max")
	
	--merge all contents of lgt file
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	mergeMAXFile cur_lgt_file

	-- set frame range
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_ary=filterString cur_cam.name "_"
	animationRange = interval (cam_ary[cam_ary.count-1] as integer) (cam_ary[cam_ary.count] as integer)
		
	select cur_cam
		
	--selection invert
	actionMan.executeAction 0 "40044"
		
	delete selection

	--add xrefs
	for cur_xref in xref_ary do
	(
	xrefs.addNewXRefFile cur_xref
	)
	
	
	-- save file
	saveMaxFile
	),

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- setup vol scene file based on lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_vol root_path scene_str shot_str=
	(
	--create vol
		
	--get info for xref
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	loadMaxFile cur_lgt_file
		
	xref_ary=#()

	if xrefs.getXRefFileCount()>0 then
	(
		for cur_num in 1 to (xrefs.getXRefFileCount()) do
			(
				if (xrefs.getXRefFile cur_num).disabled==false then
				(
				xref_ary[xref_ary.count+1]=(xrefs.getXRefFile cur_num).filename	
				)
			)
	)
	
	loadMaxFile  (root_path+@"shots\sc00\sh0000\vol\sc00_sh0000_v01.max")
	renderSceneDialog.close()
	rendOutputFilename = (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\vol\"+scene_str+"_"+shot_str+"_.jpg")
		
	last_vol_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\vol\"+scene_str+@"_"+shot_str+@"_v*.max")
	if last_vol_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_vol_file
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\vol\"+scene_str+"_"+shot_str+"_v"+up_num+".max")
	)
	else saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\vol\"+scene_str+"_"+shot_str+"_v01.max")
	
	
	--merge all contentes of lgt file
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	mergeMAXFile cur_lgt_file

	--delete ligts
	delete lights
	
	-- set frame range
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_ary=filterString cur_cam.name "_"
	animationRange = interval (cam_ary[cam_ary.count-1] as integer) (cam_ary[cam_ary.count] as integer)

		
	-- assign black material to all
	loadMaterialLibrary (root_path+@"setup\mtl_lib\"+"vol_pass.mat")
	select $*
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[1]
		
	--delete eyelns
	delete $*_eyelns_*

	--add xrefs
	for cur_xref in xref_ary do
	(
	xrefs.addNewXRefFile cur_xref
	)
	
	
	-- save file
	saveMaxFile
	),

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- setup aoc char scene files based on lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_aoc_char root_path scene_str shot_str=
	(
	---------------------
	--aoc pass
	---------------------
		
	
	loadMaxFile  (root_path+@"shots\sc00\sh0000\aoc\char\sc00_sh0000_v01.max")
	renderSceneDialog.close()
	rendOutputFilename = (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\aoc\char\"+scene_str+"_"+shot_str+"_.jpg")
		
	last_aoc_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\aoc\char\"+scene_str+@"_"+shot_str+@"_v*.max")
	if last_aoc_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_aoc_file
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\aoc\char\"+scene_str+"_"+shot_str+"_v"+up_num+".max")
	)
	else saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\aoc\char\"+scene_str+"_"+shot_str+"_v01.max")

	--merge all contents of lgt file
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	mergeMAXFile cur_lgt_file

	--delete ligts
	delete lights
	
	-- set frame range
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_ary=filterString cur_cam.name "_"
	animationRange = interval (cam_ary[cam_ary.count-1] as integer) (cam_ary[cam_ary.count] as integer)
		
	-- assign aoc material to all
	loadMaterialLibrary (root_path+@"setup\mtl_lib\"+"aoc_pass.mat")
		
	select $*
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[1]

	-- save file
	saveMaxFile
	),
	
----------------------------------------------------------------------------------------------------------------------------------------------------------
-- setup aoc bgrd scene files based on lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_aoc_bgrd root_path scene_str shot_str=
	(
	---------------------
	--normal pass brgd
	---------------------
	--aoc bgrd
	
	--get info for xref
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	loadMaxFile cur_lgt_file
		
	xref_ary=#()

	if xrefs.getXRefFileCount()>0 then
	(
		for cur_num in 1 to (xrefs.getXRefFileCount()) do
			(
				if (xrefs.getXRefFile cur_num).disabled==false then
				(
				xref_ary[xref_ary.count+1]=(xrefs.getXRefFile cur_num).filename	
				)
			)
	)
	
	loadMaxFile  (root_path+@"shots\sc00\sh0000\aoc\bgrd\sc00_sh0000_v01.max")
	renderSceneDialog.close()
	rendOutputFilename = (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\aoc\bgrd\"+scene_str+"_"+shot_str+"_.tga")
	last_aoc_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\aoc\bgrd\"+scene_str+@"_"+shot_str+@"_v*.max")
	if last_aoc_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_aoc_file
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\aoc\bgrd\"+scene_str+"_"+shot_str+"_v"+up_num+".max")
	)
	else saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\aoc\bgrd\"+scene_str+"_"+shot_str+"_v01.max")
	
	--merge all contents of lgt file
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	mergeMAXFile cur_lgt_file

	-- set frame range
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_ary=filterString cur_cam.name "_"
	animationRange = interval (cam_ary[cam_ary.count-1] as integer) (cam_ary[cam_ary.count] as integer)
		
	select cur_cam
		
	--selection invert
	actionMan.executeAction 0 "40044"
		
	delete selection

	--add xrefs
	for cur_xref in xref_ary do
	(
	xrefs.addNewXRefFile cur_xref
	)
	
		-- assign aoc material to all
	loadMaterialLibrary (root_path+@"setup\mtl_lib\"+"aoc_pass.mat")
		
	select $*
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[1]
	
backgroundColor = color 255 255 255
useEnvironmentMap = off
	
	-- save file
	saveMaxFile
	),

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- setup msk scene file based on lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_msk root_path scene_str shot_str=
	(
	--create msk
		
	--get info for xref
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	loadMaxFile cur_lgt_file
		
	xref_ary=#()

	if xrefs.getXRefFileCount()>0 then
	(
		for cur_num in 1 to (xrefs.getXRefFileCount()) do
			(
				if (xrefs.getXRefFile cur_num).disabled==false then
				(
				xref_ary[xref_ary.count+1]=(xrefs.getXRefFile cur_num).filename	
				)
			)
	)
	
	loadMaxFile  (root_path+@"shots\sc00\sh0000\msk\sc00_sh0000_v01.max")
	renderSceneDialog.close()
	rendOutputFilename = (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\msk\"+scene_str+"_"+shot_str+"_.jpg")
		
	last_msk_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\msk\"+scene_str+@"_"+shot_str+@"_v*.max")
	if last_msk_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_msk_file
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\msk\"+scene_str+"_"+shot_str+"_v"+up_num+".max")
	)
	else saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\msk\"+scene_str+"_"+shot_str+"_v01.max")
	
	
	--merge all contentes of lgt file
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	mergeMAXFile cur_lgt_file
	
	scene_bodies=$'*Bone head'
	scene_chars=#()
	
	for cur_num in 1 to scene_bodies.count do
	(
	scene_chars[cur_num]=(filterstring scene_bodies[cur_num].name "_")[1]
	)
	
	for cur_char in scene_chars do (execute ("delete $"+cur_char+"*"))
		
	--delete ligts
	delete lights
	
	-- set frame range
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_ary=filterString cur_cam.name "_"
	animationRange = interval (cam_ary[cam_ary.count-1] as integer) (cam_ary[cam_ary.count] as integer)

	--add xrefs
	for cur_xref in xref_ary do
	(
	xrefs.addNewXRefFile cur_xref
	)
	
	
	-- save file
	saveMaxFile
	),
	

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- setup eye scene file based on lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_eye root_path scene_str shot_str=
	(
	--create eye
	loadMaxFile  (root_path+@"shots\sc00\sh0000\eye\sc00_sh0000_v01.max")
	renderSceneDialog.close()
	rendOutputFilename = (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\eye\"+scene_str+"_"+shot_str+"_.jpg")
		
	last_eye_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\eye\"+scene_str+@"_"+shot_str+@"_v*.max")
	if last_eye_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_eye_file
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\eye\"+scene_str+"_"+shot_str+"_v"+up_num+".max")
	)
	else saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\eye\"+scene_str+"_"+shot_str+"_v01.max")
	
	
	--merge all contentes of lgt file
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	mergeMAXFile cur_lgt_file

	--delete ligts
	delete lights
	
	-- set frame range
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_ary=filterString cur_cam.name "_"
	animationRange = interval (cam_ary[cam_ary.count-1] as integer) (cam_ary[cam_ary.count] as integer)

	loadMaterialLibrary (root_path+@"setup\mtl_lib\"+"eye_pass.mat")

	select $*eye*		
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[1]
		
	select $*eyelns*		
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[2]
		
	select $*eye*
		
	--selection invert
	actionMan.executeAction 0 "40044"
		
	-- assign black material to all

	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[3]
	
	-- save file
	saveMaxFile
	),
	

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- setup brw scene file based on lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_brw root_path scene_str shot_str=
	(
	--create brw
	loadMaxFile  (root_path+@"shots\sc00\sh0000\brw\sc00_sh0000_v01.max")
	renderSceneDialog.close()
	rendOutputFilename = (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\brw\"+scene_str+"_"+shot_str+"_.png")
		
	last_brw_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\brw\"+scene_str+@"_"+shot_str+@"_v*.max")
	if last_brw_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_brw_file
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\brw\"+scene_str+"_"+shot_str+"_v"+up_num+".max")
	)
	else saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\brw\"+scene_str+"_"+shot_str+"_v01.max")
	
	
	--merge all contentes of lgt file
	cur_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	mergeMAXFile cur_lgt_file

	--delete ligts
	delete lights
	
	-- set frame range
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_ary=filterString cur_cam.name "_"
	animationRange = interval (cam_ary[cam_ary.count-1] as integer) (cam_ary[cam_ary.count] as integer)

	loadMaterialLibrary (root_path+@"setup\mtl_lib\"+"brw_pass.mat")
		
	select $*	
	-- assign black material to all

	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[3]
		
	select $*brows*		
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[1]
		
	select $*_mst_*		
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[2]

	select $*_lashes*		
	for cur_obj in selection do cur_obj.material=currentMaterialLibrary[2]
		

	
	-- save file
	saveMaxFile
	),	
----------------------------------------------------------------------------------------------------------------------------------------------------------	
--preps the render cloth, using the saved skin_cloth file and highest cloth sim file to create an export file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn render_cloth_prep scene_str shot_str root_path=
	(
		--files
		sim_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\cloth\"+scene_str+@"_"+shot_str+@"_v*.max")


		--load sim file
		loadMaxFile sim_file quiet:true
	
		scene_bodies=$'*Bone head'
		scene_chars=#()
		
		--process for each character in scene file
		for cur_num in 1 to scene_bodies.count do
		(
		scene_chars[cur_num]=(filterstring scene_bodies[cur_num].name "_")[1]
		)
		
		cur_num=substring maxfilename (maxfilename.count-5) 2

		for num in 0 to (LayerManager.count-1) do
			(
			cur_layer=LayerManager.getLayer num
			cur_layer.on=true
			)
			
		unfreeze objects
		unhide objects

		obj_ary=$*cloth as array

		select obj_ary
		actionMan.executeAction 0 "40044"  --max select invert
		delete $

		for cur_obj in obj_ary do (cur_obj.name=cur_obj.name+"_sim")

		for char_str in scene_chars do
		(
		skin_cloth_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_skin_cloth_v*.max")
		mergeMAXFile skin_cloth_file #useMergedMtlDups  #deleteOldDups quiet:true			
		)
		
		--create morpher setup
		morph_ary=$*_cloth
		for cur_obj in morph_ary do
		(
		addmodifier cur_obj (morpher ()) 
		WM3_MC_BuildFromNode cur_obj.morpher 1 (getNodeByName(cur_obj.name+"_sim"))
		WM3_MC_SetValue cur_obj.morpher 1 100.0
		cur_obj.morpher.Autoload_of_targets=1
		)
		
		tmp_ary= $*cloth
		for cur_obj in tmp_ary do cur_obj.renderable=off
			
		tmp_ary= $*sim
		for cur_obj in tmp_ary do cur_obj.renderable=off
			
		saveMaxFile (maxFilePath+"clothexp_v"+cur_num) quiet:true		
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------
-- setup lgt scene file based on lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_lgt root_path scene_str shot_str=
	(
	cur_anm_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\anm\"+scene_str+@"_"+shot_str+@"_v*.max")
	loadMaxFile cur_anm_file
		
	--get info for xref
	xref_ary=#()

	if xrefs.getXRefFileCount()>0 then
	(
		for cur_num in 1 to (xrefs.getXRefFileCount()) do
			(
				if (xrefs.getXRefFile cur_num).disabled==false then
				(
				xref_ary[xref_ary.count+1]=(xrefs.getXRefFile cur_num).filename	
				)
			)
	)
	
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_name=copy cur_cam.name
		
	scene_bodies=$'*Bone head'
	scene_chars=#()

	for cur_num in 1 to scene_bodies.count do
	(
	scene_chars[cur_num]=(filterstring scene_bodies[cur_num].name "_")[1]
	)
	
	--create lgt
	loadMaxFile  (root_path+@"shots\sc00\sh0000\lgt\sc00_sh0000_v01.max")
	renderSceneDialog.close()
	rendOutputFilename = (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\dif\"+scene_str+"_"+shot_str+"_.tga")
		
	last_lgt_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
	if last_lgt_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_lgt_file
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+"_"+shot_str+"_v"+up_num+".max")
	)
	else saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+"_"+shot_str+"_v01.max")
	
	for cur_num in 1 to scene_chars.count do
	(
		char_str=scene_chars[cur_num]
		mg_shot.imp_rndrig char_str scene_str shot_str root_path
	)
		
	--merge camera from anim file
	mergeMAXFile cur_anm_file #(cam_name) quiet:true
	
	-- set frame range
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_ary=filterString cur_cam.name "_"
	animationRange = interval (cam_ary[cam_ary.count-1] as integer) (cam_ary[cam_ary.count] as integer)

	--add xrefs
	for cur_xref in xref_ary do
	(
	xrefs.addNewXRefFile cur_xref
	)
	

	-- save file
	saveMaxFile
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------
-- setup cloth scene file for simming
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_cloth root_path scene_str shot_str=
	(
	cur_anm_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\anm\"+scene_str+@"_"+shot_str+@"_v*.max")
	loadMaxFile cur_anm_file
		
	--get info for xref
	xref_ary=#()

	if xrefs.getXRefFileCount()>0 then
	(
		for cur_num in 1 to (xrefs.getXRefFileCount()) do
			(
				if (xrefs.getXRefFile cur_num).disabled==false then
				(
				xref_ary[xref_ary.count+1]=(xrefs.getXRefFile cur_num).filename	
				)
			)
	)
	
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_name=copy cur_cam.name
		
	scene_bodies=$'*Bone head'
	scene_chars=#()

	for cur_num in 1 to scene_bodies.count do
	(
	scene_chars[cur_num]=(filterstring scene_bodies[cur_num].name "_")[1]
	)
	
	--create lgt
	loadMaxFile  (root_path+@"shots\sc00\sh0000\lgt\sc00_sh0000_v01.max")
	renderSceneDialog.close()
	--rendOutputFilename = (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\dif\"+scene_str+"_"+shot_str+"_.tga")
	
	last_cloth_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\cloth\"+scene_str+@"_"+shot_str+@"_v*.max")
	if last_lgt_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_lgt_file
		saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\cloth\"+scene_str+"_"+shot_str+"_v"+up_num+".max")
	)
	else saveMaxFile (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\cloth\"+scene_str+"_"+shot_str+"_v01.max")
	
	for cur_num in 1 to scene_chars.count do
	(
		char_str=scene_chars[cur_num]
		mg_shot.imp_clothrig char_str scene_str shot_str root_path
	)
		
	--merge camera from anim file
	mergeMAXFile cur_anm_file #(cam_name) quiet:true
	
	-- set frame range
	cur_cam=(execute("$cam_"+scene_str+"_"+shot_str+"_*"))[1]
	cam_ary=filterString cur_cam.name "_"
	animationRange = interval -50 (cam_ary[cam_ary.count] as integer)

	--add xrefs
	for cur_xref in xref_ary do
	(
	xrefs.addNewXRefFile cur_xref
	)
	

	-- save file
	saveMaxFile
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------
--loads shot cloth, exports sim objects, attaches render cloth and brings it into the lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cloth_upd_scene char_str scene_str shot_str root_path=
	(
			
		clopthexp_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\cloth\"+char_str+@"_clothexp_v*.max")
		mergeMAXFile clopthexp_file #useMergedMtlDups  #deleteOldDups quiet:true

	),
fn cloth_upd_scene_all scene_str shot_str root_path=
	(
			
		clopthexp_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\cloth\"+@"clothexp_v*.max")
		mergeMAXFile clopthexp_file #useMergedMtlDups  #deleteOldDups quiet:true

	),
----------------------------------------------------------------------------------------------------------------------------------------------------------	
--loads shot cloth, exports sim objects, attaches render cloth and brings it into the lighting file
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn cloth_upd_lgt char_str scene_str shot_str root_path sht_type=
	(
		if sht_type=="lgt" then cur_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")

		if cur_file==undefined then cur_file=get_highest_file(root_path+@"shots\sc00\sc00_sh0000_v*.max")
		
		loadMaxFile cur_file quiet:true
			
		clopthexp_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\cloth\"+char_str+@"_clothexp_v*.max")
		mergeMAXFile clopthexp_file #useMergedMtlDups  #deleteOldDups quiet:true
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------	
fn imp_clothrig char_str scene_str shot_str root_path=
	(
		--files
		char_clothrig_file=get_highest_file(root_path+@"models\char\"+char_str+@"\rig\cloth\"+char_str+@"_cloth_rig_v*.max")
		mergeMAXFile char_clothrig_file #useMergedMtlDups quiet:true
		
		char_anm_xaf_file=get_highest_file(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\xaf\"+char_str+"_"+scene_str+@"_"+shot_str+@"_v*.xaf")
		ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
		ctrl_layer.select on
		mg_anm.load_anm char_anm_xaf_file (selection as array) false false 1
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------	
fn imp_rndrig char_str scene_str shot_str root_path=
	(
		--files
		execute ("delete $"+char_str+"*")
		char_rndrig_file=get_highest_file(root_path+@"models\char\"+char_str+@"\rig\rnd\"+char_str+@"_rig_v*.max")
		mergeMAXFile char_rndrig_file #useMergedMtlDups quiet:true
		
		char_anm_xaf_file=get_highest_file(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\xaf\"+char_str+"_"+scene_str+@"_"+shot_str+@"_v*.xaf")
		ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
		ctrl_layer.select on
		mg_anm.load_anm char_anm_xaf_file (selection as array) false false 0
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn imp_rndrig_lgt scene_str shot_str root_path=
	(
		scene_bodies=$'*Bone head'
		scene_chars=#()
		
		--process for each character in scene file
		for cur_num in 1 to scene_bodies.count do
		(
		scene_chars[cur_num]=(filterstring scene_bodies[cur_num].name "_")[1]
		)
		
cur_file=get_highest_file(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")		
if cur_file==undefined then cur_file=get_highest_file(root_path+@"shots\sc00\sc00_sh0000_v*.max")
			--load lgt file
			loadMaxFile cur_file quiet:true
		
		for char_str in scene_chars do
		(
			--files
			char_rndrig_file=get_highest_file(root_path+@"models\char\"+char_str+@"\rig\rnd\"+char_str+@"_rig_v*.max")

			obj_ary=(execute ("$"+char_str+"*")) as array
			delete obj_ary
				
			mergeMAXFile char_rndrig_file #useMergedMtlDups #deleteOldDups quiet:true
				
			char_anm_xaf_file=get_highest_file(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\xaf\"+char_str+"_"+scene_str+@"_"+shot_str+@"_v*.xaf")
			ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
			ctrl_layer.select on
			mg_anm.load_anm char_anm_xaf_file (selection as array) false false 0
		)
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn upd_anmrig scene_str shot_str root_path=
	(
		scene_bodies=$'*Bone head'
		scene_chars=#()

		for cur_num in 1 to scene_bodies.count do
		(
		scene_chars[cur_num]=(filterstring scene_bodies[cur_num].name "_")[1]
		)
		
		
		for char_str in scene_chars do
		(
		delete (execute("$"+char_str+"*"))
			
		--files
		char_anmrig_file=get_highest_file(root_path+@"models\char\"+char_str+@"\rig\anm\"+char_str+@"_anm_rig_v*.max")
		anm_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\anm\"+scene_str+@"_"+shot_str+@"_v*.max")

		--obj_ary=(execute ("$"+char_str+"*")) as array
		--delete obj_ary
			
		mergeMAXFile char_anmrig_file #useMergedMtlDups #deleteOldDups quiet:true
			
		char_anm_xaf_file=get_highest_file(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\xaf\"+char_str+"_"+scene_str+@"_"+shot_str+@"_v*.xaf")
		ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
		ctrl_layer.select on
		mg_anm.load_anm char_anm_xaf_file (selection as array) false false 0
		)
		
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------
fn save_xaf_upd_anm scene_str shot_str root_path char_rig_ary=
	(
		scene_bodies=$'*Bone head'
		scene_chars=#()

		for cur_num in 1 to scene_bodies.count do
		(
		scene_chars[cur_num]=(filterstring scene_bodies[cur_num].name "_")[1]
		)
		
		
		for char_str in scene_chars do
		(
		ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
		ctrl_layer.select on
		mg_anm.save_anm char_str (selection as array) (substituteString maxfilepath "anm" "xaf") (char_str+"_"+(substituteString maxfilename ".max" ".xaf"))

		--files
		char_anmrig_file=get_highest_file(root_path+@"models\char\"+char_str+@"\rig\anm\"+char_str+@"_anm_rig_v*.max")
		anm_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\anm\"+scene_str+@"_"+shot_str+@"_v*.max")

		if char_anmrig_file!=undefined then
			(
			delete (execute("$"+char_str+"*"))
			mergeMAXFile char_anmrig_file #useMergedMtlDups #deleteOldDups quiet:true
				
			char_anm_xaf_file=get_highest_file(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\xaf\"+char_str+"_"+scene_str+@"_"+shot_str+@"_v*.xaf")
			ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
			ctrl_layer.select on
			mg_anm.load_anm char_anm_xaf_file (selection as array) false false 0
			)
		)
		
	),
-----------------------------------------------------------------------------------------------------------------------------------------------------------	
fn imp_anmrig char_str scene_str shot_str root_path=
	(
		--files
		char_anmrig_file=get_highest_file(root_path+@"models\char\"+char_str+@"\rig\anm\"+char_str+@"_anm_rig_v*.max")
		
		anm_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\anm\"+scene_str+@"_"+shot_str+@"_v*.max")
		
		--load lgt file
		loadMaxFile anm_file quiet:true

		obj_ary=(execute ("$"+char_str+"*")) as array
		delete obj_ary
			
		mergeMAXFile char_anmrig_file #useMergedMtlDups #deleteOldDups quiet:true
			
		char_anm_xaf_file=get_highest_file(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\xaf\"+char_str+"_"+scene_str+@"_"+shot_str+@"_v*.xaf")
		ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
		ctrl_layer.select on
		mg_anm.load_anm char_anm_xaf_file (selection as array) false false 0
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------		
fn ver_up_num last_file =
	(
	last_path=pathConfig.removePathLeaf last_file

	last_num=substring last_file (last_file.count-5) 2

	next_num_str=((last_num as integer)+1) as string
	if next_num_str.count<2 then next_num_str="0"+next_num_str
	else next_num_str
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------	
fn render_byframe=
	(
		for cur_time in (animationRange.start as integer)/600 to (animationRange.end as integer)/600 do
		(	
		slidertime = cur_time
		render outputfile:rendOutputFilename
		)
	)
)
--End Struct Def