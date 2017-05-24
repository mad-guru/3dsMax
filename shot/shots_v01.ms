rollout unnamedRollout "Untitled" width:133 height:241
(
	checkbox chk1 "rnd rig" pos:[9,158] width:142 height:18
	button btn1 "define variables" pos:[18,61] width:99 height:27
	dropDownList ddl1 "char" pos:[12,6] width:51 height:40 items:#("riz", "nmy")
	dropDownList ddl2 "rig type" pos:[69,6] width:51 height:40 items:#("rnd", "anm", "cloth")
	checkbox chk2 "cloth rig" pos:[9,135] width:142 height:18
	checkbox chk3 "anm rig" pos:[10,109] width:142 height:18
	checkbox chk4 "upd cloth" pos:[9,181] width:142 height:18
	checkbox chk5 "upd scene" pos:[9,206] width:142 height:18
	on ddl1 selected sel do
		(char_str=ddl1.selection)
	on ddl2 selected sel do
		(rig_type=ddl2.selection)
)