------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- user defined variables
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
char_str="riz"
root_path=@"d:\projects\pd\"
letter_ary=#("l","r")
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

rig_fn_def_file=get_highest_file (root_path+@"scripts\rigging\rig_fn_def_v*.ms")
anm_fn_def_file=get_highest_file (root_path+@"scripts\anm\anm_fn_def_v*.ms")

filein rig_fn_def_file
filein anm_fn_def_file
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ctrlobj_mult=1
ctrl_dist=2.5*ctrlobj_mult

--filein rig_start_file
char_skel_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_bn_v*.max")
char_mdl_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+@"_mdl_v*.max")
char_body_env_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_body_v*.env")
char_kamz_env_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_kamz_v*.env")
char_shlw_env_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_shlw_v*.env")
char_cal_xaf_file=get_highest_file (root_path+@"models\char\calisthenics_v*.xaf")
char_runup_xaf_file=(root_path+@"models\char\"+char_str+@"\rig\xaf\"+char_str+"_clothpose_"+"-50_-20.xaf")
fc_ctrls_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_fc_ctrls_v*.max")
char_face_trg_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_morph_v*.max")
char_tng_trg_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_tng_trg_v*.max")
char_eye_trg_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_eye_trg_v*.max")

--cloth
char_rigged_file=get_highest_file (root_path+ @"models\char\"+char_str+@"\rig\rnd\"+char_str+@"_rig_v*.max")
char_cloth_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_cloth_v*.max")
char_rig_cloth_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_rig_cloth_v*.max")
char_sim_cloth_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_sim_cloth_v*.max")
char_sel_cloth_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_sel_cloth_v*.max")
char_skin_cloth_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_skin_cloth_v*.max")

--chappal
char_chpl_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+@"_chpl_v*.max")
char_chpl_env_l_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_chpl_l_v*.env")
char_chpl_env_r_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_chpl_r_v*.env")

loadMaxFile char_skel_file

--create ctrl obj for toes and jaw. make the parts into bones, put them in the right layers
mg_rig.cr_extra_ctrls char_str letter_ary

mergeMAXFile char_mdl_file
mg_rig.set_obj_ids

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

body_bn_ary=mg_rig.alph_sort_ary(execute ("$"+char_str+"_Bone*") as array)
mg_rig.add_skin char_str (getNodeByName(char_str+"_body")) body_bn_ary char_body_env_file -50

mg_rig.cr_eye_setup char_str letter_ary ctrlobj_mult

--jaw setup
(getNodeByName(char_str+"_"+"teethtop")).parent=getNodeByName(char_str+"_"+"Bone head")
(getNodeByName(char_str+"_"+"topgums")).parent=getNodeByName(char_str+"_"+"Bone head")

(getNodeByName(char_str+"_"+"teethbtm")).parent=getNodeByName(char_str+"_"+"Bone jaw")	
(getNodeByName(char_str+"_"+"btmgums")).parent=getNodeByName(char_str+"_"+"Bone jaw")
(getNodeByName(char_str+"_"+"tng")).parent=getNodeByName(char_str+"_"+"Bone jaw")
					
framerate=24
animationRange=(interval -50f 450f)
sliderTime=-50
controls_layer=LayerManager.getLayerFromName (char_str+" - Controls")
controls_layer.nodes &tmp_ary

--create chappal setup
mg_rig.chpl_setup char_str letter_ary char_chpl_file char_chpl_env_l_file char_chpl_env_r_file

-- last val is 0 so it brings in on same frame as xaf file was saved
-- load cloth runup
mg_anm.sel_char_parts char_str char_rig_ary undefined
mg_anm.load_anm char_runup_xaf_file (selection as array) false false 0

mergeMAXFile char_skin_cloth_file

kamz_bn_ary=#(
(getNodeByName(char_str+"_Bone pelvis")),
(getNodeByName(char_str+"_Bone hip L")),
(getNodeByName(char_str+"_Bone thigh L-01")),
(getNodeByName(char_str+"_Bone thigh L-02")),
(getNodeByName(char_str+"_Bone thigh L-03")),
(getNodeByName(char_str+"_Bone hip R")),
(getNodeByName(char_str+"_Bone thigh R-01")),
(getNodeByName(char_str+"_Bone thigh R-02")),
(getNodeByName(char_str+"_Bone thigh R-03")),
(getNodeByName(char_str+"_Bone spine-01")),
(getNodeByName(char_str+"_Bone spine-02")),
(getNodeByName(char_str+"_Bone spine-03")),
(getNodeByName(char_str+"_Bone clavicle L")),
(getNodeByName(char_str+"_Bone forearm R-03")),
(getNodeByName(char_str+"_Bone forearm R-02")),
(getNodeByName(char_str+"_Bone forearm R-01")),
(getNodeByName(char_str+"_Bone elbow R")),
(getNodeByName(char_str+"_Bone upper arm R-03")),
(getNodeByName(char_str+"_Bone upper arm R-02")),
(getNodeByName(char_str+"_Bone forearm L-02")),
(getNodeByName(char_str+"_Bone forearm L-03")),
(getNodeByName(char_str+"_Bone upper arm R-01")),
(getNodeByName(char_str+"_Bone clavicle R")),
(getNodeByName(char_str+"_Bone shoulder R")),
(getNodeByName(char_str+"_Bone hand R")),
(getNodeByName(char_str+"_Bone elbow L")),
(getNodeByName(char_str+"_Bone upper arm L-03")),
(getNodeByName(char_str+"_Bone upper arm L-02")),
(getNodeByName(char_str+"_Bone upper arm L-01")),
(getNodeByName(char_str+"_Bone shoulder L")),
(getNodeByName(char_str+"_Bone forearm L-01")),
(getNodeByName(char_str+"_Bone hand L")),
(getNodeByName(char_str+"_Bone chest"))
)

mg_rig.add_skin char_str (getNodeByName(char_str+"_kamz_cloth")) kamz_bn_ary char_kamz_env_file -50

shlw_bn_ary=#(
(getNodeByName(char_str+"_Bone pelvis")),
(getNodeByName(char_str+"_Bone hip L")),
(getNodeByName(char_str+"_Bone thigh L-01")),
(getNodeByName(char_str+"_Bone thigh L-02")),
(getNodeByName(char_str+"_Bone thigh L-03")),
(getNodeByName(char_str+"_Bone knee L")),
(getNodeByName(char_str+"_Bone shin L-01")),
(getNodeByName(char_str+"_Bone shin L-02")),
(getNodeByName(char_str+"_Bone shin L-03")),
(getNodeByName(char_str+"_Bone hip R")),
(getNodeByName(char_str+"_Bone thigh R-01")),
(getNodeByName(char_str+"_Bone thigh R-02")),
(getNodeByName(char_str+"_Bone thigh R-03")),
(getNodeByName(char_str+"_Bone knee R")),
(getNodeByName(char_str+"_Bone shin R-01")),
(getNodeByName(char_str+"_Bone shin R-02")),
(getNodeByName(char_str+"_Bone shin R-03")),
(getNodeByName(char_str+"_Bone spine-01"))
)

mg_rig.add_skin char_str (getNodeByName(char_str+"_shlw_cloth")) shlw_bn_ary char_shlw_env_file -50

-- run these if the files don't exist. will have to reevaluate the file values above afterwards
/*
mg_rig.cr_mt_file char_str "body"
mg_rig.cr_mt_file char_str "tng"
*/	
	
mg_rig.cr_morph_setup char_str fc_ctrls_file char_face_trg_file char_tng_trg_file char_eye_trg_file true

-- add face ctrls to controls_layer
obj_ary=$*_fc_*
fc_layer=controls_layer

for cur_obj in obj_ary do
(	
fc_layer.addNode cur_obj
)

--create eye displace spheres
mg_rig.cr_eyedispl char_str
	
(getNodeByName(char_str+"_Bone jaw")).renderable=false

-- layer cleanup

--add eye pts to hidden layer
cur_layer=LayerManager.getLayerFromName (char_str+" - Hidden")
cur_ary=$*_eye_*_pt01 as array
--cur_layer.nodes &selection
for cur_node in cur_ary do (cur_layer.addNode cur_node)

-- add chpl controls to control layer
cur_layer=LayerManager.getLayerFromName (char_str+" - Controls")
cur_ary=$*_chpl01_*control as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)

cur_layer=LayerManager.getLayerFromName (char_str+" - Hidden")
cur_ary=$*_chpl01_bn_*_end_ikchain as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)


-- chpl bones in bones layer
cur_layer=LayerManager.getLayerFromName (char_str+" - Bones")
cur_ary=$*_chpl01_bn_l as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)
cur_ary=$*_chpl01_bn_r as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)
cur_ary=$*_chpl01_bn_l_end as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)
cur_ary=$*_chpl01_bn_r_end as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)

-- chpl render layer
cur_layer=LayerManager.getLayerFromName (char_str+" - Render")
cur_ary=$*_chpl_top_* as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)
cur_ary=$*_chpl_btm_* as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)

(getNodeByName(char_str+"_Bone jaw")).renderable=false