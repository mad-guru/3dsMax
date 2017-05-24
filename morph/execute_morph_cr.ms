------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- user defined variables
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
char_str="wal"
ref_str="nmy"

root_path=@"d:\projects\pd\"

letter_ary=#("l","r")

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
morph_fn_def_file=get_highest_file (root_path+@"scripts\morph\morph_fn_def_v*.ms")
shot_fn_def_file=get_highest_file (root_path+@"scripts\shot\shot_fn_def_v*.ms")

filein morph_fn_def_file
filein shot_fn_def_file
------------------
--run functions
------------------
------------------------
-- create body morphs
------------------------	
-- load model file
char_model_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+@"_mdl_v*.max")
	
loadMaxFile char_model_file quiet:true
delete $*body_r
unhide (getNodeByName(char_str+"_body"))
	
-- merge ref char morph file
ref_morph_file=get_highest_file (root_path+@"models\char\"+ref_str+@"\mdl\morph\"+ref_str+@"_msource_v*.max")
mergeMAXFile ref_morph_file
	
--create initial morph targets for a character
mg_morph.cr_intial_mt root_path char_str ref_str "_body"

execute ("delete $"+ref_str+"*")

--get ver number for save
last_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+"_msource_v*.max")

-- save file
	if last_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_file
		saveMaxFile (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+"_msource_v"+up_num+".max")  quiet:true
	)
	else saveMaxFile (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+"_msource_v01.max")  quiet:true
	

------------------------
-- create tng morphs
------------------------	
-- load model file
char_model_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+@"_mdl_v*.max")
	
loadMaxFile char_model_file quiet:true
delete $*body_r
	
-- merge ref char morph file
ref_morph_file=get_highest_file (root_path+@"models\char\"+ref_str+@"\mdl\morph\"+ref_str+@"_tng_trg_v*.max")
mergeMAXFile ref_morph_file
	
--create initial morph targets for a character
mg_morph.cr_intial_mt root_path char_str ref_str "_tng"

execute ("delete $"+ref_str+"*")
	
--get ver number for save
last_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+"_tng_trg_v*.max")

-- save file
	if last_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_file
		saveMaxFile (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+"_tng_trg_v"+up_num+".max")  quiet:true
	)
	else saveMaxFile (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+"_tng_trg_v01.max")  quiet:true	


------------------------
-- create eye morphs
------------------------	
-- load model file
char_model_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\"+char_str+@"_mdl_v*.max")
	
loadMaxFile char_model_file quiet:true
delete $*body_r
	
-- merge ref char morph file
ref_morph_file=get_highest_file (root_path+@"models\char\"+ref_str+@"\mdl\morph\"+ref_str+@"_eye_trg_v*.max")
mergeMAXFile ref_morph_file
	
--create initial morph targets for a character
mg_morph.cr_intial_mt root_path char_str ref_str "_eye"

execute ("delete $"+ref_str+"*")
	
--get ver number for save
last_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+"_eye_trg_v*.max")

-- save file
	if last_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_file
		saveMaxFile (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+"_eye_trg_v"+up_num+".max")  quiet:true
	)
	else saveMaxFile (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+"_eye_trg_v01.max")  quiet:true	


------------------------	
--create split morphs
------------------------
char_morph_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_msource_v*.max")
	
loadMaxFile char_morph_file quiet:true
	
mg_morph.cr_split_morph char_str

--get ver number for save
last_file=get_highest_file (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_morph_v*.max")
	
-- save file
	if last_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_file
		saveMaxFile (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+"_morph_v"+up_num+".max")  quiet:true
	)
	else saveMaxFile (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+"_morph_v01.max")  quiet:true