char_str="wal"

obj_ary=#(getNodeByName (char_str+"_kamz_cloth"),getNodeByName (char_str+"_shlw_cloth"),getNodeByName (char_str+"_pkt_cloth"),getNodeByName (char_str+"_dpta_cloth"))

for cur_obj in obj_ary do
(
	if cur_obj!=undefined then
	(print "got here"
	print cur_obj.name
	collapseStack cur_obj
	rnd_obj=snapshot cur_obj
	rnd_obj.name=cur_obj.name+"_r"
	cur_obj.renderable = off
	addmodifier rnd_obj (Vertex_Weld ())
	collapseStack  rnd_obj
	addmodifier rnd_obj (Skin_wrap ())
	rnd_obj.modifiers[#Skin_wrap].meshlist=#(cur_obj)
	rnd_obj.modifiers[#Skin_wrap].engine=0
		
	spl_str=substituteString cur_obj.name "cloth" "spl"
	cur_spl=getNodeByName spl_str
	if cur_spl!=undefined then delete cur_spl
	)
)

if $ref_rectangle!=undefined then delete $ref_rectangle