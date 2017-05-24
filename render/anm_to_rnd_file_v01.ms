------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- user defined variables
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
char_str="riz"
--rend, cloth or anim
rig_type="rend"
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
	
char_rnd_rig_file=mg_rig.highest_version (root_path+ @"models\char\"+char_str+@"\rig\rnd\"+char_str+@"_rig_v*.max")

execute ("select $"+char_str+"*")
delete selection
	
mergeMAXFile char_rnd_rig_file

--get controls layer and create tmp_ary that contains the layer nodes	
controls_layer=LayerManager.getLayerFromName (char_str+" - Controls")--layermanager.getlayer 1
controls_layer.nodes &tmp_ary
	
--char_runup_xaf_file=(root_path+@"models\char\"+char_str+@"\rig\xaf\"+char_str+"_clothpose_"+"-50_-20.xaf")
anim_path= substitutestring maxFilePath "anm" "xaf"
char_xaf_file=get_highest_file (anim_path+char_str+@"*v*.xaf")
mg_anm.load_anm char_xaf_file tmp_ary false false 0
