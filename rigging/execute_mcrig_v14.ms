--add function for creating hand ik and foot ik. 2 seperate functions? or 1 with flags
-- try loading it into unity and ipi mocap
--adjust naming and hierarchy as needed to make it work
--bring back into 3ds max with animation applied. rename appropriate joints to ctrl obj names
--save anim and then load on original rig

char_str="riz"
scene_str="sc03"
shot_str="sh0035"
root_path=@"d:\projects\pd\"
shot_path=root_path+@"shots\"+scene_str+@"\"+shot_str+@"\mcp\"

pt_size=2
bn_size=.5

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
shot_fn_def_file=get_highest_file (root_path+@"scripts\shot\shot_fn_def_v*.ms")

rnd_rig_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\rnd\"+char_str+"_rig_v*.max")
if rnd_rig_file==undefined then
(rnd_rig_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\rnd\"+char_str+"_rnd_rig_v*.max"))

anm_rig_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\anm\"+char_str+"_anm_rig_v*.max")

filein rig_fn_def_file
filein anm_fn_def_file
filein shot_fn_def_file
	
	
mcrig_fn_def_file=get_highest_file (root_path+@"scripts\rigging\mcrig_fn_def_v*.ms")
mcrig_arrays_file=get_highest_file (root_path+@"scripts\rigging\mcrig_arrays_v*.ms")
	
filein mcrig_fn_def_file
filein mcrig_arrays_file

---------------------------------------------------------------------------------------------------------------------------------
--creates fk rig based off brad noble rig and saves mocap rig, then exports fbx
disableSceneRedraw();
mg_mcrig.cr_fkrig char_str root_path rnd_rig_file
enableSceneRedraw()

-- after skinning, run to name some bones to ctrl_parts or back to bone names for saving and loading animation for final rig. revert=false
--mg_mcrig.rename_ctrl char_str ctrl_ary part_ary false

-----------------------------------------------------------------------------------------------------------------------------------------------------
--import mocap and prep for splitting into xaf clips
mg_mcrig.import_mcp char_str path_str shot_str
-------------------------------------------------------------------------------------------------------------------------------------------------
--helps to streamline cutting up mcp into xaf files
-- delete saved out keys, hold
-- slide keyframes to frame 1. delete keys for other clips. run script
mg_mcrig.split_mc_clips char_str
-------------------------------------------------------------------------------------------------------------------------------------------------

disableSceneRedraw();
mg_mcrig.mocap_apply char_str mcrig_arrays_file rnd_rig_file
enableSceneRedraw()	
/*	
--align rigs. import fbx exported from ipi mocap studio with ctrl parts renamed and suffix set to _del
--rolled into larger function mg_mcrig.mocap_apply
--mg_mcrig.align_rigs char_str obj_align_ary start_frame end_frame

--not really needed, but if you need to create ik setups for limbs, here it is
mg_mcrig.cr_iksolver (getNodeByName(char_str+"_Bone upper arm L")) (getNodeByName(char_str+"_Bone hand L"))
mg_mcrig.cr_iksolver (getNodeByName(char_str+"_Bone upper arm R")) (getNodeByName(char_str+"_Bone hand R"))
	
mg_mcrig.cr_iksolver (getNodeByName(char_str+"_Bone thigh L")) (getNodeByName(char_str+"_Bone foot L"))
mg_mcrig.cr_iksolver (getNodeByName(char_str+"_Bone thigh R")) (getNodeByName(char_str+"_Bone foot R"))
*/	

--------------------------------------------------------------------------------------------------------------------------------------
--align to animation from motion mixer
--------------------------------------------------------------------------------------------------------------------------------------
disableSceneRedraw();
mg_mcrig.momix_apply char_str mcrig_arrays_file rnd_rig_file
enableSceneRedraw()

	--delete $*_del
	
	--sample align ik legs on from frame 28-63.
	--mg_mcrig.align_rigs char_str obj_align_ary 28 63 false true
--------------------------------------------------------------------------------------------------------------------------------
--for use when you have to realign certain parts
	--add suffix
	obj_ary=(execute ("$"+char_str+"*")) as array
		
	if (findString obj_ary[1].name "_del")==undefined then
	(for cur_obj in obj_ary do cur_obj.name=cur_obj.name+"_del")
		
		
--------------------------------------------------------------------------------------------------------------------	


--align to _del for ik foot to ik_del
obj_ary=#(
(getNodeByName(char_str+"_IK foot control L")),
(getNodeByName(char_str+"_IK foot control R"))
)

start_frame=(animationRange.start as integer)/TicksPerFrame
end_frame=(animationRange.end as integer)/TicksPerFrame

disableSceneRedraw();	
	with animate on
	(
		for cur_time in start_frame to end_frame do
		(
			for cur_obj in obj_ary do
			(
				slidertime=cur_time
				
				(cur_obj.transform=(getNodeByName(cur_obj.name+"_del")).transform)
			)
		)
	)
enableSceneRedraw();
----------------------------------------------------------------------------------------------------------------------------------------------------------
--align to _del for all including ik foot to ik_del
disableSceneRedraw();	
	with animate on
	(
		for cur_time in start_frame to end_frame do
		(
			for cur_obj in obj_ary do
			(
				slidertime=cur_time
				
				(cur_obj.transform=(getNodeByName(cur_obj.name+"_del")).transform)
			)
		)
	)
enableSceneRedraw();

--------------------------------------------------------------------------------------------------------------------------------
	--not currently needed
--------------------------------------------------------------------------------------------------------------------------------
--creates points based off brad noble rig. save them to another scene by themselves
loadMaxFile rnd_rig_file
filein mcrig_arrays_file

ctrl_layer=Layermanager.getlayer 0
ctrl_layer.current=true


mg_mcrig.cr_pts char_str bn_ary parent_ary end_ary pt_size

DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\mcp\archive\"))

select $*_del
hideByCategory.none() 
obj_ary=selection as array

unhide obj_ary
/*	
-- hangs max...saveNodes...crap
last_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\mcp\"+char_str+@"_mcp_pts_v*.max")
if last_file!=undefined then
	(
		up_num=mg_shot.ver_up_num last_file
		cur_filename=(root_path+@"models\char\"+char_str+@"\rig\mcp\"+char_str+@"_mcp_pts_v"+up_num+".max")
		saveNodes obj_ary cur_filename quiet:true
	)
	else saveNodes selection (root_path+@"models\char\"+char_str+@"\rig\mcp\"+char_str+@"_mcp_pts_v01.max")
	
--saveNodes selection "foo.max"
*/
--------------------------------------------------------------------------------------------------------------------------------	
	