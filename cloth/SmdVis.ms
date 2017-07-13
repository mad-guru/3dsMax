--selects all Smd objects, unhides them and hides their corresponding anim drivers.

for layer_num in 0 to (LayerManager.count-1) do
(
	if ((findString (LayerManager.getLayer layer_num).name "_AnimDrv_")!=undefined) or ((findString (LayerManager.getLayer layer_num).name "_Smd_")!=undefined) then
		(
			-- get an array of sim objs
			cur_layer=(LayerManager.getLayer layer_num)
			cur_layer.ishidden=false
			cur_layer.select true
			unhide selection
			clearSelection()
		)
)

select $*Smd_

for cur_obj in selection do
(
cur_str=cur_obj.name
str_ary=filterString cur_str "_"
--str_part=substituteString (str_ary[str_ary.count]) "-Smd_" "_"
new_str=(substitutestring (substitutestring cur_str "_Cloth_" "_Mesh_") "-Smd_" "_")

if (getNodeByName new_str)!=undefined then hide (getNodeByName new_str)
else (unhide (getNodeByName new_str))
)