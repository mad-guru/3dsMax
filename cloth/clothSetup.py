import blurdev
import os
from Py3dsMax import mxs
import copy
## sets up Cloth Sim file based on sim, collide and con objects
from blur3d.lib.pclib import onionwidget
from blur3d.gui.onion.onionwidget import createLayerGroup

mxs.execute("""

fn getLayerNodes layer = (
	x = #()
	layer.nodes &x
	x
)
""")

	## user defined 0 false, 1 true
	doSw = 0
	unifyState = 0
	flipState = 0
	varStrLs = ["-VarA_","-VarB_","-VarC_","-VarD_","-VarE_","-VarF_","-VarG_"]
	varUse = 1
	addPrevColl = 0

	##initialize variables
	simNumLs = []
	rigNumLs = []
	collideNumLs = []
	conNumLs = []
	smdNumLs = []
	animDrvNumLs = []
	simObjs = []
	rigObjs = []
	collideObjs = []
	conObjs = []
	smdObjs = []
	animDrvObjs=[]
	simPartLs = []
	simOrderNumLs = []
	simStrLs = []
	simOrderLs = []
	simObjLs = []
	rigPostObjs = []

def mtlRemove():
	ObjLs=mxs.selection

	for obj in ObjLs:
		obj.material = mxs.undefined

def existFile(fname):
	os.path.exists(fname)

## not working: theNodesTemp = mxs.execute("""curLayer.Nodes &theNodesTemp""")
def delLayerContents(layerName):

	curLayer = mxs.LayerManager.getLayerFromName(layerName)

	if curLayer:
		layerNodes = mxs.execute("""refs.dependents layer""")
		theNodesTemp = mxs.execute("""curLayer.Nodes &theNodesTemp""")
		mxs.delete(theNodesTemp)

		mxs.execute("""LayerManager.deleteLayerHierarchy layerName forceDelete: true""")

## errors out on first line emptyLayers = []
def delEmptyLayers():
	emptyLayers = []

	for i in range (0,(mxs.layerManager(count-1))):
		ilayer = mxs.layerManager.getLayer(1)
		layerName = mxs.ilayer.name
		layer = mxs.ILayerManager.getLayerObject(i)
		layerNodes = mxs.refs.dependents(layer)
		mxs.execute("""layer.Nodes &theNodesTemp""")

		if mxs.theNodesTemp.count == 0:
			mxs.execute("""append emptyLayers (layerName as string)""")
	mxs.execute("""format "vazias: % \n" emptylayers""")
	for i in 1 to size(emptylayers):
		mxs.layermanager.deleteLayerByName(emptyLayers[i])

	## populates object arrays for sim, con, collide etc
	def objAryCreator(layerAry,objStr):
		if size(layerAry)>0:
			objAry = []
			for num in layerAry:
				mxs.clearSelection()
				curLayer = mxs.LayerManager.getLayer(num)
				curLayer.select(true)
				if size(objAry) == 0:
					objAry = mxs.selection
				else:
					objAry = objAry + mxs.selection
				
				mxs.clearSelection()

		##if size(objAry) == 0:
			##mxs.print(objStr + " Layer is undefined or misnamed. Needs to contain _" + objStr + "_")
			objAry

def skinWrapAdd(swObj,swMeshlist,swEng,swWV,swUse):

	if not swObj.modifiers[mxs.pyhelper("skin_wrap")] and swUse:
		m = skin_wrap()
		mxs.addmodifier(swObj,m)
		m.meshlist = swMeshlist
		m.engine = swEng
		m.weightAllVerts = swWV

def addDrvBodyColl(curSim,rigObjs,simStr,clothMod,swUse):
	for curObj in rigOjs:
		if "_Rig_X_Body_" in curObj.name:
			bodyName = (curObj.name.replace("_Rig_", "_Cloth_")).replace("_Drv_", "_Collide_").replace("_Body_", ("_" + simStr + "-Body_"))

			if (mxs.LayerManager.getLayerFromName(curSim.name.replace("_Sim_","_Collide_"))):
				collLayer = mxs.LayerManger.newLayer()
				collLayer.setname(curSim.name.replace("_Sim_", "_Collide_"))
				collLayer.ishidden = True

			if not mxs.getNodeByName(bodyName):	
				bodyCollide = mxs.snapshot(curObj)
				bodyCollide.name = bodyName
				bodyCollide.wirecolor = mxs.execute("""(color 255 0 0)""")

				skinWrapAdd(bodyCollide, [curObj], 0, True, swUse)
				mxs.clearSelection()
				clothMod = curSim.modifiers[mxs.pyhelper("Cloth")]
				mxs.addmodifier(bodyCollide,clothMod)

				mxs.select(bodyCollide)
				mxs.execute("""max modify mode""")
				clothMod.clothOps.setObjectType(bodyCollide, 1, True)
				clothMod.setObjectProperty(bodyCollide, "depth", 0.2)
				clothMod.setObjectProperty(bodyCollide, "offset", 0.2)
				mxs.clearSelection()
				mxs.execute("""max create mode""")

				collLayer = mxs.LayerManager.getLayerFromName(curSim.name.replace("_Sim_", "_Collide_"))
				collLayer.addnode(bodyCollide)


def varSetup():
	##intialize variables
	simNumLs = []
	rigNumLs = []
	collideNumLs = []
	conNumLs = []
	smdNumLs = []
	animDrvNumLs = []
	simObjs = []
	rigObjs = []
	collideObjs = []
	conObjs = []
	smdObjs = []
	animDrvObjs = []
	simPartLs = []
	simOrderNumLs = []
	simStrLs = []
	simOrderLs = []
	
	simObjLs = []
	simNum = None

	mxs.execute("max create mode")

	## find sim, rig and collide layers
	for layerNum in range (0, (len(LayerManager)-1)):
		mxs.execute("""max create mode""")
		##find sim, rig and collide layers
		for layerNum in range(0,(LayerManager.count-1)):
			##if simDrvLs[0].name.find("_Drv_")
			if mxs.LayerManager.getLayer(layerNum).name.find("_Sim_"):
				simNumLs[size(simNumLs)+1]= layerNum
			if mxs.LayerManager.getLayer(layerNum).name.find("_Rig_"):
				rigNumLs[size(rigNumLs)+1]= layerNum
			if mxs.LayerManager.getLayer(layerNum).name.find("_Collide_"):
				collideNumLs[size(collideNumLs)+1]= layerNum
			if mxs.LayerManager.getLayer(layerNum).name.find("_Con_"):
				conNumLs[size(conNumLs)+1]= layerNum
			if mxs.LayerManager.getLayer(layerNum).name.find("_Smd_"):
				smdNumLs[size(smdNumLs)+1]= layerNum
			if mxs.LayerManager.getLayer(layerNum).name.find("_animDrv_"):
				anmDrvNumLs[size(anmDrvNumLs)+1]= layerNum

	## populate lists with corresponding objects
	simObjs = objAryCreator(simNumLs, "Sim")
	if simObjs:
		for curObj in simObjs:
			mxs.curObj.wirecolor=(color 0 255 0)

			## reorder simObjs
			simNumLs = []
			simNum

			for curSim in simObjs:
				if curSim.name.find("_Sim"):
					simStrLs = curSim.name.split("_")
					simNum = simStrLs[5].replace("Sim","")

					##added the "00" so it is unique from the number at the end
					simNumLs[size(simNumLs)+1] = "00"+simNum + "_" + curSim.name

			simOrderLs= simNumLs.sort()
			simObjs = []

			for simStr in simOrderLs:
				simStrLs = simStr.split("_")
				simObjs[size(simObjs)+1] = mxs.getNodeByname(simStr.replace(simStrLs[0]+"_",""))

	rigObjs = objAryCreator(rigNumLs, "Rig")
	collideObjs = objAryCreator(collideNumLs, "Collide")
	if collideObjs:
		for curObj in collideObjs:
			mxs.curObj.wirecolor=(color 255 0 0)
	conObjs = objAryCreator(conNumLs, "Con")
	smdObjs = objAryCreator(smdNumLs, "Smd")
	animDrvObjs = objAryCreator(animDrvNumLs,"animDrv")


def varSetup():
	##intialize variables
	simNumLs = []
	rigNumLs = []
	collideNumLs = []
	conNumLs = []
	smdNumLs = []
	animDrvNumLs = []
	simObjs = []
	rigObjs = []
	collideObjs = []
	conObjs = []
	smdObjs = []
	animDrvObjs = []
	simPartLs = []
	simOrderNumLs = []
	simStrLs = []
	simOrderLs = []
	
	simObjLs = []
	simNum = None

	mxs.execute("""max create mode""")

	## find sim, rig and collide layers
	layerDict = {}
	layerKeysLs = ["_Sim_", "_Rig_", "_Collide_", "_Con_", "_Smd_", "_AnimDrv_"]
	for layerNum in range(mxs.LayerManager.count):
		curLayer = mxs.LayerManager.getLayer(layerNum)
		layerName = curLayer.name
		for key in layerKeysLs:
			if key in layerName:
				if key not in layerDict:
					layerDict[key] = []
				layerDict[key].append(layerNum)

	objDict = {}
	objTypeLs = ["simObjs", "rigObjs", "collideObjs", "conObjs", "smdObjs", "animDrvObjs"]

	for objType in objTypeLs:
		objDict[objType] = []
		layerNumLs = layerDict[layerKeysLs[objTypeLs.index(objType)]]
		for layerNum in layerNumLs:
			objDict[objType].extend(mxs.getLayerNodes(mxs.LayerManager.getLayer(layerNum)))


	for curObj in objDict["simObjs"]:
		mxs.execute("curObj.wirecolor=(color 0 255 0)")

		## reorder simObjs based on the number at the end of each object name
		simNumLs = []
		simNum = None

		for curSim in simObjs:
			simStrLs = curSim.name.split("_")
			simNum = simStrLs[5].replace("Sim","")

			## added the "00" so it is unique from the number at the end
			simNumLs[len(simNumLs) + 1] = "00" + simNum + "_" + curSim.name

		simOrderLs = sorted(simNumLs)
		simObjs = []

		for simStr in simOrderLs:
			simStrLs = simStr.split("_")
			simObjs[len(simObjs) + 1] = mxs.getNodeByname(simStr.replace((simStrLs[0] + "_"), "")

		for curObj in objDict["collideObjs"]:
			##mxs.curObj.wirecolor((color 255 0 0))
			mxs.execute("""curObj.wirecolor=(color 255 0 0)""")

def rigSetup(rigObjs, animDrvObjs, swUse):
	mxs.execute("max create mode")

	if rigObjs:
		for curObj in rigObjs:
			if curObj.modifiers[mxs.pyhelper("skin_wrap")]:
				rigStrLs = curObj.name.split("_")
				rigStr = None

				if rigStrLs[(size(rigStrLs)-1)] == "Drv":
					rigStr = rigStrLs[4]
				else:
					rigStr=rigStrLs[6]

				curAnimDrv = None

				for animDrv in animDrvObjs:
					animDrvConObj = animDrv.name.split("_")
					animDrvStr = animDrvConObj[4]

					if animDrvStr == rigStr:
						curAnimDrv = animDrv

				if rigStr == "Body" and mxs.selectionSets[mxs.pyhelper("_body_drv")]:
					mxs.clearSelection()
					mxs.select(selectionSets[mxs.pyhelper("_body_drv")])
					drvLs = mxs.selection
				else:
					if curanimDrv:
						drvLs=[curanimDrv]

			if drvLs:
				skinWrapAdd(curObj, drvLs, 0, True, swUse)

		##remove override portion of name
		if rigStrLs[size(rigStrLs)-1] != "Drv":
			curObj.name = curObj.name.replace(("_" + rigStrLs[6] + "_"), "_")
			rigPostObjs[size(rigPostObjs)+1] = curObj

		mxs.clearSelection()

	else:
		print "Skipping Rig objects setup."

## start rig post fn to setup smd with duplicate rig objects if needed
def rigSetupPost(simObjs, swUse):
	mxs.execute("max create mode")
	drvLs = None
	rigLayer = None
		
		for simObj in simObjs:

			if rigLayer == None:
				simStrLs = simObj.name.split("_")
				layerName = simStrLs[0]+"_"+simStrLs[1]+"_Rig_"
				rigLayer = mxs.LayerManager.getLayerFromName(layerName)

			if simObj.modifiers[#skin_wrap]:
				simDrvLs = simObj.modifiers[#skin_wrap].meshlist

				if simDrvLs[0].name.find("_Drv_"):
					newDrv = mxs.snapshot(simDrvLs[0])
					rigLayer.addnode(newDrv)
					skinWrapAdd(newDrv, [simObj], 0, true, swUse)
					newDrv.name = simDrvLs[0].name.replace("_Drv_", "2_Drv_")
					simDrvLs[0].name = simDrvLs[0].name.replace("_Drv_", "1_Drv_")

					if simDrvLs[0].modifiers[#skin_wrap]:
						if simDrvLs[0].modifiers[#skin_wrap].meshlist[0]:
							tmpStr = simDrvLs[0].modifiers[#skin_wrap].meshlist[0].name.replace("_Mesh_", "_Cloth_")

							curSmd = mxs.getNodeByName((tmpStr[0:(len(tmpStr))-1)]+"-Smd_")

						if curSmd:
							skinWrapAdd(curSmd, [newDrv], 0, true, swUse)


	##end rig post fn

		
def simSetup(simObjs, animDrvObjs, collideObjs, varStrLs, varUse, swUse):
	mxs.execute("max create mode")
	##sort sim objs by sim order number appended to name

	if simObjs:
		simOrderLs = []
		simStrLs = #[]
		simObjPrev = None

		for simObj in simObjs:
			strls = simObj.name.split("_")
			simNum = strLs[5].replace("Sim", "") ## as integer

			##record sim layer number and sim object
			simStrLs[len(simStrLs)]=simNum + "_" + simObj.name ##simNum as string

		simOrderLs = sorted(simStrLs)
		simOrderNumLs = []
		for str in simOrderLs:
			strLs = str.split("_")
			simOrderNumLs[len(simOrderNumLs)] = strLs[0]
			simPartLs[len(simPartLs)] = strLs[5]
		##end sorting sim objs by sim order

		##Start sim obj setup
		if simObjs:
			count = 0

			for curSim in simObjs:
				count += 1
				## put each sim obj or group of them with the same number in their own layer
				conObj = curSim.split("_")
				simStr = conObj[4]
				simNum = conObj[5].name.replace("Sim", "")
				curSim.name = curSim.name.replace(conObj[5], "Sim")

				##in case the name was changed because it had a number, redefine these variables
				conObj = curSim.name.split("_")
				simStr = conObj[4]

				simNumPrev = 0
				simObjPrev = None

				##check if sim num has been created
				if count > 1:
					simObjPrev = simObjs[count-2]
					simNumPrev = simOrderNumLs[count-2]

				if simNum != simNumPrev:
					simObjPrev = None

				##skinwrap to animDrv or Drv if one exists
				for animDrv in animDrvObjs:
					curDrv = None
					animDrvConObj = animDrv.name.split("_")
					animDrvStr = animDrvConObj[4]

					drvName = (curSim.name.replace("_Sim_", "_Drv_")).replace("_Cloth_", "_Rig_")

					if mxs.getNodeByname(drvName):
						curDrv = mxs.getNodeByname(drvName)

					##if the obj does not have a skinwrap override
					if conObj[len(conObj)-1] == "Sim":
						if curDrv == None and animDrvStr == simStr and curSim.modifiers[#Skin_Wrap] == undefined:
							skinWrapAdd(curSim, [animDrv], 0, true, swUse)
						
						if curDrv and curSim.modifiers[#Skin_Wrap] == undefined:
							skinWrapAdd(curSim, [curDrv], 0, true, swUse)

						## if the obj has a skinwrap override
						else:
							if animDrvStr == conObj[6] and curSim.modifiers[#Skin_Wrap] == undefined:
								skinWrapAdd(curSim, [animDrv], 0, true, swUse)
								curSim.name = curSim.name.replace(("_"+conObj[6]), "")

				curlayer = None

				## if this sim obj is not part of an existing simulation layer
				if simObjPrev:
					curLayer = mxs.LayerManager.newLayer()
					curLayer=LayerManager.newLayer()
					curLayer.addnode(curSim)
					curLayer.setname(curSim.name)
					curLayer.ishidden(true)
					mxs.addmodifier(curSim, (Cloth()))

					##if this sim obj is part of an existing simulation layer
					else:
						curLayer = mxs.LayerManager.getLayerFromName(simObjPrev.name)
						curLayer.addnode(curSim)
						curLayer.ishidden(true)
						
						mxs.addmodifier(curSim, simObjPrev.modifiers[#cloth])

					clothMod = curSim.modifiers[#Cloth]

					##set cloth modifier setting of obj to type cloth

					mxs.select curSim
					mxs.execute"max modify mode"

					clothMod.clothOps.setObjectType(curSim, 2, true)
					clothMod.scale(2.54)
					clothMod.useGravity(true)
					clothMod.gravity(-980.0)
					clothMod.useSewingSprings(off)
					clothMod.showSewingSprings(off)
					clothMod.timestep(0.02)
					clothMod.subsample(1)
					clothMod.solidCollision(true)
					clothMod.startFrame(0)
					clothMod.selfCollision(true)
					clothMod.advancedPinching(off)
					
					mxs.clearSelection()
					mxs.execute("max create mode")

				tmpLayer = mxs.LayerManager.getLayerFromName(curSim.name)

				## collision
				if collideObjs and tmpLayer:
					if len(collideObjs):
						collLayer = mxs.LayerManager.newLayer()
						collLayer.setname(curSim.name.replace("_Sim_", "_Collide_"))
						collLayer.ishidden(true)

					##cycle through collide objects and setup appropriate ones
					for curCollide in collideObjs:
						newCollide = None
						conObj = curCollide.name.split("_")
						collideStr = conObj[4]

						## check if the collide goes with a different variation
						simLayerStr = None
						collideLayerStr = None

						for str in varStrLs:
							if curSim.name.find(str):
								simLayer = str
							if curCollide.name.find(str):
								collideLayerStr = str

						if simStr != collideStr and simLayerStr == collideLayerStr or simLayerStr == None or collideLayerStr == None:
							collPart = simPartLs.index(collideStr)

							if collPart != None:
								collideOrderNum = simOrderNumLs[collPart]
							else:
								collideOrderNum = None

							simPart = simPartLs.index(simStr)

							if simPart != None:
								simOrderNum = simOrderNumLs[simPart]
							else:
								simOrderNum = None

							## these objects are collides for all sim layers after the sim obj they match part name with
							if conObj[len(conObj)-1] == "Collide" amd simOrderNum != None and collideOrderNum != undefined and simOrderNum > collideOrderNum and simOrderNum != 0:
								newCollide = mxs.snapshot(curCollide)
								newCollide.wirecolor(color 255 0 0 0)

								##rename collision object to include sim layer name
								newCollide.name = curCollide.name.replace(collideStr, (simStr + "-" + collideStr))
								collLayer.addnode(newCollide)

								## skinwrap to anim drv
								curAnimDrv = None

								## if there is a sim driver, use it, otherwise use an animdrv
								if newCollide.modifiers[#skin_wrap] not:
									simDrvStr = newCollide.name.repalce("_Collide_", "_Sim_")
									partStr = simDrvStr.split("_")
									simDrvStr = simDrvStr.replace(partStr[4], collideStr)

									if mxs.getNodeByName(simDrvStr):
										skinWrapAdd(newCollide, [(mxs.getNodeByName(simDrvStr)], 0, true, swUse)
									else:
										## skinwrap to appropriate object
										for animDrv in animDrvObjs:
											animDrvConObj = animDrv.name.split("_")
											animDrvStr = animDrvConObj[4]

											if animDrvStr == collideStr and newCollide.modifiers[#Skin_Wrap]:
												skinWrapAdd(newCollide, [animDrv], 0, true, swUse)

								## add to sim obj cloth modifier
								mxs.addmodifier(newCollide, clothMod)

								mxs.select(newCollide)
								mxs.execute("max modify mode")

								clothMod.clothOps.setObjectType(newCollide, 1, true)
								clothMod.setObjectProperty(newCollide, "depth", 0.2)
								clothMod.setObjectProperty(newCollide, "offset", 0.2)

								mxs.clearSelection()
								mxs.execute("max create mode")

							else:
								##curCollide object is custom to a specific layer
								##only add it if this current sim obj corresponds to it
								if simStr == conObj[7]:
									newCollide = mxs.snapshot(curCollide)
									newCollide.wirecolor(color 255 0 0)

									collLayer.addnode(newCollide)

									##skinwrap to animDrv
									curAnimDrv = None

									for animDrv in animDrvObjs:

										animDrvConObj = animDrv.name.split("_")
										animDrvStr = animDrvConObj[4]

										## animDrv matches collide object name and it does not already have a skinwrap
										if animDrvStr == conObj[6] and not newCollide.modifiers[#Skin_Wrap]:
											skinWrapAdd(newCollide, [animDrv], 0, true, swUse)

											## correct newCollide name by removing extra parts
											newCollide.name = curCollide.name

											if conObj[7]:
												newCollide.name = newCollide.name.replace(("_"+conObj[7]+"_"), "_")
											newCollide.name = newCollide.name.replace(("_"+conObj[6]+"_"), "_")
											newCollide.name = newCollide.name.replace(collideStr, (simStr + "-" + collideStr))

								## end custom driver matches sim obj
							##emd custom drv loop
						## if the collide is meant for all layers, but does not match a sim obj part name
						if conObj[len(conObj)-1] == "Collide" and collideOrderNum == None:
							newCollide = mxs.snapshot(curCollide)
							newCollide.wirecolor((color 255 0 0))
							newCollide.name = curCollide.name.replace(collideStr, (simStr + "-" + collideStr))
							collLayer.addnode(newCollide)

							## skinwrap to appropriate object
							for animDrv in animDrvObjs:
								animDrvConObj = animDrv.name.split("_")
								animDrvStr = animDrvConObj[4]

								if animDrvStr == collideStr and newCollide.modifiers[#Skin_Wrap]:
									skinWrapAdd(newCollide, [animDrv], 0, true, swUse)

						if newCollide and newCollide.modifiers[#cloth]:
							select(newCollide)
							mxs.execute("max modify mode")

							## add to sim obj cloth modifier
							mxs.addmodifier(newCollide, clothMod)
							clothMod.clothOps.setObjectType(newCollide, 1, true)
							clothMod.setObjectProperty(newCollide, "depth", 0.2)
							clothMod.setObjectProperty(newCollide, "offset", 0.2)
							mxs.clearSelection()
							mxs.execute("max create mode")

					## end if simStr != collideStr
				## end collide objs looop

				## if body collide not added check if there is a body collide drv and add it as a collision
				if collLayer:
					collLayer.select(true)
					collObjs = selection as array
					mxs.clearSelection()

					bodyFound == false

					for curColl in collObjs:
						if curColl.name.find("Body_"):
							bodyFound = true
						## if there isn't already a collision named 'body'
						if not bodyFound:

							addDrvBodyColl(curSim, rigObjs, simStr, clothMod, swUse)
							## end if bodyFound == false
						## end if collision layer undefined
					## end collideObjs.count > 0
				## end if collideObjs!= undefined
			else:
				if tmpLayer:
					## add body collision driver if it exists
					addDrvBodyColl(curSim, rigObjs, simStr, clothMod, swUse)
		## end sim loop

##end sim setup fn


def conSetup(conObjs, simObjs):
	mxs.execute("max create mode")

	if conObjs:
		##add constraints
		for conObj in conObjs:
			for curObj in sim Objs:
				conLs = curObj.name.split("_")

				if conObj.name.find(conLs[4]):
					conLs = conObj.name.split("_")
					mxs.execute("max modify mode")
					mxs.select(curObj)
					addmodifier(curObj, (vol__select()))
					curObj.modifiers[#Vol__Select].level(1)
					curObj.modifiers[#Vol__Select].volume(3)
					curObj.modifiers[#Vol__Select].node(conObj)

					vertSel = curObj.selectedVerts ##as bitArray

					conName =  None

					if conLs[4]:
						conName: (conLs[0]+"_"+conLs[3]+"_"+conLs[4])
					else:
						if conLs[3]:
							conName = (conLs[0]+"_"+conLs[3])

						if not conName:
							conName = conLs[0]

						curObj.modifiers[#Cloth].makepointGroup(vertSel, curObj, conName)

						if conLs[3] == "Pres":
							curObj.modifiers[#cloth].MakeConstraint(conName, "Preserved", curObj)
							curCon=curObj.modifiers[#cloth].getGroupParamBlock(conName)
							curCon.useGroupBehavior(true)
							curCon.Grp_Solid_Collision(false)

						if mxs.classof(curObj.modifiers[0]) == Vol__Select:
							mxs.deletemodifier(curObj, 1)

						mxs.execute("max create mode")

##end con setup



def smdSetup(simObjs, smdObjs, swUse):

	mxs.execute("max create mode")
	## skinwrap Smd to corresponding Sim object

	if simObjs:
		for curSmd in smdObjs:
			smdConObj = curSmd.split("_")
			smdStr = smdConObj[4]

		### search for a sim obj match
		for simObj in simObjs:
			simConObj = simObj.name.split("_")
			simStr=copy simConObj[4]
				## if it matches, skinwrap to it
				if smdStr == simStr and not curSmd.modifiers[#skin_wrap]:
					skinWrapAdd(curSmd, [simObj], 0, 1, swUse)

				if not curSmd.modifiers[#skin_wrap]:
					tmpStr = (curSmd.name[:(len(curSmd.name)-5)])+"_"
					curanimDrv = mxs.getNodeByName(tmprStr.replace("_Cloth_","_Mesh_"))
					skinwrapAdd(curSmd,[curanimDrv],0,1,swUse)

		else:
			print "Skipping Smd setup"

def conSetup(conObjs,simObjs):
	mxs.execute("max create mode")

	if conObjs:
		## add constraints
		for conObj in conObjs:
			for curObj in simObjs:
				conLs = curObj.name.split("_")
					if conObj.name.find(conLs[4]):
						conLs = conObj.name.split("_")
						mxs.execute("max modify mode")
						curObj.select
						curObjs.addmodifier(vol__select())
						curObj.modifiers[#Vol__Select].level(1)
						curObj.modifiers[#Vol__Select].volume(3)
						curObj.modifiers[#Vol__Select].node(conObj)

						vertSel = curObj.selectedVerts as bitArray ##?????

						conName

						if conLs[4]:
							conName = (conLs[0]+"_"+conLs[3]+"_"+conLs[4])
						else:
							if conLs[3]:
								conName = conLs[0]+"_"+conLs[3]

						if not conName:
							conName = conLs[0]

						curObj.modifiers[#Cloth].makepointGroup(verSel, curObj, conName)

						if conLs[3] = "Pres":
							curObj.modifiers[#cloth].MakeConstraint(conName,"Preserved",curObj)
							curCon=curObj.modifiers[#cloth].getGroupParamBlock(conName)
							curCon.useGroupBehavior=1
							curCon.Grp_Solid_Collision=0

						if classof curObj.modifiers[1]==Vol__Select:
							deletemodifie(curObj,1)
							mxs.execute("max create mode")
	else:
		print "Skipping Constraint setup."

## end con setup


def sceneCleanup:

	strLs = simObjs[0].name.split("_")
	charStr = (strLs[0]+"_"+strLs[1])

	default = LayerManager.getLayerFromName("0")
	default.current = 1
	## delete layers with objects
	delLayerContents(charStr+"_Con_")
	delLayerContents(charStr+"_Collide_")
	delLayerContents(charStr+"_Sim_")

	## delete empty layers
	delEmptyLayers()

	##add named selection sets for Sim and Rig
	mxs.selectionSets["_Sim"] = $*_Sim_*
	mxs.selectionSets["_Rig"] = $*_Rig_*


def resetCloth(objLs):
	startFrame = mxs.sliderTime
	mxs.execute("max modify mode")	

	for obj in objLs:
		if obj.modifiers[#cloth]:
			obj.modifiers[#cloth].startframe = startFrame
			obj.modifiers[#cloth].resetState(obj)
	mxs.execute("max create mode")

def LayerRenameAnimDrv(curLayer):
	curLayer.setname(curLayer.name.replace("_Mesh_", "_AnimDrv_"))

def animDrvCreate(ObjLs):
	selectionSets["_Anim-Drv"] = $'*_Mesh_*'

##select animdrvers and run script to snapshot and rename to smd
def smdCreate(ObjLs):
	selectionSets["_Anim-Drv"] = ObjLs

	strLs=ObjLs[0].name.split("_")
	layerName = strLs[0]+"_"+strLs[1]+"_Cloth_X_Smd_"
	smdLayer = LayerManager.newLayer()
	smdLayer.setname(layerName)
	smdLayer.ishidden=0

	for obj in ObjLs:
		curSmd = mxs.snapshot(obj)
		curSmd.name = obj.name.replace("_Mesh_","_Cloth_")
		curSmd.name = curSmd.name[:(curSmd.name.count-1)]+"-Smd_"
		smdLayer.addnode(curSmd)

		selectionSets["_PC to SA (Smd)"] = $'*-Smd_'

def randObjColor(objLs):
	##randomize wire color for selected objects
	for obj in objLs:
		(obj.wirecolor= (color (randint(1, 255) (randint(1, 255) (randint(1, 255)))

def flipNormal(objLs):
	for obj in objsLs:
		mxs.addmodifier(obj,(Normalmodifier())
		obj.modifiers[#Normal].flip(1)
		mxs.collapseStack(obj)

def smoothNormal(objLs):
	mxs.addmodifier(obj, (Smooth()))
	obj.modifiers[#Smooth].autosmooth(1)
	obj.modifiers[#Smooth].Threshold(180)

	mxs.collapseStack(obj)

##selects all Smd objects, unhides them and hides their corresponding anim drivers.

def smdVis:

def fixNormal(objLs):
	for obj in objLs:
		swLs = obj.modifiers[#skin_wrap].meshlist as array
		mxs.deletemodifier(obj, 1)
		mxs.addmodifier(obj, (Normalmodifier()))
		obj.modifiers[#Normal].flip(1)
		obj.modifiers[#Normal].unify(1)
		mxs.collapseStack(obj)
		skinWrapAdd(obj, swLs, 0, 1, 1)