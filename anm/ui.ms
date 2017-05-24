rollout unnamedRollout "Untitled" width:162 height:281
(
	button attach_btn "Attach Body Parts" pos:[11,35] width:117 height:27 toolTip:"Attach Body Parts"
	button setvars_btn "Set Variables" pos:[11,6] width:117 height:27 toolTip:"Set Variables"
	button crmtl_btn "Create Material" pos:[10,64] width:117 height:27 toolTip:"Create Material"
	button crslices_btn "Create Slices" pos:[11,133] width:117 height:27 toolTip:"Create Slices"
	button brkslices_btn "Break Slices" pos:[11,163] width:117 height:27 toolTip:"Break Slices"
	button getmat_btn "Get MatID" pos:[11,98] width:57 height:27 toolTip:"Get MatID"
	button setmat_btn "Set MatID" pos:[70,98] width:57 height:27 toolTip:"Set MatID"
	on attach_btn pressed  do
		mg_slice.attach_parts char_str
	on setvars_btn pressed  do
		mg_slice.set_var char_str
	on crmtl_btn pressed  do
		mg_slice.cr_mtl bn_ary
	on crslices_btn pressed  do
		mg_slice.cr_slices target_obj cur_material
	on brkslices_btn pressed  do
		mg_slice.brk_slices targ_obj
	on getmat_btn pressed  do
		mg_slice.cr_slices target_obj cur_material
	on setmat_btn pressed  do
		mg_slice.cr_slices target_obj cur_material
)