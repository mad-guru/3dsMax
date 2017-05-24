-- body
face_sel=#{399..534, 536..919, 931, 936..942, 953..1893, 1905..1912, 1919..1935, 1977..2040, 2042..2050, 2449..2584, 2586..2969, 2981, 2986..2992, 3003..3943, 3955..3962, 3969..3985, 4027..4090, 4092..4100}
cur_body=getNodeByName(char_str+"_body")

cur_body.EditablePoly.SetSelection #Face face_sel
--cur_body.EditablePoly.delete #Face
cur_body.EditablePoly.hide #Face

mg_rig.cr_morph_setup char_str fc_ctrls_file char_face_trg_file char_tng_trg_file

body_bn_ary=#((getNodeByName(char_str+"_Bone head")),(getNodeByName(char_str+"_Bone jaw")))
mg_rig.add_skin char_str (getNodeByName(char_str+"_body")) body_bn_ary char_body_env_file -50
(getNodeByName(char_str+"_body")).parent=(getNodeByName(char_str+"_Bone head"))