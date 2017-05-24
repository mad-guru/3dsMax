	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- user defined variables
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	scene_str="sc02"
	shot_str="sh0020"
	root_path=@"d:\projects\pd\"

--functions
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn get_highest_file cur_str=
	(
	cur_ary=getFiles cur_str
	alph_sort_files cur_ary
	if cur_ary.count>0 then cur_file=cur_ary[cur_ary.count]
	)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn alph_sort_files cur_ary=
(
		sort cur_ary
		sorted_ary=makeUniqueArray cur_ary
)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--references to external functions
bakedmaps_fn_def_file=get_highest_file (root_path+@"scripts\mtl\bakedmaps_fn_def_v*.ms")

filein bakedmaps_fn_def_file

-- select objects in scene, create materials and apply baked textures
mg_bakedmaps.apply_bakedmaps root_path scene_str shot_str

-- select objects in scene, creates comp maps of baked render map and mask
mg_bakedmaps.cr_comp_maps root_path scene_str shot_str

-- select objects in scene, create materials and apply comp textures	
mg_bakedmaps.apply_compmaps root_path scene_str shot_str

-- add objid to color map names	
mg_bakedmaps.add_objid root_path scene_str shot_str

-- select objects in scene, create materials and apply pnt textures
mg_bakedmaps.apply_pntmaps root_path scene_str shot_str