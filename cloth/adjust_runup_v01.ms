-- 35 frame runup
--439-475
--475-876

shot_start=795
runup_start=shot_start-35
runup_end=shot_start

sel_set = selectionSets["_Anim-Drv"]
select sel_set

for cur_obj in selection do
	
(
	--cur_obj.modifiers[#PC_Animation].recordStart = 475
	--cur_obj.modifiers[#PC_Animation].recordEnd = 475
	cur_obj.modifiers[#PC_InitialPose].recordStart = runup_start
	cur_obj.modifiers[#PC_InitialPose].recordEnd = runup_end

)