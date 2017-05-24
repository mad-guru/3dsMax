cur_path=@"C:\temp\projects\pd\psd\char\"

max modify mode

for cur_obj in selection do
(
	char_str=substring cur_obj.name 1 3
	if cur_obj.name==(char_str+"_body") then (cur_width=4096)
		else (cur_width=2048)

	addmodifier cur_obj (Unwrap_UVW())

	cur_obj_uvw=cur_obj.modifiers[#Unwrap_UVW]
	cur_obj_uvw.renderuv_force2sided=true
	cur_obj_uvw.renderuv_width=cur_width
	cur_obj_uvw.renderuv_height=cur_width
	cur_obj_uvw.renderuv_fillColor=(color 0 0 0)
	cur_obj_uvw.renderuv_edgeColor=(color 128 128 128)
	cur_obj_uvw.renderUV (cur_path+char_str+@"\"+cur_obj.name+@".jpg")

	deleteModifier cur_obj 1
	)

max create mode