previz_files=getFiles @"D:\projects\pd\shots\sc04\previz\*.max"
create_dir=false
for cur_previz in previz_files do
(--cur_previz=previz_files[15]
	cur_file=filenameFromPath cur_previz
	cur_scene=SubstituteString cur_file (scene_str+"_") ""
	cur_scene=SubstituteString cur_scene ".max" ""
	shot_str="sh"+cur_scene
	
	if create_dir==true then mg_shot.cr_shot_paths root_path scene_str shot_str
	
	anm_path=root_path+@"shots\"+scene_str+@"\"+shot_str+@"\anm\"
	anm_files=getFiles (anm_path+"*.max")
	
	if anm_files.count==0 then
	(
		copyFile cur_previz (anm_path+scene_str+"_"+shot_str+"_v01.max")
		loadMaxFile (anm_path+scene_str+"_"+shot_str+"_v01.max")
		disableSceneRedraw();
		mg_shot.save_xaf_upd_anm scene_str shot_str root_path char_rig_ary
		enableSceneRedraw()
	)

	/*if (isDirectoryWriteable anm_path)!=true then
	(
		mg_shot.cr_shot_paths root_path scene_str shot_str
	)*/
	
	--print anm_path
	--tmp_ary=filterString cur_file
	
)


--turn off all Bone layers
for num in 0 to (LayerManager.count-1) do
(
	cur_layer=layermanager.getlayer num
	if (findString cur_layer.name "Bones")!=undefined then
	(
		print cur_layer.name
		cur_layer.on=false
	)
)

-- set render settings
-- have to set manually

--set frame rate
frameRate=8


/*
for num in 120 to 210 by 10 do 

(
	shot_str=num as string
	mg_shot.cr_shot_paths root_path scene_str shot_str
	
)
*/