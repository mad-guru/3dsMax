char_str="riz"
loadMaterialLibrary @"C:\temp\projects\pd\mat\char\riz_body_v02.mat"
for cur_mtl in currentMaterialLibrary do
(
if cur_mtl.name==char_str+"_body" then (getNodeByName (char_str+"_body")).material=cur_mtl
if cur_mtl.name==char_str+"_cloth" then
	(
		obj_ary=execute("$"+char_str+"*cloth")
		for cur_obj in obj_ary do cur_obj.material=cur_mtl
	)
if cur_mtl.name==char_str+"_eyeball" then
	(
		obj_ary=execute("$"+char_str+"*eye_*")
		for cur_obj in obj_ary do cur_obj.material=cur_mtl
	)
if cur_mtl.name==char_str+"_eyelns" then
	(
		obj_ary=execute("$"+char_str+"_eyelns*")
		for cur_obj in obj_ary do cur_obj.material=cur_mtl
	)
if cur_mtl.name==char_str+"_gums" then
	(
		obj_ary=execute("$"+char_str+"*gum*")
		for cur_obj in obj_ary do cur_obj.material=cur_mtl
	)
if cur_mtl.name==char_str+"_teeth" then
	(
		obj_ary=execute("$"+char_str+"*teeth*")
		for cur_obj in obj_ary do cur_obj.material=cur_mtl		
	)
if cur_mtl.name==char_str+"_tng" then
	(
		obj_ary=execute("$"+char_str+"_tng")
		for cur_obj in obj_ary do cur_obj.material=cur_mtl		
	)
if cur_mtl.name==char_str+"_hair" then
	(
		obj_ary=#(getNodeByName(char_str+"_hair"),getNodeByName(char_str+"_brows"))
		if getNodeByName (char_str+"_bun")!=undefined do obj_ary[obj_ary.count+1]=getNodeByName (char_str+"_bun")
		if getNodeByName (char_str+"_mst_l")!=undefined do join obj_ary $*mst*
		for cur_obj in obj_ary do cur_obj.material=cur_mtl		
	)
	
	
)