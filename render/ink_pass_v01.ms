char_str="riz"
root_path=@"c:\temp\projects\pd\"
loadMaterialLibrary (root_path+@"\mat\char\ink_pass_v01.mat")

fine_ary=#(
(getNodeByName(char_str+"_btmgums")),
(getNodeByName(char_str+"_topgums")),
(getNodeByName(char_str+"_teethbtm")),
(getNodeByName(char_str+"_teethtop")),
(getNodeByName(char_str+"_tng")),
(getNodeByName(char_str+"_nails")),
(getNodeByName(char_str+"_eye_r")),
(getNodeByName(char_str+"_eye_l"))
)

for cur_obj in fine_ary do	(if cur_obj!=undefined do cur_obj.material=currentMaterialLibrary["ink_fine_mtl"])

hide_ary=#(
(getNodeByName(char_str+"_body")),
(getNodeByName(char_str+"_eyelns_r")),
(getNodeByName(char_str+"_eyelns_l"))
)
for cur_obj in hide_ary do	(if cur_obj!=undefined do cur_obj.renderable=false)

med_ary=#(
)

for cur_obj in med_ary do	(if cur_obj!=undefined do cur_obj.material=currentMaterialLibrary["ink_med_mtl"])

thick_ary=#(
(getNodeByName(char_str+"_pkt_cloth")),
(getNodeByName(char_str+"_shlw_cloth")),
(getNodeByName(char_str+"_kamz_cloth")),
(getNodeByName(char_str+"_hair")),
(getNodeByName(char_str+"_bun")),
(getNodeByName(char_str+"_mst_l")),
(getNodeByName(char_str+"_mst_r"))
)

for cur_obj in thick_ary do	(if cur_obj!=undefined do cur_obj.material=currentMaterialLibrary["ink_thick_mtl"])

renderers.current = mental_ray_renderer()
renderers.current.Enable_Camera_Lens_Shader=true
renderers.current.Camera_Lens_Shader=currentMaterialLibrary["ink_shader_global"]

cur_body=getNodeByName(char_str+"_body")
addmodifier cur_body (Mesh_Select ())
addmodifier cur_body (Push ())
setVertSelection cur_body cur_body.modifiers[#Mesh_Select] #{296..301, 374, 1930..1933, 1936, 2096, 2191, 2198, 2214..2215, 2363..2368}
cur_body.modifiers[#Push].Push_Value = -0.1
/*
modPanel.setCurrentObject $.modifiers[#Mesh_Select]
subobjectLevel = 0
modPanel.setCurrentObject $.modifiers[#Push]
*/
