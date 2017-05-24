------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- user defined variables
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
char_str="bab"
root_path=@"d:\projects\pd\"
letter_ary=#("l","r")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ctrlobj_mult=1
ctrl_dist=2.5*ctrlobj_mult
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

--filein rig_start_file
char_skel_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_bn_v*.max")
char_cal_xaf_file=get_highest_file (root_path+@"models\char\calisthenics_v*.xaf")
char_runup_xaf_file=(root_path+@"models\char\"+char_str+@"\rig\xaf\"+char_str+"_clothpose_"+"-50_-20.xaf")
char_tng_trg_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_tng_trg_v*.max")
char_anim_parts_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_anim_parts_v*.max")
char_mdl_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+"_mdl_v*.max")
char_body_env_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_body_v*.env")

fc_ctrls_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_fc_ctrls_v*.max")
char_face_trg_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_morph_v*.max")
char_tng_trg_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_tng_trg_v*.max")
char_eye_trg_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_eye_trg_v*.max")

--chappal
char_chpl_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+@"_chpl_v*.max")
char_chpl_env_l_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_chpl_l_v*.env")
char_chpl_env_r_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_chpl_r_v*.env")

-- cloth related
char_kamz_env_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_kamz_v*.env")
char_shlw_env_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_shlw_v*.env")
char_dpt_env_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_dpt_v*.env")
char_pkt_env_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_pkt_v*.env")
cal_xaf_file=root_path+@"models\char\calisthenics_v01.xaf"

--cloth
--char_rigged_file=get_highest_file (root_path+ @"models\char\"+char_str+@"\rig\rnd\"+char_str+@"_rig_v*.max")
char_sim_cloth_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_sim_cloth_v*.max")
char_sel_cloth_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_sel_cloth_v*.max")
char_skin_cloth_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_skin_cloth_v*.max")

filein rig_fn_def_file
filein anm_fn_def_file

loadMaxFile char_skel_file

saveMaxFile (root_path+@"models\char\char_temp.max")  quiet:true

mg_rig.cr_extra_ctrls char_str letter_ary

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

mergeMAXFile char_mdl_file

delete $*nails*
delete (getNodeByName(char_str+"_body_r"))

(getNodeByName(char_str+"_brows")).modifiers[#Shell].enabled=true
if (getNodeByName(char_str+"_hair"))!=undefined then
(getNodeByName(char_str+"_hair")).parent=(getNodeByName(char_str+"_Bone head"))
	
--if rig_type=="rend" do
	(
		body_bn_ary=mg_rig.alph_sort_ary(execute ("$"+char_str+"_Bone*") as array)
		mg_rig.add_skin char_str (getNodeByName(char_str+"_body")) body_bn_ary char_body_env_file -50
	)
	
mg_rig.cr_eye_setup char_str letter_ary ctrlobj_mult

--jaw setup
(getNodeByName(char_str+"_"+"teethtop")).parent=getNodeByName(char_str+"_"+"Bone head")
(getNodeByName(char_str+"_"+"topgums")).parent=getNodeByName(char_str+"_"+"Bone head")

(getNodeByName(char_str+"_"+"teethbtm")).parent=getNodeByName(char_str+"_"+"Bone jaw")	
(getNodeByName(char_str+"_"+"btmgums")).parent=getNodeByName(char_str+"_"+"Bone jaw")
(getNodeByName(char_str+"_"+"tng")).parent=getNodeByName(char_str+"_"+"Bone jaw")
					
framerate=8
animationRange=(interval -50f 100f)
sliderTime=-50
controls_layer=LayerManager.getLayerFromName (char_str+" - Controls")--layermanager.getlayer 1
controls_layer.nodes &obj_ary
	
--create chappal setup
mg_rig.chpl_setup char_str letter_ary char_chpl_file char_chpl_env_l_file char_chpl_env_r_file
	
-- last val is 0 so it brings in on same frame as xaf file was saved
-- load cloth runup
mg_anm.sel_char_parts char_str char_rig_ary undefined
mg_anm.load_anm char_runup_xaf_file (selection as array) false false 0
	
sliderTime=-50
	
mergeMaxFile char_sim_cloth_file
	
zero_layer=layermanager.getlayer 0
zero_layer.nodes &tmp_ary

mg_rig.cr_layer tmp_ary (char_str+" - Render")

--not needed unless maintaining cloth panels
--mg_anm.cloth_panelprep ($*cloth as array)

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

if (getNodeByName(char_str+"_dpt_cloth"))!=undefined then
	(
		dpt_bn_ary=#(
		(getNodeByName(char_str+"_Bone spine-01")),
		(getNodeByName(char_str+"_Bone spine-02")),
		(getNodeByName(char_str+"_Bone spine-03")),
		(getNodeByName(char_str+"_Bone clavicle L")),
		(getNodeByName(char_str+"_Bone clavicle R")),
		(getNodeByName(char_str+"_Bone shoulder R")),
		(getNodeByName(char_str+"_Bone upper arm L-03")),
		(getNodeByName(char_str+"_Bone upper arm L-02")),
		(getNodeByName(char_str+"_Bone upper arm L-01")),
		(getNodeByName(char_str+"_Bone shoulder L")),
		(getNodeByName(char_str+"_Bone chest"))
		)
		mg_rig.add_skin char_str (getNodeByName(char_str+"_dpt_cloth")) dpt_bn_ary char_kmz_env_file -50
	)
	

if (getNodeByName(char_str+"_pkt_cloth"))!=undefined then
	(
		pkt_bn_ary=#(
		(getNodeByName(char_str+"_Bone spine-01")),
		(getNodeByName(char_str+"_Bone spine-02")),
		(getNodeByName(char_str+"_Bone spine-03")),
		(getNodeByName(char_str+"_Bone clavicle L")),
		(getNodeByName(char_str+"_Bone forearm R-03")),
		(getNodeByName(char_str+"_Bone forearm R-02")),
		(getNodeByName(char_str+"_Bone forearm R-01")),
		(getNodeByName(char_str+"_Bone upper arm R-03")),
		(getNodeByName(char_str+"_Bone upper arm R-02")),
		(getNodeByName(char_str+"_Bone upper arm R-01")),
		(getNodeByName(char_str+"_Bone clavicle R")),
		(getNodeByName(char_str+"_Bone shoulder R")),
		(getNodeByName(char_str+"_Bone upper arm L-03")),
		(getNodeByName(char_str+"_Bone upper arm L-02")),
		(getNodeByName(char_str+"_Bone upper arm L-01")),
		(getNodeByName(char_str+"_Bone shoulder L")),
		(getNodeByName(char_str+"_Bone chest"))
		)
		mg_rig.add_skin char_str (getNodeByName(char_str+"_pkt_cloth")) pkt_bn_ary char_kmz_env_file -50
	)
	
mg_anm.cloth_setup char_str (getNodeByName (char_str+"_body")) ($*_cloth as array)

--mergeMaxFile char_sel_cloth_file
	
--mg_anm.cloth_con_setup char_str (getNodeByName (char_str+"_body")) ($*cloth as array) ($*_sel_* as array)
	
-- arrange chpl parts in layers
cur_layer=LayerManager.getLayerFromName (char_str+" - Hidden")
cur_ary=$'*chpl01_bn_*_end_ikchain control' as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)

cur_ary=$'*_chpl_toe_pt_*' as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)

cur_layer=LayerManager.getLayerFromName (char_str+" - Bones")
cur_ary=$'*_chpl01_bn_*' as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)
	
cur_layer=LayerManager.getLayerFromName (char_str+" - Render")
cur_ary=$'*_chpl_btm_*' as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)

cur_ary=$'*_chpl_top_*' as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)

cur_layer=LayerManager.getLayerFromName (char_str+" - Controls")
cur_ary=$'*_chpl_* control' as array
for cur_node in cur_ary do (cur_layer.addNode cur_node)
