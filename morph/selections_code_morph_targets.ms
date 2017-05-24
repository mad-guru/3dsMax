--create a mesh select mod and select half face with soft selection edge distance set to 1 to make the middle row of verts orange. Do this for both sides?
-- set that first odd/even with this line:
cur_obj=$
cur_mod=copy cur_obj.modifiers[1]

--then select other odd/even targets and run:
for cur_obj in selection do (addmodifier cur_obj cur_mod)

--if you need to remove the top mod of selected objects:
for cur_obj in selection do (deleteModifier cur_obj 1)

cur_verts=getVertSelection $

for cur_targ in selection do
	(
	addmodifier cur_targ (Turn_to_Mesh ())
	maxOps.CollapseNode cur_targ off
	setVertSelection cur_targ cur_verts
	addmodifier cur_targ (Turn_to_Poly ())
	maxOps.CollapseNode cur_targ off
	cur_targ.useSoftSel =true
    cur_targ.ssUseEdgeDist=true
    cur_targ.ssEdgeDist=1
	addmodifier cur_targ (Turn_to_Mesh ())
	maxOps.CollapseNode cur_targ off

	)