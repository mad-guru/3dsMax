char_str="riz"
root_path=@"c:\temp\projects\pd\"
char_skel_file=root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_bn_v01.max"
letter_ary=#("l","r")

ctrlobj_mult=1
ctrl_dist=2.5*ctrlobj_mult

rig_fn_def_file=root_path+@"scripts\rigging\rig_fn_def_v10.ms"
anm_fn_def_file=root_path+@"scripts\anm\anm_fn_def_v03.ms"

filein rig_fn_def_file
filein anm_fn_def_file

--filein rig_start_file
char_mdl_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+"_mdl_v*.max")
char_body_env_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_body_v*.env")
char_kamz_env_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_kamz_v*.env")
char_shlw_env_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_shlw_v*.env")
cal_xaf_file=mg_rig.get_highest_file (root_path+@"models\char\calisthenics_v01.xaf")
fc_ctrls_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_fc_ctrls_v*.max")
char_face_trg_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_morph_v*.max")
char_tng_trg_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_tng_trg_v*.max")

--cloth
char_rigged_file=mg_rig.get_highest_file (root_path+ @"models\char\"+char_str+@"\rig\rnd\"+char_str+@"_rig_v*.max")
char_cloth_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_cloth_v*.max")
char_rig_cloth_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_rig_cloth_v*.max")
char_sim_cloth_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_sim_cloth_v*.max")
char_sel_cloth_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_sel_cloth_v*.max")
char_skin_cloth_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\start\"+char_str+@"_skin_cloth_v*.max")

--chappal
char_chpl_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+"_chpl_*.max")
char_chpl_env_l_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_chpl_l_v*.env")
char_chpl_env_r_file=mg_rig.get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_chpl_r_v*.env")

mg_rig.chpl_setup char_str letter_ary char_chpl_file char_chpl_env_l_file char_chpl_env_r_file