-- creates a point cache from under the cloth modifier in the same folder as the scene file
-- then makes a snapshot and loads the cache on it
-- creates morpher mod on sim object so that 'skinned' version can be blended in

--select $*Sim_
slidertime=animationRange.start

for cur_obj in selection do
	(
		--cur_obj.modifiers[#Cloth]
		
		cloth_mod=undefined
		for m in 1 to cur_obj.modifiers.count do (if classof cur_obj.modifiers[m]==cloth then cloth_mod=copy m)
		
		if cloth_mod!=undefined then (addModifier cur_obj (Point_Cache ()) before:cloth_mod)
			else (addModifier cur_obj (Point_Cache ()))

		cur_mod=cur_obj.modifiers[#Point_Cache]

		--makeDir cache_path
		cache_path=maxfilepath
		cur_mod.filename = cache_path+cur_obj.name+".pc2"
		cacheOps.RecordCache cur_mod

		--delete point cache modifier
		for m in cur_obj.modifiers do
			(
			if classOf m==Point_Cache do deleteModifier cur_obj m
			)

		--create snapshot and load cache on it
		new_obj=snapshot cur_obj
		new_obj.name=cur_obj.name+"_skinCache"
		addModifier new_obj (Point_Cache ())
		new_obj.modifiers[#Point_Cache].filename=cache_path+cur_obj.name+".pc2"

		cur_mt_str=filterString new_obj.name "_"
			
		addModifier cur_obj (Morpher ())
		cur_obj.modifiers[#Morpher].name="Morpher_"+cur_mt_str[cur_mt_str.count]
		cur_obj.modifiers[#Morpher].Autoload_of_targets=1
		WM3_MC_BuildFromNode cur_obj.modifiers[#Morpher] 1 new_obj
			
		-- paint morph
		-- add before morpher modifier
		addmodifier cur_obj (Poly_Select ()) before:1

		--add at top to deselect
		if classof cur_obj.modifiers[1]!=mesh_select then addmodifier cur_obj (Mesh_Select ())
				
		--modPanel.setCurrentObject cur_obj.modifiers[#Poly_Select]
		--subobjectLevel = 1
		--enableShowEndRes true
	)
	
