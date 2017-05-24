--creates a morph setup with ctrls to test and improve morph targets
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- user defined variables
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
char_str="riz"
root_path=@"c:\temp\projects\pd\"
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
char_skel_file=mg_rig.highest_version (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_bn_v*.max")
char_cal_xaf_file=mg_rig.get_highest_file (root_path+@"models\char\calisthenics_v*.xaf")
char_runup_xaf_file=(root_path+@"models\char\"+char_str+@"\rig\xaf\"+char_str+"_clothpose_"+"-50_-20.xaf")
char_tng_trg_file=mg_rig.highest_version (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_tng_trg_v*.max")
char_anim_parts_file=mg_rig.highest_version (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_anim_parts_v*.max")
char_mdl_file=mg_rig.highest_version (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+"_mdl_v*.max")
char_body_env_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_body_v*.env")

fc_ctrls_file=mg_rig.highest_version (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_fc_ctrls_v*.max")
char_face_trg_file=mg_rig.highest_version (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_morph_v*.max")
char_tng_trg_file=mg_rig.highest_version (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_tng_trg_v*.max")

filein rig_fn_def_file
filein anm_fn_def_file

mergeMAXFile char_mdl_file
delete $*nails*
delete $*body_r

(getNodeByName(char_str+"_brows")).modifiers[#Shell].enabled=true

obj_ary=$*_fn_*

--facial animation setup
-- body
face_sel=#{782..1049, 1052..1816, 1825..1826, 1837..1846, 1849..1862, 1873..1880, 1883..3715, 3736..3753, 3766..3799, 3882..4005, 4008..4025, 4807..5074, 5077..5841, 5850..5851, 5862..5871, 5874..5887, 5898..5905, 5908..7740, 7761..7778, 7791..7824, 7907..8030, 8033..8050}
cur_body=getNodeByName(char_str+"_body")
		
--classof $==Editable_mesh
if classof cur_body==Editable_Poly then (polyop.setHiddenFaces cur_body face_sel)
else (meshop.setHiddenFaces cur_body face_sel)

mg_rig.cr_morph_setup char_str fc_ctrls_file char_face_trg_file char_tng_trg_file false

--create eye mtl
eye_mtl = Standardmaterial ()
eye_mtl.diffuseMap = Bitmaptexture fileName:@"C:\temp\projects\pd\maps\char\all\eye_c_small.jpg"
eye_mtl.showInViewport = on
eye_mtl.name = "ref_eye"
	
delete (getNodeByName(char_str+"_eyelns_l"))
delete (getNodeByName(char_str+"_eyelns_r"))
	
(getNodeByName(char_str+"_eye_r")).material=eye_mtl
(getNodeByName(char_str+"_eye_l")).material=eye_mtl