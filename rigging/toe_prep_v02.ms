------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- user defined variables
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
char_str="nmy"
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
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
rig_fn_def_file=get_highest_file (root_path+@"scripts\rigging\rig_fn_def_v*.ms")
anm_fn_def_file=get_highest_file (root_path+@"scripts\anm\anm_fn_def_v*.ms")

filein rig_fn_def_file
filein anm_fn_def_file

--in coordsys (getNodeByName (char_str+"_Bone pelvis"))
--should be automated. run the whole script
	
-- MIRROR R TOES TO L

if (getNodeByName (char_str+"_Bone toe thumb L-01"))!=undefined do
(
--delete left toes if they are incorrect
	
toes_l_ary=#(getNodeByName (char_str+"_Bone toe thumb L-01"),
getNodeByName (char_str+"_Bone toe thumb L-02"),
getNodeByName (char_str+"_Bone toe thumb L-03"),
getNodeByName (char_str+"_Bone toe index L-01"),
getNodeByName (char_str+"_Bone toe index L-02"),
getNodeByName (char_str+"_Bone toe index L-03"),
getNodeByName (char_str+"_Bone toe middle L-01"),
getNodeByName (char_str+"_Bone toe middle L-02"),
getNodeByName (char_str+"_Bone toe middle L-03"),
getNodeByName (char_str+"_Bone toe ring L-01"),
getNodeByName (char_str+"_Bone toe ring L-02"),
getNodeByName (char_str+"_Bone toe ring L-03"),
getNodeByName (char_str+"_Bone toe little L-01"),
getNodeByName (char_str+"_Bone toe little L-02"),
getNodeByName (char_str+"_Bone toe little L-03"))

delete toes_l_ary	
)
	--select right toes
toes_r_ary=#(getNodeByName (char_str+"_Bone toe thumb R-01"),
getNodeByName (char_str+"_Bone toe thumb R-02"),
getNodeByName (char_str+"_Bone toe thumb R-03"),
getNodeByName (char_str+"_Bone toe index R-01"),
getNodeByName (char_str+"_Bone toe index R-02"),
getNodeByName (char_str+"_Bone toe index R-03"),
getNodeByName (char_str+"_Bone toe middle R-01"),
getNodeByName (char_str+"_Bone toe middle R-02"),
getNodeByName (char_str+"_Bone toe middle R-03"),
getNodeByName (char_str+"_Bone toe ring R-01"),
getNodeByName (char_str+"_Bone toe ring R-02"),
getNodeByName (char_str+"_Bone toe ring R-03"),
getNodeByName (char_str+"_Bone toe little R-01"),
getNodeByName (char_str+"_Bone toe little R-02"),
getNodeByName (char_str+"_Bone toe little R-03"))

select toes_r_ary

toolMode.coordsys (getNodeByName (char_str+"_Bone pelvis"))
setCoordCenter #system
	
--MANUALLY create mirror copy of toes with abdomen as pivot
max mirror

	
	--run script
for cur_obj in selection do 
(
	cur_pos=copy cur_obj.center
	resetScale cur_obj
	cur_obj.center=cur_pos
	
	cur_obj.name=substituteString cur_obj.name " R-0" " L-0"
	cur_digit=(substring cur_obj.name cur_obj.name.count cur_obj.name.count)
	cur_obj.name=substituteString cur_obj.name ("00"+cur_digit) ("0"+(((cur_digit as integer)-3) as string))
)	
--mg_rig.mirror_toes toes_r_ary