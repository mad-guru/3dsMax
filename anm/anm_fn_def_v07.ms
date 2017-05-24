struct mg_anm
(
char_str,cur_body, char_rig_ary,search_val,root_path,rig_start_file,cloth_pose,runup_frame,
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- sel_char_parts
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn sel_char_parts char_str char_rig_ary search_val=
		(
		char_rig_ary=makeUniqueArray char_rig_ary
		if (findItem char_rig_ary undefined)!=0 do (char_rig_ary=deleteItem char_rig_ary (findItem char_rig_ary undefined))
		select char_rig_ary
		),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- save_anm
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn save_anm char_str cur_rig_ary cur_save_path cur_save_file=
	(
	if cur_save_path==undefined then cur_save_path=MaxFilePath+@"xaf\"
	if cur_save_file==undefined then cur_save_file=char_str+"_"+MaxFileName
		
	makeDir cur_save_path all:true
	LoadSaveAnimation.setUpAnimsForSave cur_rig_ary
	LoadSaveAnimation.saveAnimation (cur_save_path+cur_save_file) cur_rig_ary #() #() --animatedTracks: true includeConstraints: true keyableTracks: true saveSegment: true segInterval: (interval animationRange.start animationRange.end) segKeyPerFrame: false
	),			
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- load_anm
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn load_anm load_file obj_ary rel_val ins_val instime_val=
	(
	--mg_anm.sel_char_parts char_str char_rig_ary undefined

	LoadSaveAnimation.setUpAnimsForLoad obj_ary
	LoadSaveAnimation.loadAnimation load_file obj_ary insert:ins_val relative:rel_val insertTime:instime_val
	),		
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- cache_save
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
		fn cache_save char_str sim_ary cache_path anm_frm_start anm_frm_end cache_mix cache_str pcl=
			(
				-- open cloth file
				
				-- select cloth objs
				select sim_ary

				for cur_obj in selection do
				(
					if pcl==1 then
						(
						pcm=(Point_Cache ())
						pcms=cur_obj.modifiers[#Point_Cache]
						)
					else
						(
						pcm=(Point_CacheSpacewarpModifier ())
						pcms=cur_obj.modifiers[#Point_Cache_Binding]
						)
						
				addmodifier cur_obj (Cloth ())
				if pcms==undefined do (addmodifier cur_obj (pcm))

				pcms.recordStart = anm_frm_start-1
				pcms.recordEnd = anm_frm_end+1

				if cache_mix==true then
				(
					HiddenDOSCommand ("mkdir "+cur_path+"\\cloth\\cache\\"+cache_str+"\\")
					pcms.filename = (cache_path+cache_str+"\\"+cur_obj.name+".xml")
				)
				else
				(pcms.filename = (cache_path+cur_obj.name+".xml"))

				cacheOps.RecordCache pcms
					

				)
					select sim_ary
					slidertime=anm_frm_start
				
					-- write out cloth sim ojb transforms at first frame
					for a in selection do (
					print ("$"+a.name+".transform="+a.transform as string)
					)

			),

	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- cache_load
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		fn cache_load char_str sim_ary cache_path anm_frm_start anm_frm_end cache_mix cache_str pcl=
			(
			--load render file

			-- select cloth objs
			select sim_ary

				--load cache
				for cur_obj in selection do
				(
					if pcl==1 then
						(
						pcm=(Point_Cache ())
						pcms=cur_obj.modifiers[#Point_Cache]
						pcmsc=cur_obj_copy.modifiers[#Point_Cache]
						)
					else
						(
						pcm=(Point_CacheSpacewarpModifier ())
						pcms=cur_obj.modifiers[#Point_Cache_Binding]
						pcmsc=cur_obj_copy.modifiers[#Point_Cache_Binding]
						)
						
						if cache_mix==true then
							(
								cur_obj_copy=copy cur_obj
								cur_obj_copy.name=cur_obj.name+"_"+cache_str

								if pcmsc==undefined do (addmodifier cur_obj_copy (pcm))
								pcmsc.filename = (cache_path+cache_str+"\\"+cur_obj.name+".xml")
								addmodifier cur_obj (morpher ())
								cur_obj.modifiers[1].name=cur_obj.modifiers[1].name+"_"+cache_str
								cur_targ= getNodeByName (cur_obj.name+"_"+cache_str)
								WM3_MC_BuildFromNode cur_obj.modifiers[1] 1 cur_targ
								cur_obj.modifiers[1].Autoload_of_targets = 1
							)

							else
							(
								if pcms==undefined do (addmodifier cur_obj (pcm))
								--use original frame range
								pcms.playbackType=0
								pcms.playbackStart = anm_frm_start
								pcms.playbackEnd = anm_frm_end
								pcms.filename = (cache_path+cur_obj.name+".xml")
							)	
				)
			),

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- cache_cmsetup
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
		fn cache_cmsetup char_str sim_ary cache_path anm_frm_start anm_frm_end cache_mix cache_str=
			(
				--load max file for character's cachecomp
				--loadMaxfile "Q:\\AUSTIN_BROWN\\GLOBAL_ASSETS\\MODELS\\Female-Model\\cloth\\girl_cachecomp_v01.max"

				-----------------------
				--repeat of runup code
				--------------------

				--Load (insert) animation file on Character Node.
				select (getNodeByName (char_str+"_char"))
				max modify mode
				-- load animation MANUALLY
				
				--Go to frame runup_start and with auto key on, click Assume Skin Pose.
				slidertime=runup_start
				-------------------------
				-- MANUALLY click assume skin pose
				-------------------------

				--Now you have an animation file with runup for simming.

				--Parent cloth to root_ctrl
				for cur_obj in sim_ary do (cur_obj.parent=root_ctrl)

				--select then delete world_obj runup_start keyframe
				selectKeys root_ctrl.position.controller runup_start runup_start
				deleteKeys root_ctrl.position.controller
				
				--Unparent Cloth
				for cur_obj in sim_ary do (cur_obj.parent=undefined)

				animationRange = interval runup_start (anm_frm_end+1)
		),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- rnd_cloth
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			

		fn rndcloth_create char_str sim_ary cache_path anm_frm_start anm_frm_end cache_mix cache_str pcl=
			(
			--load render file
		loadMaxfile "Q:\\AUSTIN_BROWN\\GLOBAL_ASSETS\\MODELS\\Female-Model\\cloth\\girl_rndcloth_v01.max"
			-- select cloth objs
			select sim_ary

			--load cache
			for cur_obj in selection do
				(
							if pcl==1 then
						(
						pcm=(Point_Cache ())
						pcms=cur_obj.modifiers[#Point_Cache]
						pcmsc=cur_obj_copy.modifiers[#Point_Cache]
						)
					else
						(
						pcm=(Point_CacheSpacewarpModifier ())
						pcms=cur_obj.modifiers[#Point_Cache_Binding]
						pcmsc=cur_obj_copy.modifiers[#Point_Cache_Binding]
						)
						
							if pcms==undefined do (addmodifier cur_obj (pcm))
							--use original frame range
							pcms.playbackType=0
							pcms.playbackStart = anm_frm_start
							pcms.playbackEnd = anm_frm_end
							pcms.filename = (cache_path+cur_obj.name+".xml")
			
				)
			),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
		fn cloth_panelprep cloth_obj_ary =
		(
					if cloth_obj_ary[1].modifiers[#Garment_Maker]!=undefined do
					(
						for num in 1 to cloth_obj_ary.count do
							(
							cloth_obj=cloth_obj_ary[num]
							if cloth_obj.modifiers[#Cloth]!=undefined do (cloth_obj.modifiers[#Cloth].name="Cloth_Shape")
							--cloth_obj.modifiers[#Cloth_Shape].setObjectType cloth_obj 0 false
							)							
					)
		),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------						
		fn cloth_setup char_str cur_body cloth_obj_ary=
		(
					setCommandPanelTaskMode #modify
			
					--shlw setup cloth pass 1
					cur_shlw=(getNodeByName (char_str+"_shlw_cloth"))
					select cur_shlw
					addmodifier cur_shlw (Cloth ())
						
				--	setCommandPanelTaskMode #create
				--	setCommandPanelTaskMode #modify
						
					cur_shlw.modifiers[#Cloth].clothOps.setObjectType cur_shlw 2 true
						
							--assign cloth properties
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "uBend" 5
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "vBend" 5
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "ubCurve" 0.0
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "vbCurve" 0.0
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "uStretch" 75
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "vStretch" 75
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "ucompress" 5
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "vcompress" 5
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "shear" 225
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "density" 0.1
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "damping" 0.1
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "plasticity" 0.0
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "thickness" 1.0
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "repulsion" 5.0
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "airres" 0.02
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "dynFric" 0.1
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "staticFric" 0.5
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "selfFric" 0.5
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "seamForce" 5000.0
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "uScale" 1.0
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "vScale" 1.0
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "depth" 1.0
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "offset" 0.5
							--cling not accessible?
							cur_shlw.modifiers[#Cloth].ClothOps.SetObjectProperty cur_shlw "layer" 0
							cur_shlw.modifiers[#Cloth].startframe=-50
							cur_shlw.modifiers[#Cloth].useSewingSprings=false
							

					
					--body as collision
					select cur_body
					addmodifier cur_body cur_shlw.modifiers[#Cloth]
					
					cur_body.modifiers[#Cloth].clothOps.setObjectType cur_body 1 true
					cur_body.modifiers[#Cloth].clothOps.SetObjectProperty cur_body "offset" 0.2
					
					cur_shlw.modifiers[#Cloth].name = cur_body.modifiers[#Cloth].name+"_shlw"
					setCommandPanelTaskMode #create
					setCommandPanelTaskMode #modify
					
					-- add Cloth Modifier
					select cloth_obj_ary
					--addmodifier cloth_obj_ary (Cloth ())
					
					--body as collision
					select cur_body
					--addmodifier cur_body cloth_obj_ary[1].modifiers[#Cloth]
					addmodifier cur_body (Cloth ())
					
					cur_body.modifiers[#Cloth].clothOps.setObjectType cur_body 1 true
					cur_body.modifiers[#Cloth].clothOps.SetObjectProperty cur_body "offset" 0.2
						
					--setCommandPanelTaskMode #create
					--setCommandPanelTaskMode #modify

						for cur_cloth in cloth_obj_ary do
						(
						select cur_cloth
						addmodifier cur_cloth	 cur_body.modifiers[#Cloth]
						cur_cloth.modifiers[#Cloth].clothOps.setObjectType cur_cloth 2 true
							
						str_ary=filterString cur_cloth.name "_"
							
						if str_ary[2]=="kamz" then
							(
							--assign cloth properties
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "uBend" 25
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "vBend" 25
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "ubCurve" 0.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "vbCurve" 0.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "uStretch" 75
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "vStretch" 75
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "ucompress" 75
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "vcompress" 75
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "shear" 225
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "density" 0.1
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "damping" 0.1
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "plasticity" 0.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "thickness" 0.1
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "repulsion" 1.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "airres" 0.02
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "dynFric" 0.1
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "staticFric" 0.5
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "selfFric" 0.5
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "seamForce" 5000.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "uScale" 1.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "vScale" 1.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "depth" 1.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "offset" 1.0
							--cling not accessible?
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "layer" 0
							)
							
						if str_ary[2]=="pkt" then
							(
							--assign cloth properties
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "uBend" 25
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "vBend" 25
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "ubCurve" 0.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "vbCurve" 0.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "uStretch" 75
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "vStretch" 75
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "ucompress" 75
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "vcompress" 75
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "shear" 225
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "density" 0.1
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "damping" 0.1
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "plasticity" 0.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "thickness" 0.1
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "repulsion" 1.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "airres" 0.02
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "dynFric" 0.1
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "staticFric" 0.5
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "selfFric" 0.5
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "seamForce" 5000.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "uScale" 1.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "vScale" 1.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "depth" 1.0
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "offset" 1.0
							--cling not accessible?
							cur_cloth.modifiers[#Cloth].ClothOps.SetObjectProperty cur_cloth "layer" 0
							)
	
						if str_ary[2]=="shlw" then
							(
							cur_shlw.modifiers[#Cloth].clothOps.setObjectType cur_shlw 1 true
							cur_shlw.modifiers[#Cloth].clothOps.SetObjectProperty cur_shlw "offset" 0.2
							)
							
							--NEED THIS BUT CAUSES SYSTEM EXCEPTION
						select cur_cloth
						--cur_cloth.modifiers[#Cloth].makepointGroup #{1..cur_cloth.verts.count} cur_cloth (cur_cloth.name+"_all")	
						--theGroupRT = cur_cloth.modifiers[#Cloth].getGroupParamBlock (cur_cloth.name+"_all")
						--theGroupRT.Strength=100
						--theGroupRT.Is_Soft=true
						
						--solver settings
						cur_cloth.modifiers[#Cloth].scale=2.54					
						cur_cloth.modifiers[#Cloth].useGravity=true
						cur_cloth.modifiers[#Cloth].gravity=-980.0
						cur_cloth.modifiers[#Cloth].timestep=0.02
						cur_cloth.modifiers[#Cloth].subsample=1
						cur_cloth.modifiers[#Cloth].selfCollision=true
						cur_cloth.modifiers[#Cloth].clothclothMethod=0
						cur_cloth.modifiers[#Cloth].checkIntersections=false
						cur_cloth.modifiers[#Cloth].solidCollision=true
						cur_cloth.modifiers[#Cloth].useSewingSprings=false
						cur_cloth.modifiers[#Cloth].showSewingSprings=false
						cur_cloth.modifiers[#Cloth].simOnRender=false
						--.simPriority
						cur_cloth.modifiers[#Cloth].advancedPinching=false

						)
			

		),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- create sel obj for node groups from selected point objects. made for dupatta and then create node constraint
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
/*
-- run this
pt_ary=selection as array
cur_cloth=$shb_dpt_cloth

mg_anm.cloth_nodeconsel char_str cur_cloth pt_ary
*/		
fn cloth_nodeconsel char_str cur_cloth pt_ary=
	(
	pt_ary=selection as array
	cur_cloth=getNodeByName(char_str+"_dpt_cloth")
		
	for cur_pt in pt_ary do
		(
			cur_sel=plane()
			cur_sel.position=cur_pt.position
			cur_pt_name_ary=filterString cur_pt.name "_"
			cur_sel.name=cur_pt_name_ary[1]+"_"+cur_pt_name_ary[2]+"_sel_"+cur_pt_name_ary[1]+cur_pt_name_ary[2]+cur_pt_name_ary[3]+"_Node"	
			cur_sel.length=cur_pt.size
			cur_sel.width=cur_pt.size
			
			addmodifier cur_sel (Shell ())
			cur_sel.modifiers[#Shell].innerAmount = 1
			cur_sel.modifiers[#Shell].outerAmount = 1
			
			convertToMesh cur_sel
			
			addmodifier cur_cloth (Vol__Select ())
			cur_cloth.modifiers[#Vol__Select].level = 1
			cur_cloth.modifiers[#Vol__Select].volume = 3
			cur_cloth.modifiers[#Vol__Select].node = cur_sel
				
			cur_cloth.modifiers[#Cloth].makepointGroup (getVertSelection cur_cloth) cur_cloth cur_pt_name_ary[3]
										
			cur_cloth.modifiers[#cloth].MakeConstraint cur_pt_name_ary[3] "Node" cur_pt

			deleteModifier cur_cloth cur_cloth.modifiers[#Vol__Select]
		)
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- cloth_con_setup
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
fn cloth_con_setup char_str cur_body cloth_obj_ary sel_obj_ary =
		(
			setCommandPanelTaskMode #modify
			for cur_sel in sel_obj_ary do
					(
						cur_cloth=undefined
						cur_sel_name_ary=filterString cur_sel.name "_"
						
						clth=getNodeByName (char_str+"_"+cur_sel_name_ary[2]+"_cloth")
						cur_cloth=getNodeByName (char_str+"_"+cur_sel_name_ary[2]+"_cloth")
						
						select cur_cloth
						addmodifier cur_cloth (Vol__Select ())
						cur_cloth.modifiers[#Vol__Select].level = 1
						cur_cloth.modifiers[#Vol__Select].volume = 3
						cur_cloth.modifiers[#Vol__Select].node = cur_sel
							
						--getVertSelection cur_cloth
						if cur_cloth.modifiers[#Cloth]!=undefined do
							(		
							cur_cloth.modifiers[#Cloth].makepointGroup (getVertSelection cur_cloth) cur_cloth cur_sel_name_ary[4]

							if cur_sel_name_ary[4]=="cuff" do 
								(
								select cur_cloth
								cur_cloth.modifiers[#Cloth].MakeConstraint cur_sel_name_ary[4] cur_sel_name_ary[5] cur_cloth
								cur_cloth.modifiers[#Cloth].cuff.Is_Soft=true
								theGroupRT = cur_cloth.modifiers[#Cloth].getGroupParamBlock cur_sel_name_ary[4]
								theGroupRT.Strength=10.0
								)
								
							if cur_sel_name_ary[4]=="collar" do
								(
									select cur_cloth
									cur_cloth.modifiers[#Cloth][6]
									cur_cloth.modifiers[#Cloth].MakeConstraint cur_sel_name_ary[4] cur_sel_name_ary[5] cur_cloth
									cur_cloth.modifiers[#Cloth].collar.Is_Soft=true
									cur_cloth.modifiers[#Cloth][6].Is_Soft
									theGroupRT = cur_cloth.modifiers[#Cloth].getGroupParamBlock cur_sel_name_ary[4]
									theGroupRT.Strength=9999.0
								)
								
							if cur_sel_name_ary[4]=="pkt" do
								(
								cur_cloth.modifiers[#Cloth].MakeConstraint cur_sel_name_ary[4] "Cloth" (getNodeByName(char_str+"_kamz_cloth"))
								)
								
							if cur_sel_name_ary[4]=="waist" do 
								(
								cur_cloth.modifiers[#Cloth].MakeConstraint cur_sel_name_ary[4] cur_sel_name_ary[5] cur_cloth
								)
							)

						deleteModifier cur_cloth cur_cloth.modifiers[#Vol__Select]
					)
					setCommandPanelTaskMode #create
					delete $*_sel_*

		for cur_obj in cloth_obj_ary do (cur_obj.modifiers[#Cloth].setObjectType cur_obj 2 true)
		)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		

)