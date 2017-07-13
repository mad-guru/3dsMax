					addnewkey myobj.rotation.controller (slidertime - 10)
					addnewkey myobj.rotation.controller (slidertime + 10)
					set animate on
					local rotobj = eulerangles 90 0 0
					rotate myobj rotobj
					set animate off
					try (myobj.position = (getvert SMBmysel 1 ))catch()
					local mycopy = snapshot SMBmysel name:("X_"+myEnt+"_X_X_skinsetuptrash")
					mycopy.backfacecull = off
					convertToPoly mycopy
					mycopy.position = SMBmysel.position	
					addmodifier SMBmysel (skin_morph())
					SMBmysel.modifiers[1].name = modifierName
						
					boneObject = getNodeByName boneName
					modPanel.setCurrentObject SMBmysel.modifiers[1]
					SMBmysel.modifiers[1].addbone(boneObject)
					SMBmysel.modifiers[1].selectbone (boneObject) ""
						
					hide myobj
					select mycopy
					mycopy.wirecolor = color 225 88 199
					mycopy.paintDeformSize = 3.0228
					mycopy.paintDeformvalue = 0.06
					mycopy.paintDeformSize = 3.0228
					NMcheck.text = "Edit Mode"
					
					--this is for the smd to Uptade as you edit the sculpt
					addmodifier SMBmysel (Morpher())
					WM3_MC_BuildFromNode SMBmysel.morpher 1 Mycopy
					SMBmysel.modifiers[1].Autoload_of_targets = 1
					WM3_MC_SetValue SMBmysel.Morpher 1 100.0
					hide SMBmysel