	--user defined
	doSw = false
	unifyState = false
	flipState = false
	varStrLs=#("-VarA_","-VarB_","-VarC_","-VarD_","-VarE_","-VarF_","-VarG_")
	varUse=true
	addPrevColl=false

	--initialize variables
	simNumLs=#()
	rigNumLs=#()
	collideNumLs=#()
	conNumLs=#()
	smdNumLs=#()
	animDrvNumLs=#()
	simObjs=#()
	rigObjs=#()
	collideObjs=#()
	conObjs=#()
	smdObjs=#()
	animDrvObjs=#()
	simPartLs=#()
	simOrderNumLs=#()
	simStrLs=#()
	simOrderLs=#()
	simObjLs=#()
	rigPostObjs=#()

	
struct clothSetup
(
	fn mtlRemove =
	(
		select $*
		for obj in selection do obj.material=undefined
		clearSelection()	
	),
	
	fn existFile fname = 
	(
		(getfiles fname).count != 0
	),

	fn delLayerContents layerName=
	(
		curLayer = LayerManager.getLayerFromName layerName
		if curLayer!=undefined then
		(
		layerNodes = refs.dependents layer
		curLayer.Nodes &theNodesTemp
		delete theNodesTemp
		
		-- delete con layer
		LayerManager.deleteLayerHierarchy layerName forceDelete: true
		)
	),
	
	fn delEmptyLayers =
	(	
		emptyLayers =#()
		for i = 0 to layerManager.count-1 do
		(
			ilayer = layerManager.getLayer i
			layerName = ilayer.name 
			layer = ILayerManager.getLayerObject i
			layerNodes = refs.dependents layer
		---format "Layer: %; nodes: %\n" layerName layerNodes   
			layer.Nodes &theNodesTemp
			if theNodesTemp.count == 0  do
				(
			----print "empty layer"
			append emptyLayers (layerName as string)
		---  print layerName
			)
		)
		format "vazias: % \n" emptylayers
		for i = 1 to emptyLayers.count do
		(
		layermanager.deleteLayerByName emptyLayers[i]
		)
	),

	-- populates object arrays for sim, con, collide etc
	fn objAryCreator layerAry objStr=
	(
		
		if layerAry.count>0 then
		(
			objAry=#()
			for num in layerAry do
			(
				clearSelection()
				curLayer=(LayerManager.getLayer num)
				curLayer.select true
				if objAry.count==0 then objAry = selection as array
				else	objAry = join objAry (selection as array)
				
				clearSelection()
			)
			
			if objAry.count==0 then print  (objStr + " Layer is undefined or misnamed. Needs to contain _" + objStr + "_")
			objAry
		)
	),

	fn skinWrapAdd swObj swMeshlist swEng swWV swUse=
	(
		if swObj.modifiers[#skin_wrap]==undefined and swUse==true then
		(
		addmodifier swObj (skin_wrap())
		swObj.modifiers[#skin_wrap].meshlist=swMeshlist
		swObj.modifiers[#Skin_Wrap].engine = swEng
		swObj.modifiers[#Skin_Wrap].weightAllVerts = swWV
		)
		/*else if swUse==false then
			(
				if swMeshlist.count==1 then
				(
				print ("Skinwrap " + swObj.name + " to " +swMeshlist[1].name)
				)
				else
				(
				print ("Skinwrap " + swObj.name + " to ")
				for mesh in swMeshlist do print mesh.name
				)
			)*/
	),

	fn addDrvBodyColl curSim rigObjs simStr clothMod swUse=
	(
		for curObj in rigObjs do
		(
			if (findString curObj.name "_Rig_X_Body_")!=undefined then
			(
			bodyName=substituteString (substituteString (substituteString curObj.name "_Rig_" "_Cloth_") "_Drv_" "_Collide_") "_Body_"  ("_"+simStr+"-Body_")
			
			--if collLayer == undefined then
			if (LayerManager.getLayerFromName (substituteString curSim.name "_Sim_" "_Collide_"))==undefined then
			(		
			collLayer=LayerManager.newLayer()
			collLayer.setname (substituteString curSim.name "_Sim_" "_Collide_")
			collLayer.ishidden=true
			)
				
			-- if the body obj does not already exist
			if getNodeByName(bodyName)==undefined then
				(
				bodyCollide=snapshot curObj
				bodyCollide.name=bodyName
				bodyCollide.wirecolor= (color 255 0 0)
					
				clothSetup.skinWrapAdd bodyCollide #(curObj) 0 true swUse
				clearSelection()
				addmodifier bodyCollide curSim.modifiers[#Cloth]
					
				select bodyCollide
				max modify mode
				bodyCollide.modifiers[#Cloth].clothOps.setObjectType bodyCollide 1 true
				clothMod.setObjectProperty bodyCollide "depth" 0.2
				clothMod.setObjectProperty bodyCollide "offset" 0.2
				clearSelection()
				max create mode
					
				collLayer=LayerManager.getLayerFromName (substituteString  curSim.name "_Sim_" "_Collide_")
				collLayer.addnode bodyCollide
				)
			)
		)	
	),

	fn varSetup=
	(
		
	--initialize variables
	simNumLs=#()
	rigNumLs=#()
	collideNumLs=#()
	conNumLs=#()
	smdNumLs=#()
	animDrvNumLs=#()
	simObjs=#()
	rigObjs=#()
	collideObjs=#()
	conObjs=#()
	smdObjs=#()
	animDrvObjs=#()
	simPartLs=#()
	simOrderNumLs=#()
	simStrLs=#()
	simOrderLs=#()
	
	simObjLs=#()
	simNum = undefined
	
	max create mode
	
		-- find sim, rig and collide layers
		for layerNum in 0 to (LayerManager.count-1) do
		(
			if (findString (LayerManager.getLayer layerNum).name "_Sim_")!=undefined then simNumLs[simNumLs.count+1]=copy layerNum
			if (findString (LayerManager.getLayer layerNum).name "_Rig_")!=undefined then rigNumLs[rigNumLs.count+1]=copy layerNum
			if (findString (LayerManager.getLayer layerNum).name "_Collide_")!=undefined then collideNumLs[collideNumLs.count+1]=copy layerNum
			if (findString (LayerManager.getLayer layerNum).name "_Con_")!=undefined then conNumLs[conNumLs.count+1]=copy layerNum
			if (findString (LayerManager.getLayer layerNum).name "_Smd_")!=undefined then smdNumLs[smdNumLs.count+1]=copy layerNum
			if (findString (LayerManager.getLayer layerNum).name "_animDrv")!=undefined then animDrvNumLs[animDrvNumLs.count+1]=copy layerNum
		)

		-- populate arrays with corresponding objects
		simObjs = clothSetup.objAryCreator simNumLs "Sim"
		
		if simObjs!=undefined then
		(
			if simObjs.count>0 then for curObj in simObjs do curObj.wirecolor=(color 0 255 0)
			
			-- reorder simObjs
			simNumLs = #()
			simNum = undefined
			for curSim in simObjs do
			(
				if (findString curSim.name "_Sim") != 0 then
				(
				simStrLs = filterString curSim.name "_"
				simNum = substituteString simStrLs[6] "Sim" ""
				
				--added the "00" so it is unique from the number at the end
				simNumLs[simNumLs.count+1] = "00"+simNum + "_" + curSim.name
				)
			)

			simOrderLs = sort simNumLs
			simObjs = #()
			
			for simStr in simOrderLs do
			(
			simStrLs = filterString simStr "_"
			simObjs[simObjs.count+1]=getNodeByname(substituteString simStr (simStrLs[1]+"_") "")
			)
		)

		rigObjs = clothSetup.objAryCreator rigNumLs "Rig"
		collideObjs = clothSetup.objAryCreator collideNumLs "Collide"	
		if collideObjs!=undefined then (if collideObjs.count>0 then for curObj in collideObjs do curObj.wirecolor=(color 255 0 0))

		conObjs = clothSetup.objAryCreator conNumLs "Con"
		smdObjs = clothSetup.objAryCreator smdNumLs "Smd"
		animDrvObjs= clothSetup.objAryCreator animDrvNumLs "animDrv"	
		--end fn varSetup
	),

	fn rigSetup rigObjs animDrvObjs rigPostObjs swUse=
	(
		max create mode
		drvLs=undefined
		
		if rigObjs!=undefined then
		(
			-- setup rig objects
			for curObj in rigObjs do
			(
				if curObj.modifiers[#Skin_Wrap]==undefined then
				(
					rigStrLs=filterString curObj.name "_"
					rigStr=undefined
						
					if rigStrLs[rigStrLs.count]=="Drv" then
					(
						rigStr=rigStrLs[5]
					)
					else
					(
						rigStr=rigStrLs[7]
					)
									
					curanimDrv=undefined
								
					for animDrv in animDrvObjs do
					(
						animDrvConObj=filterString animDrv.name "_"
						animDrvStr=copy animDrvConObj[5]
							
						if animDrvStr==rigStr then curanimDrv=animDrv
					)
						if (rigStr=="Body") and (selectionSets[#_body_drv]!=undefined) then 	
						(
							clearSelection()
							select selectionSets[#_body_drv]
							drvLs=(selection as array)
						)
						else if curanimDrv!=undefined then drvLs=#(curanimDrv)
						
						if drvLs!=undefined then clothSetup.skinWrapAdd curObj drvLs 0 true swUse
									
					--remove override portion of name
					if rigStrLs[rigStrLs.count]!="Drv" then
					(
						curObj.name=(substituteString curObj.name ("_"+rigStrLs[7]+"_") "_")
						rigPostObjs[rigPostObjs.count+1]=curObj
					)
				)
			)
			clearSelection()	
		)
		else print "Skipping Rig objects setup."
	),
	--end rig setup fn

	--start rig post fn to setup smd with duplicate rig objects if needed
	fn rigSetupPost simObjs swUse=
	(
		max create mode
		drvLs=undefined
		rigLayer=undefined
		
		for simObj in simObjs do
		(
			if rigLayer==undefined then
			(
				simStrLs=filterString simObj.name "_"
				layerName= simStrLs[1]+"_"+simStrLs[2]+"_Rig_"

				rigLayer=LayerManager.getLayerFromName layerName
			)
				
			if simObj.modifiers[#skin_wrap]!=undefined then
			(
				simDrvLs=simObj.modifiers[#skin_wrap].meshlist
				
				if (findString simDrvLs[1].name "_Drv_")!=undefined  then
				(
					newDrv=snapshot simDrvLs[1]
					rigLayer.addnode newDrv
					clothSetup.skinWrapAdd newDrv #(simObj) 0 true swUse
					newDrv.name=substituteString simDrvLs[1].name "_Drv_" "2_Drv_"
					simDrvLs[1].name=substituteString simDrvLs[1].name "_Drv_" "1_Drv_"
					
					if simDrvLs[1].modifiers[#skin_wrap]!=undefined then
					(
						if simDrvLs[1].modifiers[#skin_wrap].meshlist[1]!=undefined then
						(
							tmpStr=substituteString simDrvLs[1].modifiers[#skin_wrap].meshlist[1].name "_Mesh_" "_Cloth_"

							curSmd=getNodeByName ((substring tmpStr 1 (tmpStr.count-1))+"-Smd_")
							
						)
							if curSmd!=undefined then
							(
								clothSetup.skinWrapAdd curSmd #(newDrv) 0 true swUse
							)
						)
					)
				)
			)
		),
	-- end rig post fn
					
	fn simSetup simObjs animDrvObjs collideObjs varStrLs varUse swUse =
	(
		max create mode

		-- sort sim objs by sim order number appended to name
		if simObjs!=undefined then
		(
			simOrderLs = #()
			simStrLs = #()
			simObjPrev = undefined
			
			for simObj in simObjs do
			(
				strLs = filterString simObj.name "_"
				simNum = (substituteString strLs[6] "Sim" "") as integer

				--record sim layer number and sim object
				simStrLs[simStrLs.count+1]=(simNum as string) + "_" + simObj.name
			)
			
			simOrderLs = sort simStrLs
			simOrderNumLs=#()
			
			for str in simOrderLs do
			(
				strLs = filterString str "_"
				simOrderNumLs[simOrderNumLs.count+1] = strLs[1] as integer
				simPartLs[simPartLs.count+1] = strLs[6]
			)
			-- end sorting sim objs by sim order
		)
		
		--START sim obj setup
		if simObjs!=undefined then
		(
			count = 0
			for curSim in simObjs do
			(
				count += 1
				-- put each sim obj or group of them with the same number in their own layer
				conObj=filterString curSim.name "_"
				simStr=copy conObj[5]
				simNum=(substituteString (copy conObj[6]) "Sim" "") as integer
				curSim.name=(substituteString curSim.name (copy conObj[6]) "Sim")

				--in case the name was changed because it had a number, redefine these variables
				conObj=filterString curSim.name "_"
				simStr=copy conObj[5]

				simNumPrev = 0
				simObjPrev = undefined
				
				--check if sim num has been created
				if count > 1 then
				(
				simObjPrev = simObjs[count-1]
				simNumPrev = simOrderNumLs[count-1]
				)
				
				if simNum != simNumPrev then simObjPrev = undefined
				
					--skinwrap to animDrv or Drv if one exists
					for animDrv in animDrvObjs do
					(
						curDrv=undefined

						animDrvConObj=filterString animDrv.name "_"
						animDrvStr=copy animDrvConObj[5]

						drv_name=substituteString (substituteString curSim.name "_Sim_" "_Drv_") "_Cloth_" "_Rig_"
						
						if (getNodeByName drv_name)!=undefined then (curDrv=getNodeByName drv_name)
							
						--if the obj does not have a skinwrap override
						if conObj[conObj.count]=="Sim" then 
						(
							if curDrv==undefined and animDrvStr==simStr and curSim.modifiers[#Skin_Wrap]==undefined then (clothSetup.skinWrapAdd curSim #(animDrv) 0 true swUse)
							
							if curDrv!=undefined and curSim.modifiers[#Skin_Wrap]==undefined then	(clothSetup.skinWrapAdd curSim #(curDrv) 0 true swUse)
						)

						--if the obj has a skinwrap override
						else
							(
								if animDrvStr==conObj[7] and curSim.modifiers[#Skin_Wrap]==undefined then
									(
										clothSetup.skinWrapAdd curSim #(animDrv) 0 true swUse
										curSim.name=substituteString curSim.name ("_"+conObj[7]) ""
									)
							)
					)
				
				curLayer=undefined
					
				--if this sim obj is not part of an existing simulation layer	
				if simObjPrev==undefined then
				(
					curLayer=LayerManager.newLayer()
					curLayer.addnode curSim
					curLayer.setname curSim.name
					curLayer.ishidden=true
					
					addmodifier curSim (Cloth())
				)
				--if this sim obj is part of an existing simulation layer	
				else
				(
					-- changed
					curLayer=LayerManager.getLayerFromName simObjs[finditem simOrderNumLs simNum].name
					curLayer.addnode curSim
					curLayer.ishidden=true
					
					addmodifier curSim simObjPrev.modifiers[#cloth]
				)
				
				clothMod=curSim.modifiers[#Cloth]

				--set cloth modifier setting of obj to type cloth
				select curSim
				max modify mode
				clothMod.clothOps.setObjectType curSim 2 true
				clothMod.scale  = 2.54
				clothMod.useGravity = true
				clothMod.gravity = -980.0
				clothMod.useSewingSprings = off
				clothMod.showSewingSprings = off
				clothMod.timestep = 0.02
				clothMod.subsample = 1
				clothMod.solidCollision = true
				clothMod.startFrame = 0
				clothMod.selfCollision = true
				clothMod.advancedPinching = off
				
				clearSelection()
				max create mode
				
				tmpLayer=LayerManager.getLayerFromName curSim.name
					
				------------------------------------
				------ collision
				if collideObjs!=undefined and tmpLayer!= undefined then
				(
					if collideObjs.count > 0 then
					(
					collLayer=LayerManager.newLayer()
					collLayer.setname (substituteString  curSim.name "_Sim_" "_Collide_")
					collLayer.ishidden=true

					--cycle through collide objects and setup appropriate ones
					for curCollide in collideObjs do
					(
						new_collide=undefined
						conObj=filterString curCollide.name "_"
						collideStr=copy conObj[5]
						
						--check if the collide goes with a different variation
						simLayerStr=undefined
						collideLayerStr=undefined
						for str in varStrLs do
						(
							if (findString curSim.name str)!=undefined then simLayerStr=copy str
							if (findString curCollide.name str)!=undefined then collideLayerStr=copy str
						)
						

						if simStr!=collideStr and ((simLayerStr==collideLayerStr) or (simLayerStr==undefined or collideLayerStr==undefined)) then
						(
							--test layer order
							collPart=finditem simPartLs collideStr
		
							if collPart>0 then collideOrderNum = simOrderNumLs[collPart]
							else collideOrderNum = undefined
		
							simPart=finditem simPartLs simStr

							if simPart>0 then simOrderNum=simOrderNumLs[simPart]
							else simOrderNum = undefined

							--these objects are collides for all sim layers after the sim obj they match part name with
							if conObj[conObj.count]=="Collide" and simOrderNum!=undefined and collideOrderNum!=undefined and simOrderNum>collideOrderNum and simOrderNum!=1 then
							(
								newCollide = snapshot curCollide
								newCollide.wirecolor = (color 255 0 0)

								--rename collision object to include sim layer name
								newCollide.name=substituteString curCollide.name collideStr (simStr + "-" + collideStr)
								collLayer.addnode newCollide
												
								--skinwrap to animDrv
								curanimDrv=undefined
								
								-- if there is a sim driver, use it, otherwise use an animdrv
								if newCollide.modifiers[#Skin_Wrap]==undefined then
								(
										simDrvStr = substituteString newCollide.name "_Collide_" "_Sim_"
										partStr = filterString simDrvStr "_"
										simDrvStr = substituteString simDrvStr partStr[5] collideStr
									
										if getNodeByName simDrvStr != undefined then 
										(
											clothSetup.skinWrapAdd newCollide #((getNodeByName simDrvStr)) 0 true swUse
										)
										else 
										(
											-- skinwrap to appropriate object
											for animDrv in animDrvObjs do
											(
												animDrvConObj=filterString animDrv.name "_"
												animDrvStr=copy animDrvConObj[5]
																	
												if animDrvStr==collideStr and newCollide.modifiers[#Skin_Wrap]==undefined then
												(
													clothSetup.skinWrapAdd newCollide #(animDrv) 0 true swUse
												)
											)					
										)
								)					
												
								--add to sim obj cloth modifier
								addmodifier newCollide clothMod

								select newCollide
								max modify mode
								clothMod.clothOps.setObjectType newCollide 1 true
								clothMod.setObjectProperty newCollide "depth" 0.2
								clothMod.setObjectProperty newCollide "offset" 0.2
													
								clearSelection()
								max create mode
							)
							else
							(
								--curCollide object is custom to a specific layer
								--only add it if this current sim obj corresponds to it
								if simStr==conObj[8] then
								(
									newCollide=snapshot curCollide
									newCollide.wirecolor=(color 255 0 0)

									collLayer.addnode newCollide
													
									--skinwrap to animDrv
									curanimDrv=undefined
													
									for animDrv in animDrvObjs do
									(
										animDrvConObj=filterString animDrv.name "_"
										animDrvStr=copy animDrvConObj[5]
													
										--animDrv matches collide object name and it does not already have a skinwrap		
										if animDrvStr==conObj[7] and newCollide.modifiers[#Skin_Wrap]==undefined then
										(
											clothSetup.skinWrapAdd newCollide #(animDrv) 0 true swUse
																	
											--correct newCollide name by removing extra parts
											newCollide.name=curCollide.name
											if conObj[8]!=undefined then newCollide.name=substituteString newCollide.name ("_"+conObj[8]+"_") "_"
											newCollide.name=substituteString newCollide.name ("_"+conObj[7]+"_") "_"
											newCollide.name=substituteString newCollide.name collideStr (simStr + "-" + collideStr)
										)
									)					
								)
								--end custom driver matches sim obj
							)
							--end custom driver loop
							
							-- if the collide is meant for all layers, but does not match a sim obj part name
							if conObj[conObj.count]=="Collide" and collideOrderNum==undefined then
							(
								newCollide=snapshot curCollide
								newCollide.wirecolor=(color 255 0 0)
								newCollide.name=substituteString curCollide.name collideStr (simStr + "-" + collideStr)
								collLayer.addnode newCollide

									-- skinwrap to appropriate object
									for animDrv in animDrvObjs do
									(
										animDrvConObj=filterString animDrv.name "_"
										animDrvStr=copy animDrvConObj[5]
															
										if animDrvStr==collideStr and newCollide.modifiers[#Skin_Wrap]==undefined then
										(
											clothSetup.skinWrapAdd newCollide #(animDrv) 0 true swUse
										)
									)	
							)
							
							if newCollide!=undefined and newCollide.modifiers[#cloth]==undefined then
							(
									select newCollide
									max modify mode

									--add to sim obj cloth modifier
									addmodifier newCollide clothMod
									
									clothMod.clothOps.setObjectType newCollide 1 true
									clothMod.setObjectProperty newCollide "depth" 0.2
									clothMod.setObjectProperty newCollide "offset" 0.2
									clearSelection()
									max create mode
							)
						)
						--end if simStr!=collideStr
					)
					-- end collide objs loop

								--if body collide not added check if there is a body collide drv and add it as a collision
								if collLayer!=undefined then
								(
									collLayer.select true
									collObjs = selection as array
									clearSelection()
									
									bodyFound=false
									
									for curColl in collObjs do (if (findString curColl.name "Body_")!=undefined then bodyFound=true)
									
									-- if there isn't already a collision named 'body'
									if bodyFound==false then
									(
										clothSetup.addDrvBodyColl curSim rigObjs simStr clothMod swUse
									)
									--end if bodyFound== false
								)	
								--end if collision layer undefined
					)
					-- end collideObjs.count>0
				)
				-- end if collideObjs!=undefined
				else
				(
					if tmpLayer!= undefined then
					(
						-- add body collision driver if it exists
						clothSetup.addDrvBodyColl curSim rigObjs simStr clothMod swUse
					)
				)
	------------------------------------			

			)
			--end sim loop
		)
		else
		(
			print "Skipping Sim objects setup."
		)
	),
	-- end sim setup fn

	fn conSetup conObjs simObjs=
	(
		max create mode

		if conObjs!=undefined then
		(
			--add constraints
			for conObj in conObjs do
				(	
					for curObj in simObjs do
						(
							conLs=filterString curObj.name "_"
							
							if (findString conObj.name conLs[5])!=undefined then
								
								(
									conLs=filterString conObj.name "_"
									
									max modify mode
									select curObj
									addmodifier curObj (vol__select())
									curObj.modifiers[#Vol__Select].level = 1
									curObj.modifiers[#Vol__Select].volume = 3
									curObj.modifiers[#Vol__Select].node = conObj
																		
									vertSel=curObj.selectedVerts as bitArray
										
										conName=undefined

										if conLs[5]!=undefined then
											(
												conName=(conLs[1]+"_"+conLs[4]+"_"+conLs[5])	
											)
											else
												(
													if conLs[4]!=undefined then conName=(conLs[1]+"_"+conLs[4])	
												)
												
												if conName==undefined then conName = conLs[1]
														
									curObj.modifiers[#Cloth].makepointGroup vertSel curObj conName

									if conLs[4]== "Pres" then
										(
											curObj.modifiers[#cloth].MakeConstraint conName "Preserved" curObj
											curCon=curObj.modifiers[#cloth].getGroupParamBlock(conName)
											curCon.useGroupBehavior=true
											curCon.Grp_Solid_Collision=false						
										)
									
									if classof curObj.modifiers[1]==Vol__Select then deletemodifier curObj 1
									max create mode
									)
						)
				)
		)
		else
		(
			print "Skipping Constraint setup."
		)
	),
	--end con setup

	fn smdSetup simObjs smdObjs swUse=
	(
		max create mode

		--skinwrap Smd to corresponding Sim object
		if smdObjs!=undefined then
		(
			for curSmd in smdObjs do
			(
				smdConObj=filterString curSmd.name "_"
				smdStr=smdConObj[5]

				-- search for a sim obj match
				for simObj in simObjs do
				(
				simConObj=filterString simObj.name "_"
				simStr=copy simConObj[5]
					
						--if it matches, skinwrap to it
						if (smdStr==simStr) and (curSmd.modifiers[#skin_wrap]==undefined) then
						(
							clothSetup.skinWrapAdd curSmd #(simObj) 0 true swUse
						)
					)
					
					if curSmd.modifiers[#skin_wrap]==undefined then
					(
						tmpStr=(subString curSmd.name 1 (curSmd.name.count-5))+"_"
						
						curanimDrv=getNodeByName(substituteString tmpStr "_Cloth_" "_Mesh_")

						clothSetup.skinWrapAdd curSmd #(curanimDrv) 0 true swUse
					)
			)
		)
		else
		(
			print "Skipping Smd setup."
		)
	),
	--end smd setup fn

	----------	
	--cleanup
	----------
	fn sceneCleanup=
	(
		strLs = filterString simObjs[1].name "_"
		charStr=(strLs[1]+"_"+strLs[2])

		default = LayerManager.getLayerFromName "0"
		default.current = true
		
		-- delete layers with objects
		clothSetup.delLayerContents (charStr+"_Con_")
		clothSetup.delLayerContents (charStr+"_Collide_")
		clothSetup.delLayerContents (charStr+"_Sim_")

		-- delete empty layersdelEmptyLayers
		clothSetup.delEmptyLayers()
		
		-- add named selection sets for Sim and Rig
		selectionSets["_Sim"] = $*_Sim_*
		selectionSets["_Rig"] = $*_Rig_*
	),

	-- lock transforms for selected objects
	fn lockAllTransforms objLs=
	(
		setTransformLockFlags objLs #all
	),
	
	-- resets the cloth state for selected cloth objs
	fn resetCloth objLs=
	(
		startFrame=copy sliderTime
		
		max modify mode
		for obj in objLs do 
		(
			
			if obj.modifiers[#cloth]!=undefined then
			(
				obj.modifiers[#cloth].startframe = startFrame
				obj.modifiers[#cloth].resetState obj
			)
		)
		max create mode
	),

-- sim selected sim objects in the order they were selected
	fn simCloth objLs=
	(
		startFrame= animationRange.start
		max modify mode
		for obj in objLs do 
		(
			sliderTime = animationRange.start

			select obj
			
			if obj.modifiers[#cloth]!=undefined then
			(				
				obj.modifiers[#cloth].startframe = startFrame
				obj.modifiers[#cloth].resetState obj
				obj.modifiers[#cloth].simulate true
			)
		)
		clearSelection()
		
		max create mode
	),

	-- make layer current and run to change naming from Mesh to AnimDrv
	fn LayerRenameAnimDrv curLayer =
	(
	if (findString curLayer.name "_Mesh_") != undefined then curLayer.setname (substituteString curLayer.name "_Mesh_" "_AnimDrv_")
	else
		(
			if (findString curLayer.name "_Mesh") != undefined then curLayer.setname (substituteString curLayer.name "_Mesh" "_AnimDrv_")
		)
	),

	--create animdrivers selection set
	fn animDrvCreate ObjLs=
	(
		selectionSets["_Anim-Drv"] = $'*_Mesh_*'
	),
	
	--select animdrvers and run script to snapshot and rename to smd
	fn smdCreate ObjLs =
	(
		selectionSets["_Anim-Drv"] = ObjLs
		
		strLs = filterString ObjLs[1].name "_"
		layerName = strLs[1]+"_"+strLs[2]+"_Cloth_X_Smd_"
		smdLayer=LayerManager.newLayer()
		smdLayer.setname layerName
		smdLayer.ishidden=false
			
		for obj in ObjLs do
		(
			curSmd = snapshot obj
			curSmd.name = substituteString obj.name "_Mesh_" "_Cloth_"
			curSmd.name = (substring curSmd.name 1 (curSmd.name.count-1))+"-Smd_"
			smdLayer.addnode curSmd
		)

		selectionSets["_PC to SA (Smd)"] = $'*-Smd_'
	),
	
	--create BoXMode selection set
	fn createBoxMode =
	(
		animDrvLs = #()
		objLs = $'*-Smd_'

		for obj in objLs do
		(
			objStrLs = filterString obj.name "_"
			animDrv = getNodeByName (substituteString (substituteString obj.name "_Cloth_" "_Mesh_") "-Smd_" "_")
			if animDrv != undefined then animDrvLs[animDrvLs.count + 1] = animDrv
		)

		selectionSets["_BoxMode"] = animDrvLs		
	),
		
	fn randObjColor objLs =
	(
		-- randomize wire color for selected objects
		for obj in objLs do (obj.wirecolor= (color (random 1 255) (random 1 255) (random 1 255)))
	),
	
	fn smoothNormal objLs=
	(
		for obj in objLs do
		(
			addmodifier obj (Smooth())
			obj.modifiers[#Smooth].autosmooth = on
			obj.modifiers[#Smooth].Threshold = 180

			collapseStack obj
		)
	),

	--selects all Smd objects, unhides them and hides their corresponding anim drivers.
	fn smdVis=
	(
		for layer_num in 0 to (LayerManager.count-1) do
		(
			if ((findString (LayerManager.getLayer layer_num).name "_AnimDrv_")!=undefined) or ((findString (LayerManager.getLayer layer_num).name "_Smd_")!=undefined) then
				(
					-- get an array of sim objs
					cur_layer=(LayerManager.getLayer layer_num)
					cur_layer.ishidden=false
					cur_layer.select true
					unhide selection
					clearSelection()
				)
		)

		select $*Smd_

		for cur_obj in selection do
		(
		cur_str=cur_obj.name
		str_ary=filterString cur_str "_"
		--str_part=substituteString (str_ary[str_ary.count]) "-Smd_" "_"
		new_str=(substitutestring (substitutestring cur_str "_Cloth_" "_Mesh_") "-Smd_" "_")

		if (getNodeByName new_str)!=undefined then hide (getNodeByName new_str)
		else (unhide (getNodeByName new_str))
		)
	),

	-- print the names of the objects that each selected obj is skinwrapped to
	fn selectSW objLs =
	(	
		for obj in objLs do
		(
			if obj.modifiers[#skin_wrap]!=undefined then
			(
				--print (obj.name + (" is skinwrapped to "))
				for drvObj in (obj.modifiers[#skin_wrap].meshlist as array) do print drvObj.name
				if objLs.count==1 then select (obj.modifiers[#skin_wrap].meshlist as array)
			)
		)
		--open listener
		--actionMan.executeAction 0 "40472"
	),

	--fixes objects with messed up normals and readds skinwrap
	fn fixNormal objLs flipState unifyState =
	(
		for obj in objLs do
		(
			if obj.modifiers[#cloth]==undefined then
			(
				if obj.modifiers[#skin_wrap]!=undefined then
				(
					swLs=obj.modifiers[#skin_wrap].meshlist as array
					deletemodifier obj 1
					addmodifier obj (Normalmodifier())
					obj.modifiers[#Normal].flip=flipState
					obj.modifiers[#Normal].unify=unifyState	
					collapseStack obj
					clothSetup.skinWrapAdd obj swLs 0 true true
				)
				else
				(
					addmodifier obj (Normalmodifier())
					obj.modifiers[#Normal].flip=flipState
					obj.modifiers[#Normal].unify=unifyState	
					collapseStack obj
				)
			)
			else (print ("Skipped cloth object " + obj.name + "."))
		)
	),	
	fn meshCollapseToOrigin inputLs =
	(
		/*
		__MXSDOC__
		[TITLE]
		meshColapseToOrigin

		[DESCRIPTION]
		This will collapse the geometric objects you have selected to have their pivot at the origin, all vertex info will be relative to the origin
		Also gets rid of any Hierarchy/Linking, this is important for PointCache / Scene Assembly

		[USAGE]
		1. Select objects to collapse, Run Script

		[CREATION INFO]
		Author:Remi McGill
		E-mail:beta@blur.com
		Company:Blur Studios
		Last Updated:June 11, 2004


		__END__
		*/
		if $ != undefined do
		(
		CurrentCommandPanelToggleState = cui.commandPanelOpen
		CurrentCommandPanelState = getCommandPanelTaskMode()
		cui.commandPanelOpen = false
		max modify mode
		rollout PolyCollapseToOriginDialog "Poly Collapse to Origin" width:525 height:30
			(
				label ProgressInfo "Poly Collapse to Origin" pos:[10,2] width:505 height:20
				progressBar PolyCollapseToOrigin "" pos:[10,20] width:505 height:8
			)
			createdialog PolyCollapseToOriginDialog
			
		local selectionArray = inputLs
		local selectionArrayNew = #()
		local i = 0
		ProgressSteps = 100 / selectionArray.count
		max select none
		for objSlave in selectionArray where superclassof objSlave == GeometryClass do
			(
			with redraw off
				(
					local objSlaveLayer = objSlave.layer
					local objSlaveMaterial = objSlave.material
					local objSlaveName = objSlave.name
					local objMaster = Box lengthsegs:1 widthsegs:1 heightsegs:1 isSelected:on
					
					--Save Slave Object Properties
						local ObjSlaveBoxmode = ObjSlave.Boxmode
						local ObjSlaveShowFrozenInGray = ObjSlave.ShowFrozenInGray
						local ObjSlaveBackfacecull = ObjSlave.Backfacecull
						local ObjSlaveAlledges = ObjSlave.Alledges
						local ObjSlaveXray = ObjSlave.Xray
						local ObjSlaveIgnoreExtents = ObjSlave.IgnoreExtents
						local ObjSlaveVertexTicks = ObjSlave.VertexTicks
						local ObjSlaveShowTrajectory = ObjSlave.ShowTrajectory
						local ObjSlaveRenderable = ObjSlave.Renderable
						local ObjSlaveCastShadows = ObjSlave.CastShadows
						local ObjSlaveReceiveshadows = ObjSlave.Receiveshadows
						local ObjSlaveApplyAtmospherics = ObjSlave.ApplyAtmospherics
						local ObjSlaveMotionblur = ObjSlave.Motionblur
						local ObjSlaveInheritVisibility = ObjSlave.InheritVisibility
						local ObjSlaveRenderOccluded = ObjSlave.RenderOccluded
						local ObjSlavePrimaryVisibility = ObjSlave.PrimaryVisibility
						local ObjSlaveSecondaryVisibility = ObjSlave.SecondaryVisibility
						local ObjSlaveMotionBlurOn = ObjSlave.MotionBlurOn

					PolyCollapseToOriginDialog.ProgressInfo.caption = ("Object: " + objSlaveName as string)
					PolyCollapseToOriginDialog.PolyCollapseToOrigin.value = ProgressSteps * i
					
					objMaster.material = objMaterial
					objMaster.wirecolor = objSlave.wirecolor
					select objMaster
						
					--Load Slave Object Properties On Master
						ObjMaster.boxmode = ObjSlaveBoxmode
						ObjMaster.showFrozenInGray = ObjSlaveShowFrozenInGray
						ObjMaster.backfacecull = ObjSlaveBackfacecull
						ObjMaster.alledges = ObjSlaveAlledges
						ObjMaster.xray = ObjSlaveXray
						ObjMaster.ignoreExtents = ObjSlaveIgnoreExtents
						ObjMaster.vertexTicks = ObjSlaveVertexTicks
						ObjMaster.showTrajectory = ObjSlaveShowTrajectory
						ObjMaster.renderable = ObjSlaveRenderable
						ObjMaster.castShadows = ObjSlaveCastShadows
						ObjMaster.receiveshadows = ObjSlaveReceiveshadows
						ObjMaster.applyAtmospherics = ObjSlaveApplyAtmospherics
						ObjMaster.motionblur = ObjSlaveMotionblur
						ObjMaster.inheritVisibility = ObjSlaveInheritVisibility
						ObjMaster.renderOccluded = ObjSlaveRenderOccluded
						ObjMaster.primaryVisibility = ObjSlavePrimaryVisibility
						ObjMaster.secondaryVisibility = ObjSlaveSecondaryVisibility
						ObjMaster.motionBlurOn = ObjSlaveMotionBlurOn

					convertTo objMaster PolyMeshObject
					polyOp.attach objMaster objSlave
					max modify mode
					subobjectLevel = 1
					objMaster.EditablePoly.SetSelection #Vertex #{1..8}
					objMaster.EditablePoly.delete 1
					objMaster.name = objSlaveName
					subobjectLevel = 0
					i += 1
					selectionArrayNew[i] = objMaster
					convertTo objMaster Editable_mesh
					objSlaveLayer.addNode objMaster
					)
				)
		destroyDialog PolyCollapseToOriginDialog
		cui.commandPanelOpen = CurrentCommandPanelToggleState
		setCommandPanelTaskMode = CurrentCommandPanelState
		select selectionArrayNew
		)
	)

)
-- end struct
---------------------------------------------------------
-- UI
---------------------------------------------------------

rollout ClothSetupRollout "Cloth Setup" width:182 height:330
(
	button 'varSetup_btn' "Variable Setup" pos:[10,10] width:143 height:30 toolTip:"Click to setup variables." align:#left
	checkbox 'sw_chk' "Skinwrap" checked: false pos:[12,50] width:140 height:40 toolTip: "Uncheck for faster testing" align:#left
	button 'rigSetup_btn' "Rig Setup" pos:[10,90] width:143 height:30 toolTip:"Setup Rig and Drv objects" align:#left
	button 'simSetup_btn' "Sim Setup" pos:[10,130] width:143 height:30 toolTip:"Setup Sim and Collide Objects" align:#left
	button 'rigPostSetup_btn' "Rig Post Setup" pos:[10,170] width:143 height:30 toolTip:"Setup Rig to Smd if needed." align:#left
	button 'smdSetup_btn' "Smd Setup" pos:[10,210] width:143 height:30 toolTip:"Skinwraps Smd to Objects" align:#left
	button 'ConSetup_btn' "Constraint Setup" pos:[10,250] width:143 height:30 toolTip:"Setup Cloth Constraints" align:#left
	button 'Cleanup_btn' "Cleanup Scene" pos:[10,290] width:143 height:30 toolTip:"Removes cloth setup objects" align:#left
	groupBox 'fixNormalGrp' "fix normal" pos:[10,330] width:140 height:100 
	button 'fixNormal_btn' "Fix Normal" pos:[13,350] width:133 height:20 toolTip:"Fixes normals on selected objects and readds skinwrap." align:#left
	--button 'runAllSetup_btn' "Full Setup" pos:[10,330] width:143 height:30 toolTip:"Runs the whole setup." align:#left
	checkbox 'flipState_chk' "Flip" checked: false pos:[17,385] width:70 height:40 toolTip: "Flip Normals" align:#left
	checkbox 'unifyState_chk' "Unify" checked: false pos:[87,385] width:70 height:40 toolTip: "Unify Normals" align:#left

	
	on varSetup_btn pressed  do
	(
		-- first time simObjs contains a lot of other objects
		clothSetup.varSetup()
		clothSetup.varSetup()
	)
	on rigSetup_btn pressed  do
	(
		clothSetup.rigSetup rigObjs animDrvObjs rigPostObjs doSw
	)
	on simSetup_btn pressed  do
	(
		clothSetup.simSetup simObjs animDrvObjs collideObjs varStrLs varUse doSw
	)
	on ConSetup_btn pressed  do
	(
		clothSetup.conSetup conObjs simObjs
	)
	on rigPostSetup_btn pressed  do
	(
		clothSetup.rigSetupPost simObjs doSw
	)	
	on SmdSetup_btn pressed  do
	(
		clothSetup.smdSetup simObjs smdObjs doSw
	)
	on Cleanup_btn pressed  do
	(
		clothSetup.sceneCleanup()
	)
	on fixNormal_btn pressed do
	(
		clothsetup.fixNormal selection flipState unifyState
	)
	on flipState_chk changed theState do 
	(
	flipState = theState
	)
	on unifyState_chk changed theState do 
	(
	unifyState = theState
	)
	on sw_chk changed theState do 
	(
	doSw = theState
	)
	on runAllSetup_btn pressed do
	(
		-- first time simObjs contains a lot of other objects
		clothSetup.varSetup()
		clothSetup.varSetup()
		clothSetup.rigSetup rigObjs animDrvObjs rigPostObjs doSw
		clothSetup.simSetup simObjs animDrvObjs collideObjs varStrLs varUse doSw
		clothSetup.rigSetupPost simObjs doSw
		clothSetup.smdSetup simObjs smdObjs doSw
		clothSetup.conSetup conObjs simObjs
		clothSetup.sceneCleanup()
	)
)

rollout ClothSetupStartRollout "Scene Setup" width:182 height:330
(
	button 'LayerRenameAnimDrv_btn' "AnimDrv Layer Rename" pos:[10,10] width:143 height:30 toolTip:"Make Layer Current and click to change layer name from Mesh to AnimDrv." align:#left
	button 'animDrvCreate_btn' "AnimDrv Create" pos:[10,50] width:143 height:30 toolTip:"Creates AnimDrv Selection Set." align:#left
	button 'smdCreate_btn' "Smd Create" pos:[10,90] width:143 height:30 toolTip:"Create Smd objects and layer from selected objects." align:#left
	button 'createBoxMode_btn' "BoxMode Create" pos:[10,130] width:143 height:30 toolTip:"Creates the BoxMode selection Set." align:#left
	button 'randObjColor_btn' "Random Color" pos:[10,170] width:143 height:30 toolTip:"Assign random wire color to selected objects." align:#left
	button 'smoothNormal_btn' "Smooth Normals" pos:[10,210] width:143 height:30 toolTip:"Smooths normals for selected objects." align:#left
	button 'lockAllTransforms_btn' "Lock Transforms" pos:[10,250] width:143 height:30 toolTip:"Locks transforms on selected objects." align:#left
	
	on LayerRenameAnimDrv_btn pressed do
	(
		clothSetup.LayerRenameAnimDrv LayerManager.current
	)	
	on animDrvCreate_btn pressed do
	(
		clothSetup.animDrvCreate ObjLs
	)	
	on smdCreate_btn pressed  do
	(
		clothSetup.smdCreate selection
	)
	on createBoxMode_btn pressed do
	(
		clothSetup.createBoxMode()
	)
	on randObjColor_btn pressed  do
	(
		clothSetup.randObjColor selection
	)
	on smoothNormal_btn pressed  do
	(
		clothSetup.smoothNormal selection
	)
	on lockAllTransforms_btn pressed  do
	(
		clothSetup.lockAllTransforms selection
	)
)
rollout ClothSetupMiscRollout "Misc Setup" width:182 height:330
(
	button 'meshCollapse_btn' "Mesh Collapse" pos:[10,10] width:143 height:30 toolTip:"Runs Mesh Collapse to Origin on selected objects." align:#left
	button 'resetCloth_btn' "Reset Cloth" pos:[10,50] width:143 height:30 toolTip:"Reset selected Cloth objects and sets start frame to current frame." align:#left
	button 'simCloth_btn' "Sim Cloth" pos:[10,90] width:143 height:30 toolTip:"Sims selected cloth objects one after another in the order selected." align:#left
	button 'smdVis_btn' "Smd Vis" pos:[10,130] width:143 height:30 toolTip:"Make Smds visible and hides corresponding Anim-Drv. May need to make layer visible after." align:#left
	button 'selectSW_btn' "Select SkinWrap Drv" pos:[10,170] width:143 height:30 toolTip:"Selects objects that selected object is skinwrapped to." align:#left
	
	on meshCollapse_btn pressed  do
	(
		clothSetup.meshCollapseToOrigin selection
	)
	on resetCloth_btn pressed  do
	(
		clothSetup.resetCloth selection
	)
	on simCloth_btn pressed  do
	(
		clothSetup.simCloth selection
	)
	on smdVis_btn pressed  do
	(
		clothSetup.smdVis()
	)
	on selectSW_btn pressed  do
	(
		clothSetup.selectSW selection
	)
)

theNewFloater = newRolloutFloater "Cloth Setup Script" 172 600
addRollout ClothSetupStartRollout theNewFloater rolledUp:true
addRollout ClothSetupRollout theNewFloater rolledUp:true
addRollout ClothSetupMiscRollout theNewFloater rolledUp:true