char_str="nmy"
--obj array maker
--for cur_obj in selection do (print ("$"+cur_obj.name+","))

--import fbx file

mcp_skel=#($Reference,
$Hips,
$Spine,
$Spine1,
$Neck,
$Head,
$LeftShoulder,
$LeftArm,
$LeftForeArm,
$LeftHand,
$LeftHandThumb1,
$LeftHandThumb2,
$LeftHandThumb3,
$LeftHandThumb4,
$LeftHandIndex1,
$LeftHandIndex2,
$LeftHandIndex3,
$LeftHandIndex4,
$LeftHandMiddle1,
$LeftHandMiddle2,
$LeftHandMiddle3,
$LeftHandMiddle4,
$LeftHandRing1,
$LeftHandRing2,
$LeftHandRing3,
$LeftHandRing4,
$LeftHandPinky1,
$LeftHandPinky2,
$LeftHandPinky3,
$LeftHandPinky4,
$RightShoulder,
$RightArm,
$RightForeArm,
$RightHand,
$RightHandThumb1,
$RightHandThumb2,
$RightHandThumb3,
$RightHandThumb4,
$RightHandIndex1,
$RightHandIndex2,
$RightHandIndex3,
$RightHandIndex4,
$RightHandMiddle1,
$RightHandMiddle2,
$RightHandMiddle3,
$RightHandMiddle4,
$RightHandRing1,
$RightHandRing2,
$RightHandRing3,
$RightHandRing4,
$RightHandPinky1,
$RightHandPinky2,
$RightHandPinky3,
$RightHandPinky4,
$LeftUpLeg,
$LeftLeg,
$LeftFoot,
$LeftToeBase,
$RightUpLeg,
$RightLeg,
$RightFoot,
$RightToeBase)

brek_hand_ary=#(	
$LeftHand,
$LeftHandThumb1,
$LeftHandThumb2,
$LeftHandThumb3,
$LeftHandThumb4,
$LeftHandIndex1,
$LeftHandIndex2,
$LeftHandIndex3,
$LeftHandIndex4,
$LeftHandMiddle1,
$LeftHandMiddle2,
$LeftHandMiddle3,
$LeftHandMiddle4,
$LeftHandRing1,
$LeftHandRing2,
$LeftHandRing3,
$LeftHandRing4,
$LeftHandPinky1,
$LeftHandPinky2,
$LeftHandPinky3,
$LeftHandPinky4,
$RightHand,
$RightHandThumb1,
$RightHandThumb2,
$RightHandThumb3,
$RightHandThumb4,
$RightHandIndex1,
$RightHandIndex2,
$RightHandIndex3,
$RightHandIndex4,
$RightHandMiddle1,
$RightHandMiddle2,
$RightHandMiddle3,
$RightHandMiddle4,
$RightHandRing1,
$RightHandRing2,
$RightHandRing3,
$RightHandRing4,
$RightHandPinky1,
$RightHandPinky2,
$RightHandPinky3,
$RightHandPinky4
)

char_hand_ary=#(
(getNodeByName(char_str+"_Bone hand L")),
(getNodeByName(char_str+"_Bone thumb L-01")),
(getNodeByName(char_str+"_Bone thumb L-02")),
(getNodeByName(char_str+"_Bone thumb L-03")),
undefined,
(getNodeByName(char_str+"_Bone finger index L-01")),
(getNodeByName(char_str+"_Bone finger index L-02")),
(getNodeByName(char_str+"_Bone finger index L-03")),
undefined,
(getNodeByName(char_str+"_Bone finger middle L-01")),
(getNodeByName(char_str+"_Bone finger middle L-02")),
(getNodeByName(char_str+"_Bone finger middle L-03")),
undefined,
(getNodeByName(char_str+"_Bone finger ring L-01")),
(getNodeByName(char_str+"_Bone finger ring L-02")),
(getNodeByName(char_str+"_Bone finger ring L-03")),
undefined,
(getNodeByName(char_str+"_Bone finger little L-01")),
(getNodeByName(char_str+"_Bone finger little L-02")),
(getNodeByName(char_str+"_Bone finger little L-03")),
undefined,
(getNodeByName(char_str+"_Bone hand R")),
(getNodeByName(char_str+"_Bone thumb R-01")),
(getNodeByName(char_str+"_Bone thumb R-02")),
(getNodeByName(char_str+"_Bone thumb R-03")),
undefined,
(getNodeByName(char_str+"_Bone finger index R-01")),
(getNodeByName(char_str+"_Bone finger index R-02")),
(getNodeByName(char_str+"_Bone finger index R-03")),
undefined,
(getNodeByName(char_str+"_Bone finger middle R-01")),
(getNodeByName(char_str+"_Bone finger middle R-02")),
(getNodeByName(char_str+"_Bone finger middle R-03")),
undefined,
(getNodeByName(char_str+"_Bone finger ring R-01")),
(getNodeByName(char_str+"_Bone finger ring R-02")),
(getNodeByName(char_str+"_Bone finger ring R-03")),
undefined,
(getNodeByName(char_str+"_Bone finger little R-01")),
(getNodeByName(char_str+"_Bone finger little R-02")),
(getNodeByName(char_str+"_Bone finger little R-03")),
undefined
)
--get brekel hand to character hand position
(getNodeByName ("LeftHand")).position=(getNodeByName(char_str+"_Bone hand L")).center	
(getNodeByName ("LeftHand")).parent=(getNodeByName(char_str+"_Bone hand L"))
(getNodeByName ("RightHand")).position=(getNodeByName(char_str+"_Bone hand R")).center	
(getNodeByName ("RightHand")).parent=(getNodeByName(char_str+"_Bone hand R"))

	--set animation range
	key_ary=brek_hand_ary[1].baseObject.Custom_Attribute.velocityX.controller.keys
	start_frame=((key_ary[1].time) as integer)/TicksPerFrame
	end_frame=((key_ary[key_ary.count].time as integer))/TicksPerFrame
	
	animationRange=(interval start_frame end_frame)
	
	slidertime=start_frame
	
	--align transforms for brek hand on start frame
	for num in 1 to brek_hand_ary.count do
	(
		brek_bn=brek_hand_ary[num]
		cur_bn=char_hand_ary[num]
		
		if  (cur_bn!=undefined) and (brek_bn!=undefined) then
		(
			brek_bn.transform=cur_bn.transform
		)
		else
		(
			cur_bn=char_hand_ary[num-1]
			addmodifier cur_bn (Turn_to_Mesh ())
			brek_bn.position=[((cur_bn.verts[5].pos.x+cur_bn.verts[8].pos.x)/2),((cur_bn.verts[5].pos.y+cur_bn.verts[8].pos.y)/2),((cur_bn.verts[5].pos.z+cur_bn.verts[8].pos.z)/2)]	
			deleteModifier cur_bn 1
		)
		
	)


	for cur_time in start_frame to end_frame do
	(	
		for num in 1 to char_hand_ary.count do
		(
			slidertime=cur_time
			if char_hand_ary[num]!=undefined then (char_hand_ary[num].transform=brek_hand_ary[num].transform)
		)
	)
	
--delete position and scale keys
	for cur_obj in char_hand_ary do
	(
		if cur_obj!=undefined then
		(
		deleteKeys cur_obj.scale.controller.keys #allKeys
		deleteKeys cur_obj.position.controller.keys #allKeys
		)
	)

--save animation then load it on to a clean rig

--delete mocap skeleton
delete mcp_skel