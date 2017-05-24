struct mg_bakedmaps
(
	-- select objects in scene, create materials and apply baked textures
	fn apply_bakedmaps root_path scene_str shot_str=
	(
		for cur_obj in selection do
		(
			cur_obj.material=StandardMaterial()
			cur_obj.material.name=cur_obj.name
			cur_obj.material.selfIllumAmount = 100
			cur_obj.material.diffuseMap = Bitmaptexture fileName:(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\color\"+cur_obj.name+"_c.tga")--("C:\Users\madguru\Documents\3dsMax\sceneassets\images\BARK5.jpg")
			cur_obj.material.diffuseMap.coordinates.mapChannel=10
			--cur_obj.material.diffuseMap.output.output_amount=3.0
			cur_obj.material.useSelfIllumColor = off
			--cur_obj.material.selfillumMap = cur_obj.material.diffuseMap

		)
	),
	
	
	-- select objects in scene, creates comp maps of baked render map and mask
	fn cr_comp_maps root_path scene_str shot_str=
	(
		for cur_obj in selection do
		(
			cur_obj.material=StandardMaterial()
			cur_obj.material.name=cur_obj.name
			cur_obj.material.selfIllumAmount = 100
			cur_obj.material.diffuseMap = CompositeTexturemap ()
			cur_obj.material[#Maps][4].mapEnabled.count = 2
			cur_obj.material[#Maps][4].layername[1] = "white"
			cur_obj.material[#Maps][4].layername[2] = "colormap"
			cur_obj.material[#Maps][4].mapList[1] = output ()
			cur_obj.material[#Maps][4].mapList[2] = Bitmaptexture fileName:(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\color\"+cur_obj.name+"_c.tga")
			cur_obj.material[#Maps][4].mapList[2].coordinates.mapChannel=10
			cur_obj.material[#Maps][4].Mask[2] = Bitmaptexture fileName:(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\mask\"+cur_obj.name+"_m.tga")
			cur_obj.material[#Maps][4].Mask[2].coordinates.mapChannel=10

			rm = renderMap cur_obj.material.diffuseMap size:[1024,1024] fileName:(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\comp\rnd\"+cur_obj.name+"_comp.jpg")
			save rm
			close rm
		)
	),

	-- select objects in scene, create materials and apply comp textures
	fn apply_compmaps root_path scene_str shot_str=
	(
		for cur_obj in selection do
		(
			cur_obj.material=StandardMaterial()
			cur_obj.material.name=cur_obj.name
			cur_obj.material.selfIllumAmount = 100
			
			cmp_seq= getFiles (root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\comp\"+cur_obj.name+"_comp*.jpg")

			if cmp_seq.count>0 then
			(
			cur_obj.material.diffuseMap = Bitmaptexture fileName:cmp_seq[1]
			cur_obj.material.diffuseMap.coordinates.mapChannel=10
			cur_obj.material.useSelfIllumColor = off
			)
			else
			(
			cur_obj.material.Diffuse = color 255 255 255
			)
		)
	),
	
	-- add objid to color map names
	fn add_objid root_path scene_str shot_str=
	(
			for cur_obj in selection do
			(
				cur_objid=cur_obj.gbufferchannel as string
				str_command= ("rename "+root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\comp\"+cur_obj.name+"_comp.jpg "+cur_obj.name+"_comp_objid_"+cur_objid+".jpg" )
				DosCommand(str_command)
			)
	),

	-- select objects in scene, create materials and apply pnt textures
	fn apply_pntmaps root_path scene_str shot_str=
	(
		for cur_obj in selection do
		(
			cur_obj.material=StandardMaterial()
			cur_obj.material.name=cur_obj.name
			cur_obj.material.selfIllumAmount = 100
			cur_obj.material.diffuseMap = Bitmaptexture fileName:(root_path+@"renders\"+scene_str+@"\"+shot_str+@"\maps\pnt\"+cur_obj.name+"_comp.png")
			cur_obj.material.diffuseMap.coordinates.mapChannel=10
			cur_obj.material.useSelfIllumColor = off
			--cur_obj.material.diffuseMap.output.output_amount=3.0

		)
	)
	
)