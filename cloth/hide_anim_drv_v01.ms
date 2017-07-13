--selects all Smd objects, unhides them and hides their corresponding anim drivers.

select $*Smd_
unhide selection

for cur_obj in selection do
(
cur_str=cur_obj.name
str_ary=filterString cur_str "_"
--str_part=substituteString (str_ary[str_ary.count]) "-Smd_" "_"
new_str=(substitutestring (substitutestring cur_str "_Cloth_" "_Mesh_") "-Smd_" "_")
if (getNodeByName new_str)!=undefined then hide (getNodeByName new_str)
else print ("does not exist "+new_str)
)