	char_str="riz"

	
	--import_fbx file
	mcp_file = getOpenFileName caption:"Open a Motion Capture File:" types:"FBX(*.fbx)|"

	resetMaxFile #noPrompt 
	frameRate=30
	
	importFile mcp_file #noPrompt using:importerPlugin.classes[5]
	
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
	mergeMAXFile anm_rig_file #useSceneMtlDups quiet:true
	filein mcrig_arrays_file
		
	ctrl_layer=LayerManager.getLayerFromName (char_str+" - Controls")
	ctrl_layer.on=true
	ctrl_layer.select on
		
	mg_anm.load_anm (substituteString mcp_file "fbx" "xaf") (selection as array) false false 0
	
	key_ary=(getNodeByName(char_str+"_Bone pelvis_bn")).controller.position.controller.keys
	start_frame=((key_ary[1].time) as integer)/TicksPerFrame
	end_frame=((key_ary[key_ary.count].time as integer))/TicksPerFrame
	animationRange=(interval (start_frame-100) (end_frame+100))
		
		
	-- manually delete unneeded keyframes and slide clips around

			-- delete keys before frame 1		
			key_ary=(getNodeByName(char_str+"_Waist control")).controller.position.controller.keys
			del_ary=#()
				
			for cur_num in 1 to key_ary.count do
			(	
				if key_ary[cur_num].time<1 and key_ary[cur_num].time!=undefined then
				(
					--print key_ary[cur_num].time
					del_ary[del_ary.count+1]=cur_num
				)
			)

			if del_ary.count>0 then
			(
					for cur_num in 1 to del_ary.count do (deleteItem key_ary del_ary[cur_num])
			)
			key_ary=(getNodeByName(char_str+"_Waist control")).controller.position.controller.keys
		
	saveMaxFile "C:\Users\madguru\Documents\3dsMax\autoback\maxhold.mx"
		
		