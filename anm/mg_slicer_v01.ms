-- mg_slicer_v01.ms

-- By Adnan Hussain
-- Mad Guru Productions
-- http://www.madguru.com

-- Jun. 13 2011
-- A set of tools to slice up a model and parent the parts to a skeleton
-- This is particularly useful for creating a fast animation friendly rig from a skinned rig
-- No warranty is made expressed or implied as to the safety or useability of any of the code provided. Use at your own risk.

struct mg_slicer
(
	char_str="", attach_ary=#(), cur_material, bn_ary=#(), bn_layer, target_ary, src_str="", trg_str="", tmp_matid,
	
	fn attach_parts src_obj obj_ary=
	(
		undo off
		(
		collapseStack src_obj
		convertToPoly src_obj

		for cur_obj in obj_ary do (convertToPoly cur_obj; collapseStack cur_obj)
		for cur_obj in obj_ary do src_obj.attach cur_obj src_obj
		)
	),
------------------------------------------------------------------------------------------------------------------------------------------------	
	fn set_var char_str=
	(
		if (getNodeByName(mg_slicer.char_str+"_body"))!=undefined then
			(
				if mg_slicer.char_str==undefined then mg_slicer.char_str=""
				mg_slicer.attach_ary=#((getNodeByName(mg_slicer.char_str+"_body")),(getNodeByName(mg_slicer.char_str+"_brows")),(getNodeByName(mg_slicer.char_str+"_nails")),(getNodeByName(mg_slicer.char_str+"_hair")))
				mg_slicer.bn_layer=layermanager.getlayer 3
				mg_slicer.bn_layer.nodes &mg_slicer.bn_ary
				mg_slicer.target_ary=#((getNodeByName(mg_slicer.char_str+"_body")),(getNodeByName(mg_slicer.char_str+"_shlw_cloth")),(getNodeByName(mg_slicer.char_str+"_kamz_cloth")))
				mg_slicer.src_str="Bone"
				mg_slicer.trg_str="anim"
			)
	),
	
------------------------------------------------------------------------------------------------------------------------------------------------
	--create mult_material
	fn cr_mtl bn_ary target_ary=
		(
		mg_slicer.cur_material= Multimaterial ()
		mg_slicer.cur_material.materialList.count = mg_slicer.bn_ary.count
					
		for matnum in 1 to mg_slicer.bn_ary.count do (mg_slicer.cur_material.materialList[matnum].Diffuse = color (random 0 255) (random 0 255) (random 0 255))
			
		for cur_target in mg_slicer.target_ary do cur_target.material=mg_slicer.cur_material
		),
------------------------------------------------------------------------------------------------------------------------------------------------
	--for target_obj in mg_slicer.target_ary do	
	fn cr_slices target_obj cur_material=
	(
		undo off
		(
		convertToPoly target_obj
		collapseStack target_obj
		
		--find closest vert on mesh
		total_faces=target_obj.numfaces
			
			for cur_face in 1 to total_faces do
			(
				best_dist=900000000000000000
				closest_face=undefined
				closest_num=undefined

				cur_face_pos=polyop.getFaceCenter target_obj cur_face node:target_obj

				--meshop.getFaceCenter target_obj cur_face
				for cur_num in 1 to mg_slicer.bn_ary.count do
				(
					cur_bn=mg_slicer.bn_ary[cur_num]
					cur_dist= distance cur_bn.center cur_face_pos
											
					if cur_dist<best_dist do
					(
						best_dist=cur_dist
						polyop.setFaceMatID target_obj cur_face cur_num
					)
				)
			)
		)
		if mg_slicer.cur_material!=undefined do target_obj.material=mg_slicer.cur_material
	),
------------------------------------------------------------------------------------------------------------------------------------------------
	
	fn brk_slices target_obj bn_ary src_str trg_str=
	(
		--based on http://emrahgunduz.com/categories/development/maxscript/detach-using-material-ids/
		for cur_matid = 1 to mg_slicer.bn_ary.count do
		(
			totalfaces = polyop.getNumFaces target_obj
			face_ary = #()
			
			for cur_face = 1 to totalfaces do
			(
				face_matid = polyop.getFaceMatID target_obj cur_face
				
				if face_matid == cur_matid then (face_ary[face_ary.count+1]=cur_face)
			)
							
			if face_ary.count>0 do
			(
				tmp_ary=filterString target_obj.name "_"
				if mg_slicer.src_str!=undefined and mg_slicer.trg_str!=undefined then	(part_name=(substituteString mg_slicer.bn_ary[cur_matid].name mg_slicer.src_str mg_slicer.trg_str)+"_"+tmp_ary[2])
				else part_name=mg_slicer.bn_ary[cur_matid].name+"_anm"
				polyop.detachFaces target_obj face_ary delete:false asNode:true name:part_name
				cur_part=(getNodeByName(part_name))
				cur_part.parent=mg_slicer.bn_ary[cur_matid]
				cur_part.wirecolor=target_obj.wirecolor
					
				if mg_slicer.cur_material[cur_matid]!=undefined do cur_part.material=mg_slicer.cur_material[cur_matid]
			)
		)
		update target_obj
		delete target_obj
		gc()
		),
------------------------------------------------------------------------------------------------------------------------------------------------		
	fn save_slices char_str target_ary bn_ary=
	(
		if mg_slicer.char_str==undefined then mg_slicer.char_str=""
		cur_path=maxFilePath
		file_str=(cur_path+mg_slicer.char_str+@"_slicer.ms")
		out_name = getSaveFileName caption:"Save Slice File:" filename:file_str types:"Maxscript (*.ms)|All|*.*|"

		out_file = createfile out_name

		for target_obj in mg_slicer.target_ary do
		(
			collapseStack target_obj
			convertToPoly target_obj
			
				--based on http://emrahgunduz.com/categories/development/maxscript/detach-using-material-ids/
				for cur_matid = 1 to mg_slicer.bn_ary.count do
				(
					totalfaces = polyop.getNumFaces target_obj
					face_ary = #()
					
					for cur_face = 1 to totalfaces do
					(
						face_matid = polyop.getFaceMatID target_obj cur_face
						
						if face_matid == cur_matid then (face_ary[face_ary.count+1]=cur_face)
					)
									
					if face_ary.count>0 do
					(
						tmp_ary=filterString target_obj.name "_"
						ary_name=tmp_ary[2]+"_"+(cur_matid as string)+"_ary"
						format ("\n"+ary_name+"=") to:out_file
						with printAllElements on (format (face_ary as string) to:out_file)
					)
				)
				gc()
		)
		close out_file
	),
------------------------------------------------------------------------------------------------------------------------------------------------
	fn load_slices char_str target_ary bn_ary=
	(
	if mg_slicer.char_str==undefined then mg_slicer.char_str=""
	cur_path=maxFilePath
	file_str=(cur_path+mg_slicer.char_str+@"_slicer.ms")
	out_file = getOpenFileName caption:"Open Slice File:" filename:file_str types:"Maxscript (*.ms)|All|*.*|"

	filein out_file

	for target_obj in mg_slicer.target_ary do
		(
			collapseStack target_obj
			convertToPoly target_obj
			tmp_ary=filterString target_obj.name "_"

			for cur_matid = 1 to mg_slicer.bn_ary.count do
				(
					if (execute(tmp_ary[2]+"_"+(cur_matid as string)+"_ary"))!=undefined do
						(
						cur_ary=(execute(tmp_ary[2]+"_"+(cur_matid as string)+"_ary")) as bitarray
						polyop.setFaceMatID target_obj cur_ary cur_matid
						)
				)
		)
	)

)
--end struct

mg_slicer=mg_slicer()

rollout slicer_Rollout "Slicer Tools" width:142 height:438
(
	button attach_btn "Attach Parts" pos:[11,192] width:117 height:27 toolTip:"Select an obj then ctrl select objs to attach to it and click the attach button below."
	button setvars_btn "Set Variables" pos:[11,39] width:117 height:27 toolTip:"Set Variables"
	button crmtl_btn "Create Material" pos:[11,130] width:117 height:27 toolTip:"Creates a Multi-Material which helps see matIDs with random colors."
	button crslices_btn "Create Slices" pos:[11,256] width:117 height:27 toolTip:"Create Slices by assigning MatIDs based off distance to slice source objects."
	button brkslices_btn "Break Slices" pos:[11,350] width:117 height:27 toolTip:"Break Slices"
	button getmat_btn "Get MatID" pos:[11,288] width:57 height:28 toolTip:"Get MatID"
	button setmat_btn "Set MatID" pos:[70,288] width:57 height:27 toolTip:"Set MatID"
	edittext charstr_edt "Char String" pos:[14,18] width:113 height:15
	button saveslices_btn "Save Slices" pos:[11,319] width:57 height:27 toolTip:"Save Slices"
	button loadslices_btn "Load Slices" pos:[71,319] width:57 height:27 toolTip:"Load Slices"
	GroupBox vars_grp "Set Variables" pos:[5,5] width:131 height:158
	GroupBox util_grp "Utilities" pos:[5,177] width:132 height:48
	GroupBox divmodel_grp "Divide Model" pos:[5,238] width:132 height:144
	button targetary_btn "Set Objects to Slice" pos:[12,100] width:117 height:27 toolTip:"Select Objects to Slice and click this button"
	button setslicers_btn "Set Slicer Objects" pos:[12,69] width:117 height:27 toolTip:"Select to select based off and click this button"
	label info_lbl "By Adnan Hussain       June 13, 2011 http://www.madguru.com" pos:[9,387] width:127 height:46
	on attach_btn pressed do
		(obj_ary=selection as array; src_obj=selection[1];mg_slicer.attach_parts src_obj obj_ary)
	on setvars_btn pressed do
		(mg_slicer.set_var mg_slicer.char_str)
	on crmtl_btn pressed do
		(mg_slicer.cr_mtl mg_slicer.bn_ary mg_slicer.target_ary)
	on crslices_btn pressed do
		(for target_obj in mg_slicer.target_ary do (mg_slicer.cr_slices target_obj mg_slicer.cur_material))
	on brkslices_btn pressed do
		(for target_obj in mg_slicer.target_ary do (mg_slicer.brk_slices target_obj mg_slicer.bn_ary mg_slicer.src_str	mg_slicer.trg_str))
	on getmat_btn pressed do
		(mg_slicer.tmp_matid=(polyop.getFaceMatID $ ((polyop.getFaceSelection $) as array)[1]))
	on setmat_btn pressed do
		polyop.setFaceMatID $ (polyop.getFaceSelection $) mg_slicer.tmp_matid
	on charstr_edt entered text do
		mg_slicer.char_str=charstr_edt.text --as string
	on saveslices_btn pressed do
		(mg_slicer.save_slices mg_slicer.char_str mg_slicer.target_ary mg_slicer.bn_ary)
	on loadslices_btn pressed do
		(mg_slicer.load_slices mg_slicer.char_str mg_slicer.target_ary mg_slicer.bn_ary)
	on targetary_btn pressed do
		(mg_slicer.target_ary=selection as array)
	on setslicers_btn pressed do
		(mg_slicer.bn_ary=selection as array)
)

slicer_tools=newRolloutFloater "MG Slicer Tools v1.0" 150 470
--addRollout applyRollout reactor_rope_tools_floater
addRollout slicer_Rollout slicer_tools