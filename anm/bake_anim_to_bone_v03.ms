--bake all
--select simulated objects
--execute code below

obj_ary=selection as array

start_frame=(animationRange.start as integer)/160
end_frame=(animationRange.end as integer)/160

disableSceneRedraw()

for cur_obj in obj_ary do
(
	--create bone
	cur_bn=bone()
	
	-- name bone based off object name
	cur_bn.name=cur_obj.name+"_bn"
	cur_bn.transform=cur_obj.transform
	cur_bn.position=cur_obj.pivot
	
	-- animate bone to match cur_obj animation
	set animate on
	
	for cur_frame in start_frame to end_frame do
		(
			slidertime=cur_frame
			cur_bn.transform=cur_obj.transform
		)
	
	set animate off
)


slidertime=start_frame

for cur_obj in obj_ary do
(
deleteKeys cur_obj #allKeys

cur_obj.transform=(getNodeByName(cur_obj.name+"_bn")).transform
	
--parent cur_obj to cur_bn
cur_obj.parent=getNodeByName(cur_obj.name+"_bn")	
)

enableSceneRedraw()