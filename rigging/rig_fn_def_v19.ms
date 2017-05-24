struct mg_rig
(	
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--from Bobo
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn ANoon_EnvelopeCallbackFunction =
	(
	WindowHandle = DialogMonitorOPS.GetWindowHandle()
	theDialogName = UIAccessor.GetWindowText WindowHandle
	if theDialogName != undefined and matchpattern theDialogName pattern:"*Load Envelopes*" do
		(
		--added match by name to test
		UIAccessor.PressButtonByName WindowHandle "Match by Name"
		UIAccessor.PressButtonByName WindowHandle "OK"
		)
	true
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FreezeTransform --from max
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		fn FreezeTransform item = 	
			( 		
				local CurObj = item	

				if classof CurObj.rotation.controller != Rotation_Layer do
				(

					-- freeze rotation		
					CurObj.rotation.controller = Euler_Xyz() 		
					CurObj.rotation.controller = Rotation_list() 			
					CurObj.rotation.controller.available.controller = Euler_xyz() 		
					
					/* "Localization on" */  
				
					CurObj.rotation.controller.setname 1 "Frozen Rotation" 		
					CurObj.rotation.controller.setname 2 "Zero Euler XYZ" 		
				
					/* "Localization off" */  
					
					CurObj.rotation.controller.SetActive 2 		
				)
				if classof CurObj.position.controller != Position_Layer do
				(

					-- freeze position
					CurObj.position.controller = Bezier_Position() 			
					CurObj.position.controller = position_list() 			
					CurObj.position.controller.available.controller = Position_XYZ() 	

					/* "Localization on" */  
							
					CurObj.position.controller.setname 1 "Frozen Position" 	
					CurObj.position.controller.setname 2 "Zero Pos XYZ" 			
					
					/* "Localization off" */  
					
					CurObj.position.controller.SetActive 2 		

					-- position to zero
					CurObj.Position.controller[2].x_Position = 0
					CurObj.Position.controller[2].y_Position = 0
					CurObj.Position.controller[2].z_Position = 0
				)

			),			
		--freeze transform as function END
----------------------------------------------------------------------------------------------------------------------------------------------
--by Martijn
fn AlignPivotTo Obj Trgt =
	(
	-- Get matrix from object
	if classOf Trgt != matrix3 then Trgt = Trgt.transform

	-- Store child transforms
	local ChldTms = in coordSys Trgt ( for Chld in Obj.children collect Chld.transform )

	-- Current offset transform matrix
	local TmScale = scaleMatrix Obj.objectOffsetScale
	local TmRot = Obj.objectOffsetRot as matrix3
	local TmPos = transMatrix Obj.objectOffsetPos
	local TmOffset = TmScale * TmRot * TmPos

	-- New offset transform matrix
	TmOffset *= obj.transform * inverse Trgt

	-- Apply matrix
	Obj.transform = Trgt

	-- Restore offsets
	Obj.objectOffsetPos = TmOffset.translation
	Obj.objectOffsetRot = TmOffset.rotation
	Obj.objectOffsetScale = TmOffset.scale

	-- Restore child transforms
	for i = 1 to Obj.children.count do Obj.children[i].transform = ChldTms[i] * inverse Trgt * Obj.transform
	),

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--modified from bone tools
fn cr_endBone char_str prev_bn ctrlobj_mult=
	(
		parentTrans = prev_bn.transform
		parentPos = parentTrans.translation
		joint_obj=BoneSys.createBone parentPos (parentPos+6) prev_bn.dir
		joint_obj.transform = parentTrans
		in coordSys Local move joint_obj [prev_bn.length,0,0]
		joint_obj.parent  = prev_bn
		joint_obj.length  = (prev_bn.width+prev_bn.height)/2
		joint_obj.name = (prev_bn.name+"_end")

		joint_obj.width=.5*ctrlobj_mult
		joint_obj.height=.5*ctrlobj_mult
		joint_obj.boneFreezeLength = off
		joint_obj.boneScaleType=#scale

		mg_rig.freezeTransform joint_obj
		mg_rig.bn_nofins joint_obj
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
		fn bn_nofins cur_obj=
			(
			cur_obj.sidefins=false
			cur_obj.frontfin=false
			cur_obj.backfin=false
			),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--create char model paths
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_char_paths char_str root_path=
	(
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\mdl\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\mdl\morph\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\mdl\zbrush\archive\obj\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\mdl\zbrush\archive\ztl\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\mtl\archive\"))	
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\anm\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\anm\slicer\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\cloth\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\env\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\rnd\archive\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\rig\xaf\"))
	DOSCommand ("mkdir "+(root_path+@"models\char\"+char_str+@"\start\archive\"))
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- cr_bone
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_bone char_str chn_nm start_pos end_pos vec cur_letter=
(
	joint_obj=bonesys.createbone start_pos end_pos vec
	if cur_letter!="" then (joint_obj.name= char_str+"_"+chn_nm+"01_bn_"+cur_letter)
	else (joint_obj.name= char_str+"_"+chn_nm+"01")
	
	joint_obj.width=.5*ctrlobj_mult
	joint_obj.height=.5*ctrlobj_mult
	joint_obj.boneFreezeLength = off
	mg_rig.freezeTransform joint_obj
	joint_obj.boneScaleType=#scale
	mg_rig.bn_nofins joint_obj
	
	prev_bn=joint_obj
),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
fn cr_iksolver start_obj end_obj=
	(
		cur_ikchain = IKSys.ikChain start_obj end_obj "IKHiSolver"
		cur_ikchain.transform.controller.goalSize = 0.3*ctrlobj_mult
		cur_ikchain.name=end_obj.name+"_ikchain"
		return_value=cur_ikchain
		return_value
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

fn midPt pt1 pt2=
(
	cur_pt=[(pt1.x+pt2.x)/2,(pt1.y+pt2.y)/2,(pt1.z+pt2.z)/2]
),
-----------------------------------------------------------------------------------------------------------------------------------------------------------
fn mirror_toes cur_ary=
(
	--delete left toes if they are incorrect
	--select right toes
	--create mirror copy of toes with abdomen as pivot
	--select right toes again
	--run script

	cur_ary=mg_rig.alph_sort_ary cur_ary

		for cur_obj in cur_ary do
		(
			resetScale cur_obj
			cur_copy=copy cur_obj
			cur_copy.name=substituteString cur_obj.name " R-0" " L-0"
			cur_copy.wirecolor=cur_obj.wirecolor
			last_digit=substring cur_obj.name cur_obj.name.count cur_obj.name.count
			comp_digit="0"+(((last_digit as integer)+3) as string)
			cur_comp=(getNodeByName((substring cur_obj.name 1 (cur_obj.name.count-1))+comp_digit))
			cur_copy.transform=cur_comp.transform
			delete cur_comp
		)

		for cur_obj in cur_ary do
		(
			cur_copy=getNodeByName(substituteString cur_obj.name " R" " L")
			cur_copy.parent=getNodeByName(substituteString cur_obj.parent.name " R" " L")
		)
),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- filemerge_filtered
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- merge filtered 
		fn filemerge_filtered filt_str mergefile=
		(
			scn_objs = getmaxfileobjectnames mergefile
			use_scn_objs=deepcopy scn_objs
			cur_str_num=0
			for cur_str in use_scn_objs do
				(
				cur_str_num+=1		
				if (findString cur_str filt_str)==undefined do (use_scn_objs[cur_str_num]="")
				)
				
			mergeMAXFile mergefile use_scn_objs
		),
		--end merge filtered
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
-- alphabetical sort
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn alph_sort_ary cur_ary=
(
		for cur_num in 1 to cur_ary.count do (cur_ary[cur_num]=cur_ary[cur_num].name)
		sort cur_ary
		for cur_num in 1 to cur_ary.count do (cur_ary[cur_num]=getNodeByName (cur_ary[cur_num]))
		sorted_ary=makeUniqueArray cur_ary
),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn alph_sort_files cur_ary=
(
		sort cur_ary
		sorted_ary=makeUniqueArray cur_ary
),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_extra_ctrls char_str letter_ary=
(
	bones_layer=layermanager.getlayer 3
	controls_layer=layermanager.getlayer 1

	
obj_ary=#(
(getNodeByName(char_str+"_Bone jaw")),
(getNodeByName(char_str+"_Bone toe index R-02")),
(getNodeByName(char_str+"_Bone toe middle R-03")),
(getNodeByName(char_str+"_Bone toe middle R-02")),
(getNodeByName(char_str+"_Bone toe middle R-01")),
(getNodeByName(char_str+"_Bone toe little R-03")),
(getNodeByName(char_str+"_Bone toe index R-03")),
(getNodeByName(char_str+"_Bone toe ring R-02")),
(getNodeByName(char_str+"_Bone toe ring R-03")),
(getNodeByName(char_str+"_Bone toe index R-01")),
(getNodeByName(char_str+"_Bone toe thumb R-03")),
(getNodeByName(char_str+"_Bone toe little R-02")),
(getNodeByName(char_str+"_Bone toe little R-01")),
(getNodeByName(char_str+"_Bone toe thumb R-01")),
(getNodeByName(char_str+"_Bone toe thumb R-02")),
(getNodeByName(char_str+"_Bone toe ring R-01")),
(getNodeByName(char_str+"_Bone toe middle L-01")),
(getNodeByName(char_str+"_Bone toe little L-02")),
(getNodeByName(char_str+"_Bone toe thumb L-01")),
(getNodeByName(char_str+"_Bone toe thumb L-02")),
(getNodeByName(char_str+"_Bone toe thumb L-03")),
(getNodeByName(char_str+"_Bone toe index L-01")),
(getNodeByName(char_str+"_Bone toe index L-02")),
(getNodeByName(char_str+"_Bone toe index L-03")),
(getNodeByName(char_str+"_Bone toe little L-03")),
(getNodeByName(char_str+"_Bone toe middle L-02")),
(getNodeByName(char_str+"_Bone toe middle L-03")),
(getNodeByName(char_str+"_Bone toe ring L-01")),
(getNodeByName(char_str+"_Bone toe ring L-02")),
(getNodeByName(char_str+"_Bone toe ring L-03")),
(getNodeByName(char_str+"_Bone toe little L-01"))
)
	
		for cur_obj in obj_ary do
		(
				cur_dmy=dummy()
				cur_dmy.boxsize=[(cur_obj.width+.1),(cur_obj.length+.1),(cur_obj.height+.1)]
				cur_dmy.rotation=cur_obj.rotation
				cur_dmy.center=cur_obj.center
				
				mg_rig.AlignPivotTo cur_dmy cur_obj

				cur_dmy.parent=cur_obj.parent
				cur_obj.parent=undefined
				cur_obj.parent=cur_dmy
				
				cur_dmy.wirecolor=color 87 224 87
				cur_dmy.name=((substituteString cur_obj.name "Bone " "")+ " control")
				
				cur_obj.boneEnable=true
				
				bones_layer.addNode cur_obj
				controls_layer.addNode cur_dmy
				
			--parent jaw
			(getNodeByName(char_str+"_Bone jaw")).parent=getNodeByName(char_str+"_jaw control")
			(getNodeByName(char_str+"_jaw control")).parent=getNodeByName(char_str+"_Bone head")
		)
			for cur_letter in letter_ary do	
			(
				--parent toes
			(
				--parent toes
				(getNodeByName(char_str+"_toe thumb "+cur_letter+"-01 control")).parent=getNodeByName(char_str+"_Bone toe "+cur_letter)
				(getNodeByName(char_str+"_Bone toe thumb "+cur_letter+"-01")).parent=getNodeByName(char_str+"_toe thumb "+cur_letter+"-01 control")
				(getNodeByName(char_str+"_toe thumb "+cur_letter+"-02 control")).parent=getNodeByName(char_str+"_toe thumb "+cur_letter+"-01 control")
				(getNodeByName(char_str+"_Bone toe thumb "+cur_letter+"-02")).parent=getNodeByName(char_str+"_toe thumb "+cur_letter+"-02 control")
				(getNodeByName(char_str+"_toe thumb "+cur_letter+"-03 control")).parent=getNodeByName(char_str+"_toe thumb "+cur_letter+"-02 control")
				(getNodeByName(char_str+"_Bone toe thumb "+cur_letter+"-03")).parent=getNodeByName(char_str+"_toe thumb "+cur_letter+"-03 control")
				(getNodeByName(char_str+"_toe index "+cur_letter+"-01 control")).parent=getNodeByName(char_str+"_Bone toe "+cur_letter)
				(getNodeByName(char_str+"_Bone toe index "+cur_letter+"-01")).parent=getNodeByName(char_str+"_toe index "+cur_letter+"-01 control")
				(getNodeByName(char_str+"_toe index "+cur_letter+"-02 control")).parent=getNodeByName(char_str+"_toe index "+cur_letter+"-01 control")
				(getNodeByName(char_str+"_Bone toe index "+cur_letter+"-02")).parent=getNodeByName(char_str+"_toe index "+cur_letter+"-02 control")
				(getNodeByName(char_str+"_toe index "+cur_letter+"-03 control")).parent=getNodeByName(char_str+"_toe index "+cur_letter+"-02 control")
				(getNodeByName(char_str+"_Bone toe index "+cur_letter+"-03")).parent=getNodeByName(char_str+"_toe index "+cur_letter+"-03 control")
				(getNodeByName(char_str+"_toe middle "+cur_letter+"-01 control")).parent=getNodeByName(char_str+"_Bone toe "+cur_letter)
				(getNodeByName(char_str+"_Bone toe middle "+cur_letter+"-01")).parent=getNodeByName(char_str+"_toe middle "+cur_letter+"-01 control")
				(getNodeByName(char_str+"_toe middle "+cur_letter+"-02 control")).parent=getNodeByName(char_str+"_toe middle "+cur_letter+"-01 control")
				(getNodeByName(char_str+"_Bone toe middle "+cur_letter+"-02")).parent=getNodeByName(char_str+"_toe middle "+cur_letter+"-02 control")
				(getNodeByName(char_str+"_toe middle "+cur_letter+"-03 control")).parent=getNodeByName(char_str+"_toe middle "+cur_letter+"-02 control")
				(getNodeByName(char_str+"_Bone toe middle "+cur_letter+"-03")).parent=getNodeByName(char_str+"_toe middle "+cur_letter+"-03 control")
				(getNodeByName(char_str+"_toe ring "+cur_letter+"-01 control")).parent=getNodeByName(char_str+"_Bone toe "+cur_letter)
				(getNodeByName(char_str+"_Bone toe ring "+cur_letter+"-01")).parent=getNodeByName(char_str+"_toe ring "+cur_letter+"-01 control")
				(getNodeByName(char_str+"_toe ring "+cur_letter+"-03 control")).parent=getNodeByName(char_str+"_toe ring "+cur_letter+"-01 control")
				(getNodeByName(char_str+"_Bone toe ring "+cur_letter+"-03")).parent=getNodeByName(char_str+"_toe ring "+cur_letter+"-03 control")
				(getNodeByName(char_str+"_toe ring "+cur_letter+"-02 control")).parent=getNodeByName(char_str+"_toe ring "+cur_letter+"-01 control")
				(getNodeByName(char_str+"_Bone toe ring "+cur_letter+"-02")).parent=getNodeByName(char_str+"_toe ring "+cur_letter+"-02 control")
				(getNodeByName(char_str+"_toe little "+cur_letter+"-01 control")).parent=getNodeByName(char_str+"_Bone toe "+cur_letter)
				(getNodeByName(char_str+"_Bone toe little "+cur_letter+"-01")).parent=getNodeByName(char_str+"_toe little "+cur_letter+"-01 control")
				(getNodeByName(char_str+"_toe little "+cur_letter+"-02 control")).parent=getNodeByName(char_str+"_toe little "+cur_letter+"-01 control")
				(getNodeByName(char_str+"_Bone toe little "+cur_letter+"-02")).parent=getNodeByName(char_str+"_toe little "+cur_letter+"-02 control")
				(getNodeByName(char_str+"_toe little "+cur_letter+"-03 control")).parent=getNodeByName(char_str+"_toe little "+cur_letter+"-02 control")
				(getNodeByName(char_str+"_Bone toe little "+cur_letter+"-03")).parent=getNodeByName(char_str+"_toe little "+cur_letter+"-03 control")
			)
		)

--make blue
--for a in selection do $.wirecolor=(color 28 28 177)
),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		--START fn splnctrlintl for morph setup
		fn spln_ctrl_intl ctrl_dist fc_ary=
		(
			for cur_ctrlobj in fc_ary do
			(
					mg_rig.freezeTransform cur_ctrlobj
						
					cur_ctrlobj.pos.controller.Zero_Pos_XYZ.controller.X_Position.controller = float_limit ()
					cur_ctrlobj.pos.controller.Zero_Pos_XYZ.controller.X_Position.controller.upper_limit = ctrl_dist/2
					cur_ctrlobj.pos.controller.Zero_Pos_XYZ.controller.X_Position.controller.lower_limit = -(ctrl_dist/2)
						
					cur_ctrlobj.pos.controller.Zero_Pos_XYZ.controller.Y_Position.controller = float_limit ()
					cur_ctrlobj.pos.controller.Zero_Pos_XYZ.controller.Y_Position.controller.upper_limit = ctrl_dist/2
					cur_ctrlobj.pos.controller.Zero_Pos_XYZ.controller.Y_Position.controller.lower_limit = -(ctrl_dist/2)

					cur_ctrlobj.pos.controller.Zero_Pos_XYZ.controller.Z_Position.controller = float_limit ()
					cur_ctrlobj.pos.controller.Zero_Pos_XYZ.controller.Z_Position.controller.upper_limit = 0
					cur_ctrlobj.pos.controller.Zero_Pos_XYZ.controller.Z_Position.controller.lower_limit = 0
			)
		),
		-- END splnctrlintl
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn chpl_mirror char_str=
	(
	--mirror slipper. run before setup to create right slipper from left slipper.
	chpl_top=getNodeByName (char_str+"_chpl_top_l")
	chpl_btm=getNodeByName (char_str+"_chpl_btm_l")
	chpl_pt=getNodeByName (char_str+"_chpl_toe_pt_l")

	chpl_top.pivot=chpl_pt.pivot
	chpl_btm.pivot=chpl_pt.pivot

	mir_chpl_top=copy chpl_top
	mir_chpl_top.name=(substring chpl_top.name 1 (chpl_top.name.count-1))+"r"
		
	mir_chpl_btm=copy chpl_btm
	mir_chpl_btm.name=(substring chpl_btm.name 1 (chpl_btm.name.count-1))+"r"
		
	mir_chpl_pt=copy chpl_pt
	mir_chpl_pt.name=(substring chpl_pt.name 1 (chpl_pt.name.count-1))+"r"

	scale mir_chpl_top [-1,1,1]
	resetxform mir_chpl_top
	addmodifier mir_chpl_top (Normalmodifier ())
	mir_chpl_top.modifiers[#Normal].flip = on
	maxops.collapsenodeto mir_chpl_top 1 true
		
	scale mir_chpl_btm [-1,1,1]
	resetxform mir_chpl_btm
	addmodifier mir_chpl_btm (Normalmodifier ())
	mir_chpl_btm.modifiers[#Normal].flip = on
	maxops.collapsenodeto mir_chpl_btm 1 true
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn chpl_setup char_str letter_ary char_chpl_file char_chpl_env_l_file char_chpl_env_r_file=
	(
		
			create_pass=undefined
			
			if char_chpl_env_l_file==undefined then
			(
				char_chpl_env_l_file=mg_rig.get_highest_file (root_path+@"models\char\_all\rig\env\chpl_l_v*.env")
				char_chpl_env_r_file=mg_rig.get_highest_file (root_path+@"models\char\_all\rig\env\chpl_r_v*.env")
			)
			
			if doesFileExist char_chpl_file==false then
			(
				char_chpl_file=mg_rig.get_highest_file (root_path+@"models\char\_all\mdl\chpl_v*.max")
				create_pass=true
			)
			else create_pass=false		
			
			-- import model. does it only once instead of for l and r
			
			if (getNodeByName (char_str+"_chpl_top_l"))==undefined then (mergeMAXFile char_chpl_file)
			
			if create_pass==true then
			(
				(getNodeByName ("chpl_top_l")).name=char_str+"_chpl_top_l"
				(getNodeByName ("chpl_btm_l")).name=char_str+"_chpl_btm_l"
				(getNodeByName ("chpl_toe_pt_l")).name=char_str+"_chpl_toe_pt_l"
			)
			
			--mirror if right slipper does not exist
			if (getNodeByName (char_str+"_chpl_top_r"))==undefined then (mg_rig.chpl_mirror char_str)
				
		for cur_letter in letter_ary do
		(				
				cur_chpl_top=(getNodeByName (char_str+"_chpl_top_"+cur_letter))
				cur_chpl_btm=(getNodeByName (char_str+"_chpl_btm_"+cur_letter))
				cur_chpl_toe_pt=(getNodeByName (char_str+"_chpl_toe_pt_"+cur_letter))
				cur_foot=(getNodeByName (char_str+"_Bone foot "+cur_letter))
				cur_toe=(getNodeByName (char_str+"_Bone toe "+cur_letter))
					
				--chpl setup
				-- find mid points between two sets of verts on chpl object for bone creation positions
				pt1=(mg_rig.midPt (getVert cur_chpl_btm 173) (getVert cur_chpl_btm 174))
				pt2=(mg_rig.midPt (getVert cur_chpl_btm 105) (getVert cur_chpl_btm 106))

				-- create bones
				prev_bn=mg_rig.cr_bone char_str "chpl"  pt1 pt2 [1,0,0] cur_letter
				mg_rig.cr_endBone char_str prev_bn ctrlobj_mult

				cur_bone=getNodeByName (char_str+"_chpl01_bn_"+cur_letter)
				cur_bone_end=getNodeByName (char_str+"_chpl01_bn_"+cur_letter+"_end")
				
				--create hierarchy
				cur_chpl_top.parent =cur_bone
				cur_chpl_btm.parent=cur_bone
				cur_bone.parent=cur_chpl_toe_pt
					
				slidertime=1
				cur_chpl_toe_pt.transform=cur_toe.transform
				cur_chpl_toe_pt.parent=cur_foot
					
				-- add ik solver
				cur_ik_solver=mg_rig.cr_iksolver cur_bone cur_bone_end
					
				--create pt for animation
				cur_pt=point()
				cur_pt.name=char_str+"_chpl_"+cur_letter+ " control"
				cur_pt.rotation=((getNodeByName(char_str+"_FK foot "+((mg_rig.uppercase cur_letter)))).rotation)
				cur_pt.position=cur_ik_solver.position
				cur_pt.cross = off
				cur_pt.Box = on
				cur_pt.size=1.0
				cur_pt.wirecolor=color 87 224 87
				cur_pt.parent=cur_foot
				cur_ik_solver.parent=cur_pt

					
				-- add skin
				addmodifier cur_chpl_btm (Skin ())
				addmodifier cur_chpl_top cur_chpl_btm.modifiers[#Skin]

				skin_ary=#(cur_bone,cur_toe)
					
				select cur_chpl_btm
					
				setCommandPanelTaskMode #modify

				-- add bones to skin
				for cur_bn_obj in skin_ary do (if cur_bn_obj !=undefined do	(skinOps.addbone cur_chpl_btm.modifiers[#Skin] cur_bn_obj 0))

				cur_env_file=(execute ("char_chpl_env_"+cur_letter+"_file"))
					
				if cur_env_file!=undefined then
					(
					-- load skin env
					select cur_chpl_btm
					--for clicking ok after loading skin env works! from Bobo
					DialogMonitorOPS.RegisterNotification mg_rig.ANoon_EnvelopeCallbackFunction ID:#ANoon_Envelopes
					DialogMonitorOPS.Enabled = true
									
					skinOps.LoadEnvelope cur_chpl_btm.modifiers[#Skin] cur_env_file
									
					DialogMonitorOPS.Enabled = false
					)
					
				setCommandPanelTaskMode #create

				--apply relax
				addmodifier cur_chpl_btm (Relax ())
				addmodifier cur_chpl_top cur_chpl_btm.modifiers[#Relax]
				cur_chpl_btm.modifiers[#Relax].Relax_Value=.5
				cur_chpl_btm.modifiers[#Relax].iterations =1
				cur_chpl_btm.modifiers[#Relax].Keep_Boundary_Pts_Fixed=1
			)
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- fn_morph_add
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn fn_morph_add char_str nm_str mbase_str vertsel=
		(

		mstr_ary=(execute("$"+char_str+nm_str)) as array
		cur_obj=getNodeByName(char_str+"_"+mbase_str)
			
		setCommandPanelTaskMode #modify
		select cur_obj
			
		if cur_obj.modifiers[#Morpher]==undefined do
		(
			if cur_obj.modifiers[#Skin]==undefined then addmodifier cur_obj (morpher ())
				else  addmodifier cur_obj (morpher ()) before:cur_obj.modifiers.count
		)

			for cur_targ in mstr_ary do
			(

					--ary=filterString "string" "div"
					targ_ary=filterString cur_targ.name "_"

					if targ_ary[targ_ary.count]=="100" then
						(
						cur_trg_num=targ_ary[targ_ary.count-1] as integer
						WM3_MC_BuildFromNode cur_obj.morpher cur_trg_num cur_targ
						--if cur_targ.selectedVerts.count>0 then WM3_MC_SetUseVertexSel cur_obj.morpher cur_trg_num vertsel
							
						prog_ary=execute("$"+char_str+"_"+mbase_str+"_mt_"+targ_ary[targ_ary.count-1]+"_*")
						
						--if there are progressive morph targets
						if prog_ary.count>1 then
							(
							-- add progressive morph targets
							for prog_targ in prog_ary do
								(
								prog_str_ary=filterString prog_targ.name "_"
								cur_trg_num=targ_ary[targ_ary.count-1] as integer	

								WM3_AddProgressiveMorphNode cur_obj.morpher cur_trg_num prog_targ
								)
								
								--remove 100 weight target to fix error behavior
								for prog_num=1 to prog_ary.count do
									(
									cur_prog= (WM3_GetProgressiveMorphNode cur_obj.morpher cur_trg_num prog_num)
									if cur_prog!=undefined do
										(
										if cur_prog==cur_targ then (WM3_DeleteProgressiveMorphNode cur_obj.morpher cur_trg_num prog_num)
										)
									)
									
								--add back 100 weight target cleanly	
								WM3_AddProgressiveMorphNode cur_obj.morpher cur_trg_num cur_targ
								
								--redo weights twice to get it right
								for prog_num=1 to prog_ary.count do
									(
									cur_prog= (WM3_GetProgressiveMorphNode cur_obj.morpher cur_trg_num prog_num)
									prog_str_ary=filterString cur_prog.name "_"
									cur_trg_prog=prog_str_ary[prog_str_ary.count] as float
									WM3_SetProgressiveMorphWeight cur_obj.morpher cur_trg_num cur_prog cur_trg_prog
									)
							)
						
						)
			)
			
		setCommandPanelTaskMode #create
		),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- fc_reaction_setup
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn fc_reaction_setup char_str upnum dnnum lfnum rtnum ctrl_str ctrl_dist obj_str=
	(
	upnum_st=0
	dnnum_st=0
	lfnum_st=0
	rtnum_st=0
	cur_morph_up=undefined
	cur_morph_dn=undefined
	cur_morph_lf=undefined
	cur_morph_rt=undefined
		
	master_obj=getNodeByName(char_str+"_fc_"+ctrl_str)
	master_cont=(getNodeByName(char_str+"_fc_"+ctrl_str)).pos.controller[2].controller
	
	tmp_dist=(ctrl_dist/2) as string
	
	char_body=getNodeByName(char_str+"_"+obj_str)
		
			if upnum!="" do
				(
				if char_body.morpher[(upnum as integer)].name=="- empty -" then (upnum="")
				else
					(
					execute ("paramWire.connect $"+master_obj.name+".pos.controller.Zero_Pos_XYZ.controller.Y_Position.controller[#Limited_Controller__Bezier_Float] $"+char_str+"_"+obj_str+".modifiers[#Morpher]["+upnum+"]  \"if ((Limited_Controller__Bezier_Float/"+tmp_dist+")*(100))>0 then ((Limited_Controller__Bezier_Float/"+tmp_dist+")*(100)) else 0\"")
					upnum_st+=1
					)
				)
			
			if dnnum!="" do
				(
				if char_body.morpher[(dnnum as integer)].name=="- empty -" then (dnnum="")
				else
					(
					execute ("paramWire.connect $"+master_obj.name+".pos.controller.Zero_Pos_XYZ.controller.Y_Position.controller[#Limited_Controller__Bezier_Float] $"+char_str+"_"+obj_str+".modifiers[#Morpher]["+dnnum+"]  \"if ((Limited_Controller__Bezier_Float/"+tmp_dist+")*(100))<0 then ((Limited_Controller__Bezier_Float/"+tmp_dist+")*(100)*(-1)) else 0\"")
					dnnum_st+=1
					)
				)
							
			if lfnum!="" do
				(
				if char_body.morpher[(lfnum as integer)].name=="- empty -" then (lfnum="")
				else
					(
					execute ("paramWire.connect $"+master_obj.name+".pos.controller.Zero_Pos_XYZ.controller.X_Position.controller[#Limited_Controller__Bezier_Float] $"+char_str+"_"+obj_str+".modifiers[#Morpher]["+lfnum+"]  \"if ((Limited_Controller__Bezier_Float/"+tmp_dist+")*(100))>0 then ((Limited_Controller__Bezier_Float/"+tmp_dist+")*(100)) else 0\"")
					lfnum_st+=1
					)
				)
				
			if rtnum!="" do
				(
				if char_body.morpher[(rtnum as integer)].name=="- empty -" then (rtnum="")
				else
					(
					execute ("paramWire.connect $"+master_obj.name+".pos.controller.Zero_Pos_XYZ.controller.X_Position.controller[#Limited_Controller__Bezier_Float] $"+char_str+"_"+obj_str+".modifiers[#Morpher]["+rtnum+"]  \"if ((Limited_Controller__Bezier_Float/"+tmp_dist+")*(100))<0 then ((Limited_Controller__Bezier_Float/"+tmp_dist+")*(100)*(-1)) else 0\"")
					rtnum_st+=1
					)
				)
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn add_skin char_str cur_obj skin_ary env_file ref_frame=
(
					addmodifier cur_obj (skin())
					select cur_obj
						
					--skin
					setCommandPanelTaskMode #modify
					cur_obj.modifiers[#Skin].ref_frame=ref_frame
					cur_obj.modifiers[#Skin].always_deform=false
					cur_obj.modifiers[#Skin].always_deform=true
						
					-- add bones to skin
						for cur_bn_obj in skin_ary do (if cur_bn_obj !=undefined do	(skinOps.addbone cur_obj.modifiers[#Skin] cur_bn_obj 0))
							
					if env_file!=undefined do--if env_file!="" do
					(
						select cur_obj
						--for clicking ok after loading skin env works! from Bobo

						DialogMonitorOPS.RegisterNotification mg_rig.ANoon_EnvelopeCallbackFunction ID:#ANoon_Envelopes
						DialogMonitorOPS.Enabled = true
					
						skinOps.LoadEnvelope cur_obj.modifiers[#Skin] env_file
					
						DialogMonitorOPS.Enabled = false
						
						setCommandPanelTaskMode #create
					)
),					
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		fn cr_eye_setup char_str letter_ary ctrlobj_mult=
		(
			for cur_letter in letter_ary do
			(
				--eye setup
				pt_obj=Point()
				pt_obj.size=(1*ctrlobj_mult)
				pt_obj.transform=(getNodeByName(char_str+"_eyelns_"+cur_letter)).transform
				pt_obj.name=char_str+"_eye_"+cur_letter+"_pt01"
				pt_obj.parent=getNodeByName(char_str+"_Head control")
				(getNodeByName(char_str+"_eyelns_"+cur_letter)).parent=getNodeByName(char_str+"_eye_"+cur_letter+"_pt01")
				(getNodeByName(char_str+"_eye_"+cur_letter)).parent=getNodeByName(char_str+"_eye_"+cur_letter+"_pt01")
				cur_targ=copy (getNodeByName(char_str+"_eye_"+cur_letter+"_pt01"))
				move cur_targ [0,-35,0]
				cur_targ.name=char_str+"_eye_"+cur_letter+"_pt02 control"
				cur_lookat= LookAt_Constraint relative:true 
				cur_lookat.appendTarget cur_targ 100
				pt_obj.rotation.controller=cur_lookat

			)
	
				cur_eye_r_pt=getNodeByName(char_str+"_eye_r_pt02 control")
				cur_eye_l_pt=getNodeByName(char_str+"_eye_l_pt02 control")	
				cur_dmy=point()
				cur_dmy.name=char_str+"_lookat control"
				cur_dmy.cross=false
				cur_dmy.box=true
				cur_dmy.size=30
				cur_dmy.transform=cur_eye_r_pt.transform
				move cur_dmy [(distance cur_eye_r_pt cur_eye_l_pt )/2,0,0]
				scale cur_dmy [.75,.25,.25]
				cur_eye_l_pt.parent=cur_dmy
				cur_eye_r_pt.parent=cur_dmy
			
				controls_layer=layermanager.getlayer 1
				controls_layer.addNode cur_dmy
				controls_layer.addNode cur_eye_l_pt
				controls_layer.addNode cur_eye_r_pt

		),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				fn cr_morph_setup char_str fc_ctrls_file char_face_trg_file char_tng_trg_file char_eye_trg_file del_setup=
					(
						if del_setup == true then
						(
						mg_rig.filemerge_filtered "_mt_" char_face_trg_file
						mg_rig.filemerge_filtered "_mt_" char_tng_trg_file
						mg_rig.filemerge_filtered "_mt_" char_eye_trg_file
						)
						
					mg_rig.fn_morph_add char_str "*body_mt*" "body" false
					mg_rig.fn_morph_add char_str "*tng_mt*" "tng" false
					mg_rig.fn_morph_add char_str "*eye_mt*" "eye_r" false
					addModifier (getNodeByName (char_str+"_eye_l")) ((getNodeByName (char_str+"_eye_r")).morpher)
						
						if del_setup == true then
							(
							mergeMAXFile fc_ctrls_file
							fc_ary=(execute("$"+char_str+"*_fc_*")) as array
							mg_rig.spln_ctrl_intl ctrl_dist fc_ary
							
							delete $*_mt_*
							
							--upnum dnnum lfnum rtnum
							mg_rig.fc_reaction_setup char_str "1" "7" "" "" "browa_r" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "2" "8" "" "" "browa_l" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "3" "" "" "" "browb_r" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "4" "" "" "" "browb_l" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "9" "5" "51" "" "upeye_r" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "10" "6" "" "52" "upeye_l" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "11" "53" "" "" "loweye_r" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "12" "54" "" "" "loweye_l" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "13" "" "43" "41" "nostril_r" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "14" "" "42" "44" "nostril_l" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "15" "33" "" "47" "uplip_r" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "16" "34" "48" "" "uplip_l" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "35" "25" "" "45" "lowlip_r" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "36" "26" "46" "" "lowlip_l" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "" "" "29" "31" "lipo_r" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "" "" "32" "30" "lipo_l" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "27" "" "" "" "chin_r" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "28" "" "" "" "chin_l" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "19" "" "39" "37" "cheek_r" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "20" "" "38" "40" "cheek_l" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "17" "23" "" "21" "lpcrnr_r" ctrl_dist "body"
							mg_rig.fc_reaction_setup char_str "18" "24" "22" "" "lpcrnr_l" ctrl_dist "body"
							
							--tng
							mg_rig.fc_reaction_setup char_str "" "1" "" "" "tng_bka" ctrl_dist "tng"
							mg_rig.fc_reaction_setup char_str "" "3" "" "" "tng_bkb" ctrl_dist "tng"
							mg_rig.fc_reaction_setup char_str "" "" "5" "8" "tng_r" ctrl_dist "tng"
							mg_rig.fc_reaction_setup char_str "" "" "6" "9" "tng_mid" ctrl_dist "tng"
							mg_rig.fc_reaction_setup char_str "" "" "7" "10" "tng_l" ctrl_dist "tng"
							mg_rig.fc_reaction_setup char_str "" "2" "" "" "tng_fra" ctrl_dist "tng"
							mg_rig.fc_reaction_setup char_str "" "4" "" "" "tng_frb" ctrl_dist "tng"
							
							--eye
							mg_rig.fc_reaction_setup char_str "1" "" "" "" "eye_mid" ctrl_dist "eye_r"
							mg_rig.fc_reaction_setup char_str "" "2" "" "" "eye_mid" ctrl_dist "eye_r"
							)
					),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--create tng and head morph target files
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					
fn cr_mt_file char_str obj_type=
	(
		LoadMaxFile char_mdl_file

		max unhide all
		
		source_obj=getNodeByName (char_str+"_"+obj_type)

		source_obj.material=undefined
		
		select source_obj
		
		max select invert
		
		delete selection
		
		mt_nm_ary=#()
		
		mt_body_ary=#("mt_01_25",
		"mt_01_100",
		"mt_02_25",
		"mt_02_100",
		"mt_03_100",
		"mt_04_100",
		"mt_05_50",
		"mt_05_100",
		"mt_06_50",
		"mt_06_100",
		"mt_07_100",
		"mt_08_100",
		"mt_09_100",
		"mt_10_100",
		"mt_11_100",
		"mt_12_100",
		"mt_13_75",
		"mt_13_100",
		"mt_14_75",
		"mt_14_100",
		"mt_15_100",
		"mt_16_100",
		"mt_17_100",
		"mt_18_100",
		"mt_19_100",
		"mt_20_100",
		"mt_21_100",
		"mt_22_100",
		"mt_23_100",
		"mt_24_100",
		"mt_25_100",
		"mt_26_100",
		"mt_27_100",
		"mt_28_100",
		"mt_29_50",
		"mt_29_75",
		"mt_29_100",
		"mt_30_50",
		"mt_30_75",
		"mt_30_100",
		"mt_31_100",
		"mt_32_100",
		"mt_33_100",
		"mt_34_100",
		"mt_35_50",
		"mt_35_100",
		"mt_36_50",
		"mt_36_100",
		"mt_37_100",
		"mt_38_100",
		"mt_39_100",
		"mt_40_100",
		"mt_41_100",
		"mt_42_100",
		"mt_43_100",
		"mt_44_100",
		"mt_45_100",
		"mt_46_100",
		"mt_47_100",
		"mt_48_100",
		"mt_49_33",
		"mt_49_66",
		"mt_49_100",
		"mt_51_100",
		"mt_52_100",
		"mt_53_100",
		"mt_54_100")

		mt_tng_ary=#("mt_1_100",
		"mt_2_100",
		"mt_3_100",
		"mt_6_100",
		"mt_5_100",
		"mt_7_100",
		"mt_10_100",
		"mt_9_100",
		"mt_8_100",
		"mt_4_100")
		
		if obj_type=="body" then mt_nm_ary=mt_body_ary
		else mt_nm_ary=mt_tng_ary
			
			
		for cur_str in mt_nm_ary do
			(
			cur_mt=copy source_obj
			cur_mt.name=char_str+"_"+obj_type+"_"+cur_str
			)

		makeDir (root_path+@"models\char\"+char_str+@"\mdl\morph\") all:true
		if obj_type=="body" then (saveMaxFile (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_morph_v01.max"))
		else (saveMaxFile (root_path+@"models\char\"+char_str+@"\mdl\morph\"+char_str+@"_tng_trg_v01.max"))
		
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn highest_version cur_path=
	(
		file_ary=getfiles cur_path
		mg_rig.alph_sort_files(file_ary)
		file_ary[file_ary.count]
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn get_highest_file cur_str=
	(
	cur_ary=getFiles cur_str
	mg_rig.alph_sort_files cur_ary
	if cur_ary.count>0 then cur_file=cur_ary[cur_ary.count]
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn cr_eyedispl char_str=
	(
	controls_layer=layermanager.getlayer 1
		
	-- create displ spheres for eyes
	cur_displ=spaceDisplace()
	cur_displ.name=(char_str+"_eye_l_displ")
	cur_displ.transform=(getNodeByName(char_str+"_eye_l")).transform
	cur_displ.parent=getNodeByName(char_str+"_eye_l_pt01")
	cur_displ.maptype = 2
	cur_displ.length = (nodeLocalBoundingBox (getNodeByName (char_str+"_eye_l")))[2].x/3--1.163
	cur_displ.width = cur_displ.length
	cur_displ.height = cur_displ.length
	cur_displ.strength =0.23
	cur_displ.decay = 3.245
	
	if (getNodeByName(char_str+"_body_r"))!=undefined then
	(bindSpaceWarp (getNodeByName(char_str+"_body_r")) (getNodeByName(cur_displ.name)))
	else
	(bindSpaceWarp (getNodeByName(char_str+"_body")) (getNodeByName(cur_displ.name)))
		
	copy_displ=copy cur_displ
	copy_displ.name=(char_str+"_eye_r_displ")
	copy_displ.transform=(getNodeByName(char_str+"_eye_r")).transform
	copy_displ.parent=getNodeByName(char_str+"_eye_r_pt01")

	if (getNodeByName(char_str+"_body_r"))!=undefined then
	(bindSpaceWarp (getNodeByName(char_str+"_body_r")) (getNodeByName(copy_displ.name)))
	else
	(bindSpaceWarp (getNodeByName(char_str+"_body")) (getNodeByName(copy_displ.name)))

	controls_layer.addNode cur_displ
	controls_layer.addNode copy_displ	
	
	--jaw messes up mouth bag
	jaw_displ=spaceDisplace()
	jaw_displ.maptype = 0
	jaw_displ.width = 1.4
	jaw_displ.height = .6
	jaw_displ.strength =0.0
	jaw_displ.decay = 0.0
	rotate jaw_displ (angleaxis 90.0 [1,0,0])
		
	jaw_displ.name=(char_str+"_jaw_displ")
	jaw_displ.center=(getNodeByName(char_str+"_btmgums")).center
	jaw_displ.parent=(getNodeByName(char_str+"_Bone jaw"))
	
	if (getNodeByName(char_str+"_body_r"))!=undefined then
	(bindSpaceWarp (getNodeByName(char_str+"_body_r")) jaw_displ)
	else
	(bindSpaceWarp (getNodeByName(char_str+"_body")) jaw_displ)
		
	controls_layer.addNode jaw_displ
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn set_obj_ids=
	(
		cur_ary=$*_cloth_r
		for cur_obj in cur_ary do cur_obj.gbufferchannel = 6

		cur_ary=$*_tng
		for cur_obj in cur_ary do cur_obj.gbufferchannel = 6
			
		cur_ary=$*_body_r
		for cur_obj in cur_ary do cur_obj.gbufferchannel = 7

		cur_ary=$*_brows
		for cur_obj in cur_ary do cur_obj.gbufferchannel = 8
			
		cur_ary=$*_hair
		for cur_obj in cur_ary do cur_obj.gbufferchannel = 8
		
		cur_ary=$*_bun
		for cur_obj in cur_ary do cur_obj.gbufferchannel =8
			
		cur_ary=$*_mst_loft*
		for cur_obj in cur_ary do cur_obj.gbufferchannel =8		
		
		cur_ary=$*_gums
		for cur_obj in cur_ary do cur_obj.gbufferchannel =9		

		cur_ary=$*_nails
		for cur_obj in cur_ary do cur_obj.gbufferchannel =9
			
		cur_ary=$*_eye*
		for cur_obj in cur_ary do cur_obj.gbufferchannel =9

		cur_ary=$*_teeth*
		for cur_obj in cur_ary do cur_obj.gbufferchannel =10
	),
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
fn cr_layer obj_ary layer_str=
	(
	--create layers
	cur_layer=LayerManager.newLayer()
	cur_layer.setName layer_str

	for cur_obj in obj_ary do (cur_layer.addNode cur_obj)
	),
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fn uppercase instring =
	( local upper, lower, outstring
	upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	lower="abcdefghijklmnopqrstuvwxyz"
	 
	outstring=copy instring
	 
	for i=1 to outstring.count do
	 
	-- see if the single character at index i in outstring
	-- is present instring lower
	-- If so, j equals position in string lower.
	-- If not, j equals undefined
	( j=findString lower outstring[i]
	 
	-- if character was found in lower,
	-- replace with corresponding character in upper:
	if (j != undefined) do outstring[i]=upper[j]
	)
	outstring-- value will be returned as function result
	)
)
--End Struct Def