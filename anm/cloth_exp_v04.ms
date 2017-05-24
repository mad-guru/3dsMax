------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- user defined variables
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
char_str="riz"
scene_str="sc02"
shot_str="sh0047"
root_path=@"d:\projects\pd\"

letter_ary=#("l","r")

--functions
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn get_highest_file cur_str=
	(
	cur_ary=getFiles cur_str
	alph_sort_files cur_ary
	if cur_ary.count>0 then cur_file=cur_ary[cur_ary.count]
	)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn alph_sort_files cur_ary=
(
		sort cur_ary
		sorted_ary=makeUniqueArray cur_ary
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
--create rnd rig
------------------

--variables
rig_type="rend"
ctrlobj_mult=1
ctrl_dist=2.5*ctrlobj_mult

mg_shot.cr_rndrig char_str root_path letter_ary rig_type ctrlobj_mult ctrl_dist

--version up
last_rig_file=get_highest_file(root_path+@"models\char\"+char_str+@"\rig\rnd\"+char_str+@"_rig_v*.max")
last_file=filenamefrompath last_rig_file
last_path=pathConfig.removePathLeaf last_rig_file
next_num_str=mg_shot.ver_up_num char_str last_file
next_file=char_str+"_rig_v"+next_num_str+".max"
saveMaxFile (last_path+@"\"+next_file) quiet:true

--bring render rig into lighting scene file
mg_shot.imp_rndrig char_str scene_str shot_str root_path

--load animation
xaf_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\xaf\"+char_str+"_"+scene_str+"_"+shot_str+"_v*.xaf")
ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
ctrl_layer.nodes &obj_ary

mg_anm.load_anm xaf_file obj_ary false true 0

--version up lighting file
last_rig_file=get_highest_file (root_path+@"shots\"+scene_str+@"\"+shot_str+@"\lgt\"+scene_str+@"_"+shot_str+@"_v*.max")
last_file=filenamefrompath last_rig_file
last_path=pathConfig.removePathLeaf last_rig_file
mg_shot.ver_up_num char_str last_file
next_file=scene_str+"_"+shot_str+"_v"+next_num_str+".max"
saveMaxFile (last_path+@"\"+next_file) quiet:true

--load sim cloth, morph render cloth to it and export cloth for scene import
mg_shot.render_cloth_prep scene_str shot_str root_path

--update cloth
mg_shot.cloth_upd char_str scene_str shot_str root_path

--imp rndrig
mg_shot.imp_rndrig char_str scene_str shot_str root_path
