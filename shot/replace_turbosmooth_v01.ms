for cur_obj in selection do
(
	if cur_obj.modifiers[#TurboSmooth]!=undefined then
	(
		mod_idx=undefined
		for num in 1 to cur_obj.modifiers.count do
		(
			if classof cur_obj.modifiers[num] == turbosmooth then
			(
			mod_idx=num
			cur_iterations= cur_obj.modifiers[num].iterations
			addModifier cur_obj (Turbosmooth()) after:num
			cur_obj.modifiers[num+1].enabledInViews=false
			cur_obj.modifiers[num+1].iterations=cur_iterations
			deletemodifier cur_obj cur_obj.modifiers[num]
			exit loop
			)
		)
	)
)