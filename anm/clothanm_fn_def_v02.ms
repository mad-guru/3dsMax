struct cloth_anm
(--vert_ary=getVertSelection $ $.modifiers[1]
-----------------------------------------------------------------------------------------------------
		fn cloth_cr_bake_sel sim_cloth rnd_cloth vert_ary start_time end_time skip_frame cr_verts bk_verts=
		(
			if cr_verts=true then
			(
				addmodifier rnd_cloth (Skin())
				select rnd_cloth
							
				setCommandPanelTaskMode #modify
				
				slidertime=start_time
				
				for cur_vert in vert_ary do	
				(
					cur_pt=point()
					cur_pt.name=(sim_cloth.name+"_vert_"+(cur_vert as string))
							
					cur_pt.position=meshop.getVert sim_cloth cur_vert
						
					skinOps.addbone rnd_cloth.modifiers[#skin] cur_pt -1
				)
			)
			
			if bk_verts=true then
			(
				set animate on
					
				for cur_time in start_time to end_time by skip_frame do
				(
					slidertime = cur_time
					
					for cur_vert in vert_ary do
					(
					cur_pt=getNodeByName(sim_cloth.name+"_vert_"+(cur_vert as string))
						
					cur_pt.position=meshop.getVert sim_cloth cur_vert
					)
				)
				set animate off
			)
		
		)
-----------------------------------------------------------------------------------------------------
)