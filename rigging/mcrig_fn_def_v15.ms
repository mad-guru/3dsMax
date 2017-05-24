struct mg_mcrig
(	
	
fn cr_pts char_str bn_ary parent_ary end_ary pt_size=
(
	
	for cur_bn in bn_ary do
	(
		--use locater instead
		cur_pt=point()
		cur_pt.size=pt_size
		cur_pt.cross=true
		cur_pt.name=(cur_bn.name+"_del")

		in coordsys local

		cur_pt.transform=cur_bn.transform
		resetScale cur_pt

		if (findItem end_ary cur_bn)!=0 then
		(
			-- create point
			end_pt=point()
			end_pt.size=pt_size
			addmodifier cur_bn (Turn_to_Mesh ())
			end_pt.position=cur_bn.verts[8].pos
		in coordsys local
			end_pt.transform=cur_bn.transform
			resetScale end_pt
			end_pt.position=[((cur_bn.verts[5].pos.x+cur_bn.verts[8].pos.x)/2),((cur_bn.verts[5].pos.y+cur_bn.verts[8].pos.y)/2),((cur_bn.verts[5].pos.z+cur_bn.verts[8].pos.z)/2)]
			end_pt.name=(substituteString cur_pt.name "_del" "_end")+"_del"
		)
	
	)

),
----------------------------------------------------------------------------------------------------------------------------------------
fn cr_fkskel char_str bn_ary parent_ary end_ary copy_ary bn_size=
(
	for num in 1 to copy_ary.count do
	(
		copy_ary[num].boneEnable=false
		new_bn=copy copy_ary[num]
		new_bn.name=copy_ary[num].name+"_bn"
		new_bn.parent=undefined
		resetScale copy_ary
		copy_ary[num].boneEnable=true
		new_bn.boneEnable=true
		new_bn.wirecolor = color 0 0 255
	)
	
	for num in 1 to parent_ary.count do
	(
	if bn_ary[num]!=undefined and (getNodeByName(bn_ary[num].name+"_bn"))==undefined do
		(
			if classof bn_ary[num]==Box then
			(
			new_bn=box()
			new_bn.height=bn_ary[num].height
			new_bn.width=bn_ary[num].width
			new_bn.length=bn_ary[num].length
			--in coordsys local
			new_bn.transform=bn_ary[num].transform

			new_bn.name=bn_ary[num].name+"_bn"
			resetScale new_bn
			new_bn.boneEnable=true
			new_bn.wirecolor = color 0 0 255
			)
			else
			(
			new_bn=point()
			new_bn.size=pt_size
			new_bn.cross=true
				
			--in coordsys local
			new_bn.transform=bn_ary[num].transform

			new_bn.name=bn_ary[num].name+"_bn"
			resetScale new_bn
			new_bn.boneEnable=true
			new_bn.wirecolor = color 0 0 255
			)

		)
	)

	--add parenting loop
	for num in 1 to bn_ary.count do
	(
		if parent_ary[num]!=undefined and (getNodeByName(bn_ary[num].name+"_bn"))!=undefined then
		(
			
			(getNodeByName(bn_ary[num].name+"_bn")).parent=getNodeByName(parent_ary[num].name+"_bn")
				
		)
		
	)
),

-------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_fkskel2 char_str bn_ary parent_ary end_ary copy_ary bn_size=
(
	for num in 1 to bn_ary.count do--copy_ary.count do
	(
		if bn_ary[num]!=undefined do
		(
		bn_ary[num].boneEnable=false
		new_bn=snapshot bn_ary[num]
		new_bn.name=bn_ary[num].name+"_bn"
		new_bn.transform=bn_ary[num].transform
		new_bn.parent=undefined
		resetScale new_bn
		bn_ary[num].boneEnable=true
		new_bn.boneEnable=true
		new_bn.wirecolor = color 0 0 255
		
		)
	)

	--add parenting loop
	for num in 1 to bn_ary.count do
	(
		if parent_ary[num]!=undefined and (getNodeByName(bn_ary[num].name+"_bn"))!=undefined then
		(
			
			(getNodeByName(bn_ary[num].name+"_bn")).parent=getNodeByName(parent_ary[num].name+"_bn")
				
		)
		
	)
),
-------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_fkrig char_str root_path rnd_rig_file=
(
	--run on points only scene to create fk skeleton based on brad noble skeleton
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\mcp\archive\"))
	loadMaxFile rnd_rig_file
	filein mcrig_arrays_file
		
	--create layers
	cur_layer=LayerManager.newLayer()
	cur_layer.setName (char_str+" - Mocap")
	cur_layer.current=true
/*		
		--rotate joints TESTING!!!!
	toolMode.coordsys #local
rotate (getNodeByName(char_str+"_FK upper arm L")) (angleaxis 8.0 [0,1,0])
rotate (getNodeByName(char_str+"_FK upper arm R")) (angleaxis -8.0 [0,1,0])
	
rotate (getNodeByName(char_str+"_FK thigh L")) (angleaxis 20.0 [0,1,0])
rotate (getNodeByName(char_str+"_FK thigh R")) (angleaxis -20.0 [0,1,0])
	
rotate (getNodeByName(char_str+"_FK foot L")) (angleaxis -16.0 [0,1,0])
rotate (getNodeByName(char_str+"_FK foot R")) (angleaxis 16.0 [0,1,0])
	---
	*/	
	mg_mcrig.cr_fkskel2 char_str bn_ary parent_ary end_ary copy_ary bn_size

	-- add sim objects to render layer
	tmp_objs=($*_cloth) as array
	--select tmp_objs
	cur_layer=LayerManager.getLayerFromName (char_str+" - Render")
	for cur_obj in tmp_objs do (cur_layer.addNode tmp_obj)

	--select render objects, collapse stack and unparent	
	cur_layer=LayerManager.getLayerFromName (char_str+" - Render")
	cur_layer.select true

	obj_ary=selection as array

	for cur_obj in obj_ary do
	(
	collapseStack cur_obj
	cur_obj.parent=undefined
	)

	cur_layer=LayerManager.getLayerFromName (char_str+" - Mocap")
	for cur_obj in obj_ary do (cur_layer.addNode cur_obj)

	cur_layer.select true

	-- manually save selected. check the file for extra objects. may havt to load and save selected again
	saveMaxFile (root_path+@"models\char\char_temp.max")  quiet:true

	resetMaxFile #noPrompt 

	mergeMAXFile (root_path+@"models\char\char_temp.max") ($*bn as array) quiet:true
	unhide (execute("$"+char_str+"*"))

	num_layers=LayerManager.count
	for num in 0 to (num_layers-1) do
	(
	cur_layer=layerManager.getLayer num
	cur_layer.on = true
	)
	
	cur_layer=LayerManager.getLayerFromName (char_str+" - Mocap")
	cur_layer.select true

	max select invert

	delete selection

	saveMaxFile (root_path+@"models\char\char_temp.max")  quiet:true

	loadMaxFile (root_path+@"models\char\char_temp.max")  quiet:true

	cur_layer=LayerManager.getLayerFromName (char_str+" - Bones")
	cur_layer.select true
	delete selection
	LayerManager.deleteLayerByName (char_str+" - Bones")

	cur_layer=LayerManager.getLayerFromName (char_str+" - Controls")
	cur_layer.select true
	delete selection
	LayerManager.deleteLayerByName (char_str+" - Controls")

	cur_layer=LayerManager.getLayerFromName (char_str+" - Hidden")
	cur_layer.select true
	delete selection
	LayerManager.deleteLayerByName (char_str+" - Hidden")

	cur_layer=LayerManager.getLayerFromName (char_str+" - Manipulators")
	cur_layer.select true
	delete selection
	LayerManager.deleteLayerByName (char_str+" - Manipulators")

	cur_layer=LayerManager.getLayerFromName (char_str+" - Render")
	if cur_layer!=undefined then
	(
		cur_layer.select true
		delete selection
		LayerManager.deleteLayerByName (char_str+" - Render")
	)

	saveMaxFile (root_path+@"models\char\char_temp.max")  quiet:true

	resetMaxFile #noPrompt 

	last_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\mcp\"+char_str+@"_mcp_rig_v*.max")
	if last_file!=undefined then
		(
			up_num=mg_shot.ver_up_num last_file
			cur_filename=(root_path+@"models\char\"+char_str+@"\rig\mcp\"+char_str+@"_mcp_rig_v"+up_num+".max")
			saveMaxFile cur_filename quiet:true
		)
		else saveMaxFile (root_path+@"models\char\"+char_str+@"\rig\mcp\"+char_str+@"_mcp_pts_v01.max")
/*
	mg_rig.filemerge_filtered "_bn" (root_path+@"models\char\char_temp.max")
	mg_rig.filemerge_filtered (char_str+"_body") (root_path+@"models\char\char_temp.max")
	mg_rig.filemerge_filtered (char_str+"_kamz") (root_path+@"models\char\char_temp.max")	
	mg_rig.filemerge_filtered (char_str+"_shlw") (root_path+@"models\char\char_temp.max")
	mg_rig.filemerge_filtered (char_str+"_pkt") (root_path+@"models\char\char_temp.max")
	mg_rig.filemerge_filtered (char_str+"_eye") (root_path+@"models\char\char_temp.max")
	mg_rig.filemerge_filtered (char_str+"_nails") (root_path+@"models\char\char_temp.max")
	mg_rig.filemerge_filtered (char_str+"_nails") (root_path+@"models\char\char_temp.max")
*/
	mergeMAXFile (root_path+@"models\char\char_temp.max")
		
	--delete $*chpl*
	delete $*spl
		
	--next run this to load skin modifier
	body_bn_ary=mg_rig.alph_sort_ary(execute ("$"+char_str+"_Bone*") as array)
		
	if (getNodeByName (char_str+"_body_r"))!=undefined then delete (getNodeByName (char_str+"_body_r"))
	--if (getNodeByName (char_str+"_nails"))!=undefined then delete (getNodeByName (char_str+"_nails"))
	
	if (getNodeByName(char_str+"_body"))!=undefined then
		(
		mg_rig.add_skin char_str (getNodeByName(char_str+"_body")) body_bn_ary char_body_env_file -50
		)
	
	if (getNodeByName(char_str+"_kamz_cloth"))!=undefned then
		(
	kamz_bn_ary=#(
	(getNodeByName(char_str+"_Bone pelvis_bn")),
	(getNodeByName(char_str+"_Bone hip L_bn")),
	(getNodeByName(char_str+"_Bone thigh L-01_bn")),
	(getNodeByName(char_str+"_Bone thigh L-02_bn")),
	(getNodeByName(char_str+"_Bone thigh L-03_bn")),
	(getNodeByName(char_str+"_Bone hip R_bn")),
	(getNodeByName(char_str+"_Bone thigh R-01_bn")),
	(getNodeByName(char_str+"_Bone thigh R-02_bn")),
	(getNodeByName(char_str+"_Bone thigh R-03_bn")),
	(getNodeByName(char_str+"_Bone spine-01_bn")),
	(getNodeByName(char_str+"_Bone spine-02_bn")),
	(getNodeByName(char_str+"_Bone spine-03_bn")),
	(getNodeByName(char_str+"_Bone clavicle L_bn")),
	(getNodeByName(char_str+"_Bone forearm R-03_bn")),
	(getNodeByName(char_str+"_Bone forearm R-02_bn")),
	(getNodeByName(char_str+"_Bone forearm R-01_bn")),
	(getNodeByName(char_str+"_Bone elbow R_bn")),
	(getNodeByName(char_str+"_Bone upper arm R-03_bn")),
	(getNodeByName(char_str+"_Bone upper arm R-02_bn")),
	(getNodeByName(char_str+"_Bone forearm L-02_bn")),
	(getNodeByName(char_str+"_Bone forearm L-03_bn")),
	(getNodeByName(char_str+"_Bone upper arm R-01_bn")),
	(getNodeByName(char_str+"_Bone clavicle R_bn")),
	(getNodeByName(char_str+"_Bone shoulder R_bn")),
	(getNodeByName(char_str+"_Bone hand R_bn")),
	(getNodeByName(char_str+"_Bone elbow L_bn")),
	(getNodeByName(char_str+"_Bone upper arm L-03_bn")),
	(getNodeByName(char_str+"_Bone upper arm L-02_bn")),
	(getNodeByName(char_str+"_Bone upper arm L-01_bn")),
	(getNodeByName(char_str+"_Bone shoulder L_bn")),
	(getNodeByName(char_str+"_Bone forearm L-01_bn")),
	(getNodeByName(char_str+"_Bone hand L_bn")),
	(getNodeByName(char_str+"_Bone chest_bn"))
	)


		mg_rig.add_skin char_str (getNodeByName(char_str+"_kamz_cloth")) kamz_bn_ary char_kamz_env_file -50
		)

	if (getNodeByName(char_str+"_shlw_cloth"))!=undefned then
	(
	shlw_bn_ary=#(
	(getNodeByName(char_str+"_Bone pelvis_bn")),
	(getNodeByName(char_str+"_Bone hip L_bn")),
	(getNodeByName(char_str+"_Bone thigh L-01_bn")),
	(getNodeByName(char_str+"_Bone thigh L-02_bn")),
	(getNodeByName(char_str+"_Bone thigh L-03_bn")),
	(getNodeByName(char_str+"_Bone knee L_bn")),
	(getNodeByName(char_str+"_Bone shin L-01_bn")),
	(getNodeByName(char_str+"_Bone shin L-02_bn")),
	(getNodeByName(char_str+"_Bone shin L-03_bn")),
	(getNodeByName(char_str+"_Bone hip R_bn")),
	(getNodeByName(char_str+"_Bone thigh R-01_bn")),
	(getNodeByName(char_str+"_Bone thigh R-02_bn")),
	(getNodeByName(char_str+"_Bone thigh R-03_bn")),
	(getNodeByName(char_str+"_Bone knee R_bn")),
	(getNodeByName(char_str+"_Bone shin R-01_bn")),
	(getNodeByName(char_str+"_Bone shin R-02_bn")),
	(getNodeByName(char_str+"_Bone shin R-03_bn")),
	(getNodeByName(char_str+"_Bone spine-01_bn"))
	)
	
	mg_rig.add_skin char_str (getNodeByName(char_str+"_shlw_cloth")) shlw_bn_ary char_shlw_env_file -50
	)

	if (getNodeByName(char_str+"_dpt_cloth"))!=undefined then
		(
			dpt_bn_ary=#(
			(getNodeByName(char_str+"_Bone spine-01_bn")),
			(getNodeByName(char_str+"_Bone spine-02_bn")),
			(getNodeByName(char_str+"_Bone spine-03_bn")),
			(getNodeByName(char_str+"_Bone clavicle L_bn")),
			(getNodeByName(char_str+"_Bone clavicle R_bn")),
			(getNodeByName(char_str+"_Bone shoulder R_bn")),
			(getNodeByName(char_str+"_Bone upper arm L-03_bn")),
			(getNodeByName(char_str+"_Bone upper arm L-02_bn")),
			(getNodeByName(char_str+"_Bone upper arm L-01_bn")),
			(getNodeByName(char_str+"_Bone shoulder L_bn")),
			(getNodeByName(char_str+"_Bone chest_bn_bn"))
			)
			mg_rig.add_skin char_str (getNodeByName(char_str+"_dpt_cloth")) dpt_bn_ary char_kmz_env_file -50
		)
		

	if (getNodeByName(char_str+"_pkt_cloth"))!=undefined then
		(
			pkt_bn_ary=#(
			(getNodeByName(char_str+"_Bone spine-01_bn")),
			(getNodeByName(char_str+"_Bone spine-02_bn")),
			(getNodeByName(char_str+"_Bone spine-03_bn")),
			(getNodeByName(char_str+"_Bone clavicle L_bn")),
			(getNodeByName(char_str+"_Bone forearm R-03_bn")),
			(getNodeByName(char_str+"_Bone forearm R-02_bn")),
			(getNodeByName(char_str+"_Bone forearm R-01_bn")),
			(getNodeByName(char_str+"_Bone upper arm R-03_bn")),
			(getNodeByName(char_str+"_Bone upper arm R-02_bn")),
			(getNodeByName(char_str+"_Bone upper arm R-01_bn")),
			(getNodeByName(char_str+"_Bone clavicle R_bn")),
			(getNodeByName(char_str+"_Bone shoulder R_bn")),
			(getNodeByName(char_str+"_Bone upper arm L-03_bn")),
			(getNodeByName(char_str+"_Bone upper arm L-02_bn")),
			(getNodeByName(char_str+"_Bone upper arm L-01_bn")),
			(getNodeByName(char_str+"_Bone shoulder L_bn")),
			(getNodeByName(char_str+"_Bone chest_bn"))
			)
			mg_rig.add_skin char_str (getNodeByName(char_str+"_pkt_cloth")) pkt_bn_ary char_kmz_env_file -50
		)

		--chapal
		if (getNodeByName(char_str+"_chpl_btm_l"))!=undefined then
			(
				chpl_ary=#(
				(getNodeByName(char_str+"_chpl_btm_l")),
				(getNodeByName(char_str+"_chpl_top_l"))
				)
				
				chpl_bn_ary=#(
				(getNodeByName(char_str+"_Bone foot L_bn")),
				(getNodeByName(char_str+"_Bone toe L_bn"))
				)
				
				char_chpl_env_l_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_chpl_l_v*.env")
				
				if char_chpl_env_l_file !=undefined then
				(
					mg_rig.add_skin char_str chpl_ary[1] chpl_bn_ary char_chpl_env_l_file -50
					addModifier chpl_ary[2] chpl_ary[1].modifiers[1]
						
					chpl_ary=#(
					(getNodeByName(char_str+"_chpl_btm_r")),
					(getNodeByName(char_str+"_chpl_top_r"))
					)
					
					chpl_bn_ary=#(
					(getNodeByName(char_str+"_Bone foot R_bn")),
					(getNodeByName(char_str+"_Bone toe R_bn"))
					)
					
					char_chpl_env_r_file=get_highest_file (root_path+@"models\char\"+char_str+@"\rig\env\"+char_str+@"_chpl_r_v*.env")
					
					mg_rig.add_skin char_str chpl_ary[1] chpl_bn_ary char_chpl_env_r_file -50
					addModifier chpl_ary[2] chpl_ary[1].modifiers[1]
				)
			)
			
		-- skinwrap objects
		skinwrap_ary=#(
		(getNodeByName(char_str+"_hair")),
		(getNodeByName(char_str+"_nails")),
		(getNodeByName(char_str+"_mst_path_r")),
		(getNodeByName(char_str+"_mst_path_l")),
		(getNodeByName(char_str+"_brows")),
		(getNodeByName(char_str+"_lashes"))
		)

		for cur_obj in skinwrap_ary do
			(
			if cur_obj!=undefined then
				(
				addmodifier cur_obj (Skin_Wrap ())
				--modPanel.addModToSelection (Skin_Wrap ()) ui:on
				cur_obj.modifiers[#Skin_Wrap].meshList=#((getNodeByName(char_str+"_body")))
				cur_obj.modifiers[#Skin_Wrap].engine = 0
				cur_obj.modifiers[#Skin_Wrap].meshDeformOps.convertToSkin off
				)
			)

		(getNodeByName(char_str+"_eyelns_l")).parent=(getNodeByName(char_str+"_Bone head_bn"))
		(getNodeByName(char_str+"_eyelns_r")).parent=(getNodeByName(char_str+"_Bone head_bn"))
		(getNodeByName(char_str+"_eye_l")).parent=(getNodeByName(char_str+"_Bone head_bn"))
		(getNodeByName(char_str+"_eye_r")).parent=(getNodeByName(char_str+"_Bone head_bn"))		
		(getNodeByName(char_str+"_teethbtm")).parent=(getNodeByName(char_str+"_Bone jaw_bn"))
		(getNodeByName(char_str+"_btmgums")).parent=(getNodeByName(char_str+"_Bone jaw_bn"))
		(getNodeByName(char_str+"_topgums")).parent=(getNodeByName(char_str+"_Bone head_bn"))
		(getNodeByName(char_str+"_teethtop")).parent=(getNodeByName(char_str+"_Bone head_bn"))
		(getNodeByName(char_str+"_tng")).parent=(getNodeByName(char_str+"_Bone jaw_bn"))
	
		saveMaxFile (maxFilePath+maxFileName) quiet:true
		
		--rotate joints for better tpose. might not be great for all chars. needed for better alignment in ipi
/*		--causing corrupted fbx? not readable by ipi
		toolMode.coordsys #local
			(
			rotate (getNodeByName(char_str+"_Bone thigh L")) (angleaxis 22 [0,1,0])
			rotate (getNodeByName(char_str+"_Bone thigh R")) (angleaxis -22 [0,1,0])
			rotate (getNodeByName(char_str+"_Bone upper arm L")) (angleaxis 9 [0,1,0])
			rotate (getNodeByName(char_str+"_Bone upper arm R")) (angleaxis -9 [0,1,0])

			tmp_pos=(getNodeByName(char_str+"_Bone foot R")).position
			(getNodeByName(char_str+"_Bone foot R")).rotation=(getNodeByName(char_str+"_Bone shin R")).rotation
			rotate (getNodeByName(char_str+"_Bone foot R")) (angleaxis -90 [1,0,0])
			(getNodeByName(char_str+"_Bone foot R")).position=tmp_pos
				
			tmp_pos=(getNodeByName(char_str+"_Bone foot L")).position
			(getNodeByName(char_str+"_Bone foot L")).rotation=(getNodeByName(char_str+"_Bone shin L")).rotation
			rotate (getNodeByName(char_str+"_Bone foot L")) (angleaxis -90 [1,0,0])
			(getNodeByName(char_str+"_Bone foot L")).position=tmp_pos
			)
	*/		
			
slidertime=100
slidertime=0
		
		exportFile (maxFilePath+(substituteString maxFileName ".max" ".fbx")) #noPrompt using: exporterPlugin.classes[8]
			
		resetMaxFile #noPrompt 
		-----
		-- save out xmil file for ipisoft
		tmp_file=openFile (root_path+@"\models\char\_all\rig\mcp\char_str.profile.xml") mode:"r"
		xml_file=createFile (root_path+@"\models\char\"+char_str+@"\rig\mcp\"+char_str+".profile.xml")

		while (eof tmp_file)!=true do
		(
		cur_line=readLine tmp_file
		new_line=substituteString (cur_line+"\n") "char_str" char_str
		format new_line to:xml_file
		)
		flush xml_file
		close xml_file
		close tmp_file
		-----

),
-------------------------------------------------------------------------------------------------------------------------------------------------------
fn rename_ctrl char_str ctrl_ary part_ary revert=
(
	for num in 1 to ctrl_ary.count do
	(
		if part_ary[num]!="NONE" then
		(
			if revert==false then
			(
				if (getNodeByName(part_ary[num]))!=undefined then
					(
					(getNodeByName(part_ary[num])).wirecolor = color 225 255 0
					(getNodeByName(part_ary[num])).name=ctrl_ary[num]
					)
			)
			else
			(
				if (getNodeByName(ctrl_ary[num]))!=undefined then
					(
					(getNodeByName(ctrl_ary[num])).wirecolor = color 0 0 255
					(getNodeByName(ctrl_ary[num])).name=part_ary[num]
					)
			)			
		)
	)
),
	
fn cr_iksolver start_obj end_obj=
	(
		cur_ikchain = IKSys.ikChain start_obj end_obj "IKHiSolver"
		cur_ikchain.transform.controller.goalSize = 0.3*ctrlobj_mult
		cur_ikchain.name=end_obj.name+"_ikchain"
		return_value=cur_ikchain
		return_value
	),
	
fn align_rigs char_str obj_align_ary start_frame end_frame do_rot ik_align_to_fk=
(
	with animate on
	(
		for cur_time in start_frame to end_frame do
		(
			for cur_obj in obj_align_ary do
			(
				slidertime=cur_time
				
				if (getNodeByName(cur_obj.name+"_del"))!=undefined then
				(cur_obj.transform=(getNodeByName(cur_obj.name+"_del")).transform)
			)
		)
	)
		slidertime=0
		if do_rot==true then
		(
		in coordsys local rotate (getNodeByName(char_str+"_FK foot L")) (angleaxis -90.0 [1,0,0])
		in coordsys local rotate (getNodeByName(char_str+"_FK foot R")) (angleaxis -90.0 [1,0,0])
		)
		
	if ik_align_to_fk==true then
	(
		with animate on
		(
			for cur_time in start_frame to end_frame do
			(
				slidertime=cur_time
				
				for cur_obj in obj_align_ary do
				(		
					if (findString cur_obj.name "_IK ")!=undefined then
					(
						if (findString cur_obj.name "foot")!=undefined then
							(
							cur_obj.transform=(getNodeByName((substituteString (substituteString cur_obj.name "_IK " "_FK ") "control " ""))).transform
							)
						else
							(
							cur_obj.transform=(getNodeByName((substituteString cur_obj.name "_IK arm" "_Hand"))).transform
							)
					)
				)
			)
		)
	)
		slidertime=0
		
		in coordsys world (getNodeByName(char_str+"_IK foot control L")).transform=(getNodeByName(char_str+"_FK foot L")).transform
		in coordsys world (getNodeByName(char_str+"_IK foot control R")).transform=(getNodeByName(char_str+"_FK foot R")).transform
			
		in coordsys world (getNodeByName(char_str+"_IK foot control L")).position=(getNodeByName(char_str+"_FK foot L")).position
		in coordsys world (getNodeByName(char_str+"_IK foot control R")).position=(getNodeByName(char_str+"_FK foot R")).position
			
),
--manually removed transform and scale keys from all but root. removed scale from root. delete runup. save animation and load it onto fresh rig.
--have it align ik and fk for arms and legs and you can switch between either!
fn mocap_apply char_str mcrig_arrays_file rnd_rig_file shot_path=
	(
	--import fbx file
	--resetMaxFile #noPrompt 
	--max file import
	--char_mcp_fbx_file=get_highest_file(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\mcp\"+scene_str+@"_"+shot_str+"_"+char_str+@"_v*.fbx")
	--importFile char_mcp_fbx_file #noPrompt --using:importerPlugin.classes[5]
	
	filein mcrig_arrays_file
	filein mcrig_arrays_file
		
	--rename ctrl parts
	mg_mcrig.rename_ctrl char_str ctrl_ary part_ary false
	
	--add suffix
	select $*
	if (findString selection[1].name "_del")==undefined then
	(for cur_obj in selection do cur_obj.name=cur_obj.name+"_del")
		
	--max file saveas
	DOSCommand ("mkdir "+shot_path)
	mocap_file=(shot_path+"test.max")--(substituteString char_mcp_fbx_file ".fbx" ".max")
	saveMaxFile mocap_file quiet:true
	
	--load rig file --max file open
	
	loadMaxFile rnd_rig_file quiet:true
	
	--merge mocap file
	--max file merge
	mergeMAXFile mocap_file #useMergedMtlDups  #deleteOldDups quiet:true

	filein mcrig_arrays_file
	
	key_ary=(getNodeByName(char_str+"_Waist control_del")).controller.position.controller.keys
	start_frame=((key_ary[1].time) as integer)/TicksPerFrame
	end_frame=((key_ary[key_ary.count].time as integer))/TicksPerFrame
	
	animationRange=(interval start_frame end_frame)
	
	ik_ary=execute("select $"+char_str+"_IK*control*")
	
	--align parts
	mg_mcrig.align_rigs char_str obj_align_ary start_frame end_frame true false

	-- do I need this? testing	
	--(getNodeByName(char_str+"_Foot pivot ref R")).transform=(getNodeByName(substituteString (char_str+"_Foot pivot ref R") "pivot ref" "tilt parent")).transform
	--(getNodeByName(char_str+"_Foot pivot ref L")).transform=(getNodeByName(substituteString (char_str+"_Foot pivot ref L") "pivot ref" "tilt parent")).transform

	--(getNodeByName(char_str+"_IK arm control R")).transform=(getNodeByName(substituteString (char_str+"_Foot pivot ref R") "IK arm" "Hand")).transform
	--(getNodeByName(char_str+"_IK arm control L")).transform=(getNodeByName(substituteString (char_str+"_Foot pivot ref L") "IK arm" "Hand")).transform
	
	ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
	ctrl_layer.on=true
	ctrl_layer.select on

				
	--delete scale keys on all control objects
	for cur_obj in selection do deleteKeys cur_obj.scale.controller.keys #allKeys

	deselect (getNodeByName(char_str+"_Waist control"))
	deselect (getNodeByName(char_str+"_IK arm control L"))
	deselect (getNodeByName(char_str+"_IK foot control L"))
	deselect (getNodeByName(char_str+"_IK arm control R"))
	deselect (getNodeByName(char_str+"_IK foot control R"))
		
	for cur_obj in selection do deleteKeys cur_obj.position.controller.keys #allKeys

	--execute("select $"+char_str+"_IK*control*")
	--deselect (getNodeByName(char_str+"_IK arm control L"))
	--deselect (getNodeByName(char_str+"_IK arm control R"))
	--for cur_obj in selection do deleteKeys cur_obj.rotation.controller.keys #allKeys
		
	delete $*_del
		
	--select all ctrls and delete any runup keys, including mocap tpose up to shot pose. slide all keys back to frame 1. save animation
	ctrl_layer.select on
	
	saveMaxFile (substituteString mocap_file "_v" "_processed_v") quiet:true

	
	--messageBox "Rotate feet with animate off. Delete any runup keys, including mocap tpose up to shot pose. slide all keys back to frame 1. Save animation" title:"Key cleanup" beep:false
	),
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn momix_apply char_str mcrig_arrays_file rnd_rig_file=
	(
	--add suffix
	obj_ary=(execute ("$"+char_str+"*")) as array
	for cur_obj in obj_ary do cur_obj.name=cur_obj.name+"_del"

	--max file merge
	mergeMAXFile anm_rig_file #useSceneMtlDups quiet:true
	filein mcrig_arrays_file
	
	start_frame=(animationRange.start as integer)/TicksPerFrame
	end_frame=(animationRange.end as integer)/TicksPerFrame
	
	animationRange=(interval start_frame end_frame)
	
			-- key ik blends on
				with animate on
			(
				for cur_time in 0 to 1 do
				(
				slidertime=cur_time
				(getNodeByName(char_str+"_FK foot R")).modifiers[#FK_foot_controls_R].FK_foot_R.'Right leg IK blend'=100
				(getNodeByName(char_str+"_FK foot L")).modifiers[#FK_foot_controls_L].FK_foot_L.'Left leg IK blend'=100
				)
			)
			
			
	ik_ary=execute("select $"+char_str+"_IK*control*")
	
	--align parts
	--disableSceneRedraw();
	mg_mcrig.align_rigs char_str obj_align_ary start_frame end_frame false true
	addNewKey (getNodeByName(char_str+"_Master control")).controller.position.controller 1
	addNewKey (getNodeByName(char_str+"_Master control")).controller.rotation.controller 1
	--enableSceneRedraw()
	
	ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
	ctrl_layer.on=true
	ctrl_layer.select on

				
	--delete scale keys on all control objects
	for cur_obj in selection do deleteKeys cur_obj.scale.controller.keys #allKeys

	deselect (getNodeByName(char_str+"_Waist control"))
	deselect (getNodeByName(char_str+"_IK arm control L"))
	deselect (getNodeByName(char_str+"_IK foot control L"))
	deselect (getNodeByName(char_str+"_IK arm control R"))
	deselect (getNodeByName(char_str+"_IK foot control R"))
		
	for cur_obj in selection do deleteKeys cur_obj.position.controller.keys #allKeys
		
	
--align to _del for ik foot to ik_del
obj_ary=#(
(getNodeByName(char_str+"_IK foot control L")),
(getNodeByName(char_str+"_IK foot control R"))
)

start_frame=(animationRange.start as integer)/TicksPerFrame
end_frame=(animationRange.end as integer)/TicksPerFrame

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
	
		
	--delete $*_del
		
	--select all ctrls and delete any runup keys, including mocap tpose up to shot pose. slide all keys back to frame 1. save animation
	ctrl_layer.select on
	
	--saveMaxFile (substituteString mocap_file "_v" "_processed_v") quiet:true
	),
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn import_mcp char_str path_str shot_str=
(	
	--import_fbx file
	mcp_file = getOpenFileName caption:"Open a Motion Capture File:" types:"FBX(*.fbx)|"

	resetMaxFile #noPrompt 
	frameRate=30
	
	importFile mcp_file #noPrompt using:importerPlugin.classes[5]
	
			
	frameRate=8
	
	key_ary=(getNodeByName(char_str+"_Bone pelvis_bn")).controller.position.controller.keys
	start_frame=((key_ary[1].time) as integer)/TicksPerFrame
	end_frame=((key_ary[key_ary.count].time as integer))/TicksPerFrame
	animationRange=(interval (start_frame) (end_frame))
		
	disableSceneRedraw();
	mg_mcrig.mocap_apply char_str mcrig_arrays_file rnd_rig_file shot_path
	enableSceneRedraw()
		
	--might be messed up
	mg_anm.save_anm char_str (selection as array) (getFilenamePath(substituteString mcp_file "fbx" "xaf")) (filenameFromPath (substituteString mcp_file "fbx" "xaf"))
	
	--max file merge
	resetMaxFile #noPrompt 
	LoadMAXFile anm_rig_file quiet:true
	filein mcrig_arrays_file
		
	ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
	ctrl_layer.on=true
	ctrl_layer.select on
		
	mg_anm.load_anm (substituteString mcp_file "fbx" "xaf") (selection as array) false false 0
	
	frameRate=8
	
	key_ary=(getNodeByName(char_str+"_Waist control")).controller.position.controller.keys
	start_frame=((key_ary[1].time) as integer)/TicksPerFrame
	end_frame=((key_ary[key_ary.count].time as integer))/TicksPerFrame
	animationRange=(interval (start_frame-100) (end_frame+100))
		
		
	-- manually delete unneeded keyframes and slide clips around
/* --not working. must cycle through all objects
			-- delete keys before frame 1		
			key_ary=(getNodeByName(char_str+"_Waist control")).controller.position.controller.keys
			del_ary=#()
				
			for cur_num in 1 to key_ary.count do
			(	
				if key_ary[cur_num].time<1 and key_ary[cur_num].time!=undefined then
				(
					del_ary[del_ary.count+1]=cur_num
				)
			)

			if del_ary.count>0 then
			(
					for cur_num in 1 to del_ary.count do (deleteItem key_ary del_ary[cur_num])
			)
			key_ary=(getNodeByName(char_str+"_Waist control")).controller.position.controller.keys
		*/

				
		saveMaxFile "C:\Users\madguru\Documents\3dsMax\autoback\maxhold.mx"
),
		
---------------------------------------------------------------------------------------------------------------------------------------------------------------------	
fn split_mc_clips char_str=
	(
			ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
			ctrl_layer.on=true
				
			key_ary=(getNodeByName(char_str+"_Waist control")).controller.position.controller.keys
				
			animationRange=(interval 0 key_ary[key_ary.count].time)
				
			with animate on
			(
				for cur_time in 0 to 1 do
				(
				slidertime=cur_time
				(getNodeByName(char_str+"_FK foot R")).modifiers[#FK_foot_controls_R].FK_foot_R.'Right leg IK blend'=100
				(getNodeByName(char_str+"_FK foot L")).modifiers[#FK_foot_controls_L].FK_foot_L.'Left leg IK blend'=100
				)
			)
			
		start_frame=animationRange.start
		end_frame=animationRange.end

		obj_ary=#(
		--(getNodeByName(char_str+"_Waist control")),
		(getNodeByName(char_str+"_IK foot control L")),
		(getNodeByName(char_str+"_IK foot control R"))
		)		


		--align to fk foot
		disableSceneRedraw();	
			with animate on
			(
				for cur_time in start_frame to end_frame do
				(
					for cur_obj in obj_ary do
					(
						slidertime=cur_time
						
							if (findString cur_obj.name "foot")!=undefined then
							(
							cur_obj.transform=(getNodeByName((substituteString (substituteString cur_obj.name "_IK " "_FK ") "control " ""))).transform
							)
							else	(cur_obj.transform=(getNodeByName(cur_obj.name+"_del")).transform)
					)
				)
			)
		enableSceneRedraw();
			
		ctrl_layer.select on
		
		LoadSaveAnimation.saveAnimationDlg()
		
		loadMaxFile "C:\Users\madguru\Documents\3dsMax\autoback\maxhold.mx"
		
		ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
		ctrl_layer.on=true
		ctrl_layer.select on
		
	)

)