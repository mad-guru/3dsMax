/*
$.verts.count
4038

$.verts[1].position
*/
base_obj=$riz_hand001
targ_obj=$riz_mirrored

targ_verts=(polyop.getVertSelection targ_obj) as array
base_verts=(polyop.getVertSelection base_obj) as array


for cur_vert_num in 1 to base_verts.count do
(
	cur_vert=base_obj.verts[base_verts[cur_vert_num]]
	cur_pos=targ_obj.verts[targ_verts[1]].position
	
		for cur_targ_vert in 1 to targ_verts.count do
		(
			cur_pos_try=targ_obj.verts[targ_verts[cur_targ_vert]].position
			if (distance cur_pos_try cur_vert.position) < (distance cur_pos cur_vert.position) do cur_pos=cur_pos_try
		)
	cur_vert.position=cur_pos
)