--update parts of model not morphing
--select body verts on target
upd_model=$nmy_body_new

fn morph_update_body upd_model=
(

		cur_ary=$*_mt_*

		for cur_obj in cur_ary do
		(
			if cur_obj.modifiers[#Morpher]==undefined do addmodifier cur_obj (morpher ())
				
			WM3_MC_BuildFromNode cur_obj.morpher 1 upd_model
			WM3_MC_SetUseVertexSel cur_obj.morpher 1 true

			WM3_MC_SetValue cur_obj.morpher 1 100.0

			collapseStack cur_obj
			--hide cur_obj
		)
)
-------------------------------------------------------------------------------------------
base_model=$nmy_body_base
upd_model=$nmy_body_upd
--update whole model with skinwrap

fn upd_morphs base_model upd_model=
(
	cur_ary=$*_mt_*

	--create skinwrap setup on upd_model
	if upd_model.modifiers[#Skin_wrap]==undefined do addmodifier upd_model (skin_wrap())
	--addmodifier upd_model (skin_wrap())
	upd_model.modifiers[#skin_wrap].meshlist=#(base_model)
	upd_model.modifiers[#skin_wrap].engine=1
	upd_model.modifiers[#skin_wrap].weightAllVerts=true
	upd_model.modifiers[#skin_wrap].falloff=3
	upd_model.modifiers[#skin_wrap].distance=1.2
	upd_model.modifiers[#skin_wrap].facelimit=3
	--create morph setup on base_model
	for cur_num in 1 to cur_ary.count do
		(
		cur_mt=cur_ary[cur_num]
		if base_model.modifiers[#Morpher]==undefined do addmodifier base_model (morpher ())
		WM3_MC_BuildFromNode base_model.morpher cur_num cur_mt
		--WM3_MC_SetUseVertexSel base_model.morpher 1 true
		WM3_MC_SetValue base_model.morpher cur_num 100.0
		--is sloooow
		cur_upd_mt=snapshot upd_model
		cur_upd_mt.name=cur_mt.name+"_upd"
			WM3_MC_SetValue base_model.morpher cur_num 0.0
		--collapseStack cur_upd_mt
		--delete cur_mt
		--deleteModifier base_model 1
	)
)