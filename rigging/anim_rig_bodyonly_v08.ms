------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- user defined variables
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
char_str="bts"
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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ctrlobj_mult=1
ctrl_dist=2.5*ctrlobj_mult

--filein rig_start_file
char_skel_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_bn_v*.max")
char_mdl_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+@"_mdl_v*.max")
char_body_env_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_body_v*.env")

char_head_env_file=get_highest_file (root_path+@"models\char\_all\rig\env\anm_body_v01.env")
	
char_kamz_env_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_kamz_v*.env")
char_shlw_env_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_shlw_v*.env")
char_cal_xaf_file=get_highest_file (root_path+@"models\char\calisthenics_v*.xaf")
char_runup_xaf_file=(root_path+@"models\char\"+char_str+@"\rig\xaf\"+char_str+"_clothpose_"+"-50_-20.xaf")
fc_ctrls_file=get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_fc_ctrls_v*.max")
char_face_trg_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_morph_v*.max")
char_tng_trg_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_tng_trg_v*.max")
char_eye_trg_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_eye_trg_v*.max")

--chappal
char_chpl_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+@"_chpl_v*.max")
char_chpl_env_l_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_chpl_l_v*.env")
char_chpl_env_r_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_chpl_r_v*.env")

--anim
char_anim_parts_file=mg_rig.highest_version (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_anim_parts_v*.max")

loadMaxFile char_skel_file

saveMaxFile (root_path+@"models\char\char_temp.max")  quiet:true

--create ctrl obj for toes and jaw. make the parts into bones, put them in the right layers
mg_rig.cr_extra_ctrls char_str letter_ary

mergeMAXFile char_mdl_file
delete $*nails*
delete $*body_r

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

--anim specific
(getNodeByName (char_str+"_body")).renderable=true	
(getNodeByName(char_str+"_brows")).modifiers[#Shell].enabled=true
if (getNodeByName(char_str+"_hair"))!=undefined then (getNodeByName(char_str+"_hair")).parent=(getNodeByName(char_str+"_Bone head"))

body_bn_ary=#((getNodeByName(char_str+"_Bone head")),(getNodeByName(char_str+"_Bone jaw")))
--rnd rig:
--mg_rig.add_skin char_str (getNodeByName(char_str+"_body")) body_bn_ary char_body_env_file -50
--anm rig:
mg_rig.add_skin char_str (getNodeByName(char_str+"_body")) body_bn_ary char_head_env_file -50
	
unhide (getNodeByName(char_str+"_body"))
	
(getNodeByName(char_str+"_body")).modifiers[#Skin].weightAllVertices = off
	
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
controls_layer=LayerManager.getLayerFromName (char_str+" - Controls")
controls_layer.nodes &obj_ary

--create chappal setup
mg_rig.chpl_setup char_str letter_ary char_chpl_file char_chpl_env_l_file char_chpl_env_r_file

-- last val is 0 so it brings in on same frame as xaf file was saved
-- load cloth runup
mg_anm.sel_char_parts char_str char_rig_ary undefined
mg_anm.load_anm char_runup_xaf_file (selection as array) false false 0

slidertime=-50
	
mergeMaxfile char_anim_parts_file
					
obj_ary=$*anim*
					
for cur_obj in obj_ary do
	(
		cur_str=substituteString cur_obj.name "anim" "Bone"
		cur_str_ary=filterString cur_str "_"
		par_str=(substituteString cur_str ("_"+cur_str_ary[cur_str_ary.count]) "")
--		print (getNodeByName par_str).name
		cur_obj.parent=(getNodeByName par_str)
	)
	
rnd_layer=LayerManager.getLayerFromName (char_str+" - Render")
	
if rnd_layer==undefined do
	(
		LayerManager.newLayerFromName (char_str+" - Render")
		rnd_layer=LayerManager.getLayerFromName (char_str+" - Render")
	)
/*	
		for cur_obj in tmp_ary do
		(
		if cur_obj !=undefined do rnd_layer.addNode cur_obj
		)
*/	
obj_ary=$*_fn_*

--facial animation setup
-- body
cur_body=getNodeByName(char_str+"_body")
		
--classof $==Editable_mesh
if classof cur_body==Editable_Poly or classof cur_body==PolyMeshObject then
(
face_sel=#{399..534, 536..919, 931, 936..942, 953..1893, 1905..1907, 1909, 1920, 1922..1935, 1977..2040, 2042..2050, 2449..2584, 2586..2969, 2981, 2986..2992, 3003..3943, 3955..3957, 3959, 3972..3985, 4027..4090, 4092..4100}
polyop.setHiddenFaces cur_body face_sel
)
else
(
face_sel=#{782..1049, 1052..1816, 1825..1826, 1837..1846, 1849..1862, 1873..1880, 1883..3715, 3736..3753, 3766..3799, 3882..4005, 4008..4025, 4807..5074, 5077..5841, 5850..5851, 5862..5871, 5874..5887, 5898..5905, 5908..7740, 7761..7778, 7791..7824, 7907..8030, 8033..8050}
meshop.setHiddenFaces cur_body face_sel
)

-- define finger controls ary
obj_ary=#((getNodeByName(char_str+"_Bone thumb L-01")),
(getNodeByName(char_str+"_Bone thumb L-02")),
(getNodeByName(char_str+"_Bone thumb L-03")),
(getNodeByName(char_str+"_Bone finger index L-01")),
(getNodeByName(char_str+"_Bone finger index L-02")),
(getNodeByName(char_str+"_Bone finger index L-03")),
(getNodeByName(char_str+"_Bone finger middle L-01")),
(getNodeByName(char_str+"_Bone finger middle L-02")),
(getNodeByName(char_str+"_Bone finger middle L-03")),
(getNodeByName(char_str+"_Bone finger ring L-01")),
(getNodeByName(char_str+"_Bone finger ring L-02")),
(getNodeByName(char_str+"_Bone finger ring L-03")),
(getNodeByName(char_str+"_Bone finger little L-01")),
(getNodeByName(char_str+"_Bone finger little L-02")),
(getNodeByName(char_str+"_Bone finger little L-03")),
(getNodeByName(char_str+"_Bone thumb R-01")),
(getNodeByName(char_str+"_Bone thumb R-02")),
(getNodeByName(char_str+"_Bone thumb R-03")),
(getNodeByName(char_str+"_Bone finger index R-01")),
(getNodeByName(char_str+"_Bone finger index R-02")),
(getNodeByName(char_str+"_Bone finger index R-03")),
(getNodeByName(char_str+"_Bone finger middle R-01")),
(getNodeByName(char_str+"_Bone finger middle R-02")),
(getNodeByName(char_str+"_Bone finger middle R-03")),
(getNodeByName(char_str+"_Bone finger ring R-01")),
(getNodeByName(char_str+"_Bone finger ring R-02")),
(getNodeByName(char_str+"_Bone finger ring R-03")),
(getNodeByName(char_str+"_Bone finger little R-01")),
(getNodeByName(char_str+"_Bone finger little R-02")),
(getNodeByName(char_str+"_Bone finger little R-03")))
	/*
cur_layer=controls_layer
-- add finger ctrls to controls_layer
for cur_obj in obj_ary do (cur_layer.addNode cur_obj)

-- create facial animation setup
mg_rig.cr_morph_setup char_str fc_ctrls_file char_face_trg_file char_tng_trg_file char_eye_trg_file true

-- add face ctrls to controls_layer
obj_ary=$*_fc_*
fc_layer=controls_layer

for cur_obj in obj_ary do
(	
fc_layer.addNode cur_obj
)

fc_layer.on=false
*/
bn_layer=LayerManager.getLayerFromName (char_str+" - Bones")
bn_layer.on=false

(getNodeByName(char_str+"_brows")).modifiers[#Shell].enabled=true
/*
if (getNodeByName(char_str+"_anim head_body"))!=undefined then delete (getNodeByName(char_str+"_anim head_body"))
if (getNodeByName(char_str+"_anim jaw_body"))!=undefined then delete (getNodeByName(char_str+"_anim jaw_body"))
*/
hair_ary=#(getNodeByName(char_str+"_hair"),getNodeByName(char_str+"_bun"))	

for cur_hair in hair_ary do
	(	
		if cur_hair!=undefined do
			(
				if classof cur_hair.modifiers[cur_hair.modifiers.count]==Skin_Wrap then deleteModifier cur_hair (cur_hair.modifiers.count)
				cur_hair.parent=getNodeByName(char_str+"_Bone head")
			)
	)

--create eye mtl
eye_mtl = Standardmaterial ()
eye_mtl.diffuseMap = Bitmaptexture fileName:@"d:\projects\pd\maps\char\all\eye_c_small.jpg"
eye_mtl.showInViewport = on
eye_mtl.name = "ref_eye"
	
delete (getNodeByName(char_str+"_eyelns_l"))
delete (getNodeByName(char_str+"_eyelns_r"))
	
(getNodeByName(char_str+"_eye_r")).material=eye_mtl
(getNodeByName(char_str+"_eye_l")).material=eye_mtl
	
--create eye displace spheres
mg_rig.cr_eyedispl char_str


-- layer cleanup

--add eye pts to hidden layer
cur_layer=LayerManager.getLayerFromName (char_str+" - Hidden")
cur_ary=$*_eye_*_pt01 as array
--cur_layer.nodes &selection
for cur_node in cur_ary do (cur_layer.addNode cur_node)

(getNodeByName(char_str+"_Bone jaw")).renderable=false
	
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

execute ("delete $"+char_str+"_body")
