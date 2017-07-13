import blurdev
from Py3dsMax import mxs
# unhides Smd objects and hides their corresponding anim drivers, leaving rest of anim drivers visible.

def smdVis():

	for layerNum in range(mxs.LayerManager.count):
		curLayer = mxs.LayerManager.getLayer(layerNum)
		layerName = curLayer.name
		if "_AnimDrv_" in layerName or "_Smd_" in layerName:

			## get an array of sim objs
			curLayer.ishidden=False
			curLayer.select(True)
			mxs.unhide(mxs.selection)
			mxs.clearSelection()



	for cur_obj in mxs.objects:
		if cur_obj.name.endswith("Smd_"):
			new_str = cur_obj.name.replace("_Cloth_", "_Mesh_").replace("-Smd_", "_")
			newNode = mxs.getNodeByName(new_str)
			if newNode:
				mxs.hide(newNode)
			else:
				mxs.unhide(newNode)