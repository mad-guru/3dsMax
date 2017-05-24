------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- user defined variables
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
char_str="nmy"
scene_str="sc04"
shot_str="sh0180"
root_path=@"d:\projects\pd\"

letter_ary=#("l","r")

char_rig_ary=#(
getNodeByName(char_str+"_eye_r_pt02 control"),
getNodeByName(char_str+"_eye_l_pt02 control"),
getNodeByName(char_str+"_lookat control"),
getNodeByName(char_str+"_IK foot control R"),
getNodeByName(char_str+"_IK foot control L"),
getNodeByName(char_str+"_IK arm control L"),
getNodeByName(char_str+"_IK arm control R"),
getNodeByName(char_str+"_Head control"),
getNodeByName(char_str+"_Chest control"),
getNodeByName(char_str+"_Hand control R"),
getNodeByName(char_str+"_FK forearm R"),
getNodeByName(char_str+"_FK upper arm R"),
getNodeByName(char_str+"_IK arm flip angle R"),
getNodeByName(char_str+"_Hand control L"),
getNodeByName(char_str+"_FK forearm L"),
getNodeByName(char_str+"_FK upper arm L"),
getNodeByName(char_str+"_IK arm flip angle L"),
getNodeByName(char_str+"_FK foot R"),
getNodeByName(char_str+"_FK shin R"),
getNodeByName(char_str+"_FK thigh R"),
getNodeByName(char_str+"_FK foot L"),
getNodeByName(char_str+"_FK shin L"),
getNodeByName(char_str+"_FK thigh L"),
getNodeByName(char_str+"_Hip control"),
getNodeByName(char_str+"_Waist control"),
getNodeByName(char_str+"_Master control"))

--functions
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn alph_sort_files cur_ary=
(
		sort cur_ary
		sorted_ary=makeUniqueArray cur_ary
)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn get_highest_file cur_str=
	(
	cur_ary=getFiles cur_str
	alph_sort_files cur_ary
	if cur_ary.count>0 then cur_file=cur_ary[cur_ary.count]
	)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--references to external functions
rig_fn_def_file=get_highest_file (root_path+@"scripts\rigging\rig_fn_def_v*.ms")
anm_fn_def_file=get_highest_file (root_path+@"scripts\anm\anm_fn_def_v*.ms")
shot_fn_def_file=get_highest_file (root_path+@"scripts\shot\shot_fn_def_v*.ms")

filein rig_fn_def_file
filein anm_fn_def_file
filein shot_fn_def_file
------------------
--FILE PATHS
------------------
--create char model, map and psd paths
mg_shot.cr_charmodel_paths root_path char_str
	
--create shot and render paths
mg_shot.cr_shot_paths root_path scene_str shot_str
------------------------------------------------------------------------------------------
--create  v01 scene files
mg_shot.cr_init_scn root_path scene_str shot_str
------------------------------------------------------------------------------------------
-- setup lgt scene file based on anm file
mg_shot.cr_lgt root_path scene_str shot_str
------------------------------------------------------------------------------------------
-- setup cloth scene file based on anm file
mg_shot.cr_cloth root_path scene_str shot_str
------------------------------------------------------------------------------------------
---------------------------------
-- CREATE RENDER PASSES
---------------------------------
-- setup rpf scene file based on lighting file
mg_shot.cr_rpf root_path scene_str shot_str

-- setup aoc scene file based on lighting file
mg_shot.cr_aoc_char root_path scene_str shot_str

-- setup aoc scene file based on lighting file
mg_shot.cr_aoc_bgrd root_path scene_str shot_str

-- setup nrm bgrd scene file based on lighting file
mg_shot.cr_nrm_bgrd root_path scene_str shot_str

-- setup eye scene file based on lighting file
mg_shot.cr_eye root_path scene_str shot_str

-- setup brw scene file based on lighting file
mg_shot.cr_brw root_path scene_str shot_str

-- setup msk scene file based on lighting file
mg_shot.cr_msk root_path scene_str shot_str

--rpf pass. set char obj ids
mg_rig.set_obj_ids char_str
------------------------------------------------------------------------------------------
-------------------
--ANIMATION
-------------------
--upd anmrig load and latest xaf animation

mg_shot.upd_anmrig scene_str shot_str root_path

--save xaf and upd anmrig load and latest xaf animation
disableSceneRedraw();
mg_shot.save_xaf_upd_anm scene_str shot_str root_path char_rig_ary
enableSceneRedraw()
------------------------------------------------------------------------------------------
---------------------------------
-- CLOTH
---------------------------------
--load sim cloth, morph render cloth to it and export cloth for scene import
mg_shot.render_cloth_prep scene_str shot_str root_path
------------------------------------------------------------------------------------------
--update cloth
--mg_shot.cloth_upd char_str scene_str shot_str root_path
mg_shot.cloth_upd_scene char_str scene_str shot_str root_path

--update all chars cloth
mg_shot.cloth_upd_scene_all scene_str shot_str root_path
-------------------
--LIGHTING
-------------------
--imp rndrig load and latest xaf animation single character
mg_shot.imp_rndrig char_str scene_str shot_str root_path

--imp rndrig load and latest xaf animation all characters
mg_shot.imp_rndrig_lgt scene_str shot_str root_path

/*
--multiple shot loop
for num in 120 to 210 by 10 do 

(

-- get and add code for determining padding
	shot_str="sh"+"0"+(num as string)
	mg_shot.cr_shot_paths root_path scene_str shot_str
	
)
*/