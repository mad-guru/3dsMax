setCommandPanelTaskMode #modify

for cur_obj in selection do
(
		cur_trg=getNodeByName (cur_obj.name+"_upd")
		--addModifier cur_trg (Turn_to_Poly ())
		maxOps.CollapseNode cur_trg off
	
		if classof cur_obj==Editable_Poly then
			(
			polyop.setVertSelection cur_trg (polyop.getVertSelection cur_obj)
			)

		if classof cur_obj==Editable_Mesh then
			(
			setVertSelection cur_trg (getVertSelection cur_obj)
			select cur_obj
			meshop.setUIParam cur_obj #SoftSel true
			meshop.setUIParam cur_obj #SSUseEDist true
			meshop.setUIParam cur_obj #SSEDist 1
				
			)
)


/*
-- set soft selection on and edge dist 1
setCommandPanelTaskMode #modify

for cur_obj in selection do (
select cur_obj
meshop.setUIParam cur_obj #SoftSel true
meshop.setUIParam cur_obj #SSUseEDist true
meshop.setUIParam cur_obj #SSEDist 1
)
*/