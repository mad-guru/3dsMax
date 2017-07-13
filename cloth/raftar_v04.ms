cur_anm=$
--cur_sim=$

tool PointCreator
	(
	local p, createpoint

	fn createpoint = in coordsys grid p=point pos:gridPoint
		on mousePoint clickno do
			(
			if clickno == 1 then
				(
					first = intersectrayex cur_anm (mapScreenToWorldRay mouse.pos)
					
					if classof cur_anm == Editable_mesh then
						(
							xfm_pt=Point()
							xfm_pt.name="xfm_pt"
							xfm_pt.position.controller=attachment()
							xfm_pt.position.controller.node=cur_anm
							
							click_pos = intersectrayex cur_anm (mapScreenToWorldRay mouse.pos)
							cur_key= AttachCtrl.addNewKey xfm_pt.position.controller 0
							cur_key.face = (click_pos[2] - 1)
							cur_key.coord = [0.5,0.0]
							--createPoint()
						)
					else messagebox "Object needs to be an Editable Mesh"
				)
			)
	)
startTool PointCreator
	
start_pos_pt=Point()
start_pos_pt.name="start_pos_pt"

raftarNEG_pos_pt=Point()
raftarNEG_pos_pt.name="raftarNEG_pos_pt"

raftarPOS_pos_pt=Point()
raftarPOS_pos_pt.name="raftarPOS_pos_pt"
	
reduce_amt=.5

raftarNEG_pos_pt.position=xfm_pt.position
raftarPOS_pos_pt.position=xfm_pt.position
	
set animate on
for cur_time in animationRange.start to animationRange.end do
(
--xyz all 3 axis affected. remove '*-1' from each axis to not affect it
slidertime=cur_time
raftarNEG_pos_pt.pos=[(((cur_anm.pos[1])* (1 - reduce_amt))*-1),(((cur_anm.pos[2])* (1 - reduce_amt))*-1),(((cur_anm.pos[3])* (1 - reduce_amt))*-1)]
raftarPOS_pos_pt.pos=[(((cur_anm.pos[1])* (1 - reduce_amt))),(((cur_anm.pos[2])* (1 - reduce_amt))),(((cur_anm.pos[3])* (1 - reduce_amt)))]	
)
set animate off

slidertime=animationRange.start

start_pos_pt.position=xfm_pt.position
raftarNEG_pos_pt.position=xfm_pt.position	
raftarPOS_pos_pt.position=xfm_pt.position

--for animdrv in selectionsets["_Anim-Drv"] do (animdrv.parent = SlowMoHelper)	
	
deletekey raftarNEG_pos_pt.position.controller.keys 1
deletekey raftarPOS_pos_pt.position.controller.keys 1
--for animdrv in selectionsets["_Anim-Drv"] do (animdrv.parent = SlowMoHelper)	
cur_anm.parent=raftarNEG_pos_pt

--off
slidertime=animationRange.start
cur_anm.parent=undefined
cur_sim.parent=raftarPOS_pos_pt
--animatedparts to neg
--simmedparts to pos
--on
slidertime=animationRange.start
cur_anm.parent=raftarNEG_pos_pt
cur_sim.parent=undefined
