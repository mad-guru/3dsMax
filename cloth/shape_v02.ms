-- start create setup --------------------------------------------------------------------------------------
cur_obj=$

--create point for joint
cur_pt=Point()
cur_pt.name=cur_obj.name+"_pt_frm"+((slidertime as integer) as string)
cur_pt.transform=cur_obj.transform
addnewkey cur_pt.rotation.controller (slidertime - 5)
addnewkey cur_pt.rotation.controller (slidertime + 5)
set animate on
rot_val = eulerangles 90 0 0
rotate cur_pt rot_val
set animate off
	
--create snapshot for morph target
cur_mt=snapshot cur_obj
cur_mt.name=cur_obj.name+"_mt_frm"+((slidertime as integer) as string)
convertToPoly cur_mt

hide cur_mt

addModifier cur_obj (Morpher ())
cur_obj.modifiers[#Morpher].Autoload_of_targets=1
WM3_MC_BuildFromNode cur_obj.modifiers[#Morpher] 1 cur_mt
WM3_MC_SetValue cur_obj.modifiers[#Morpher] 1 100.0
cur_obj.modifiers[#Morpher].name=cur_obj.modifiers[#Morpher].name+"_del"
select cur_mt
	
-- end create setup --------------------------------------------------------------------------------------

--sculpt	
	
--start done sculpting create Skin_Morph
deleteModifier cur_obj 1
				
addmodifier cur_obj (Skin_Morph())
cur_obj.modifiers[#Skin_Morph].skinMorphOps.addBone cur_pt
cur_obj.modifiers[#Skin_Morph].skinMorphOps.selectBone cur_pt ""
cur_obj.modifiers[#Skin_Morph].skinMorphOps.createMorph cur_pt	
cur_obj.modifiers[#Skin_Morph].skinMorphOps.setExternalNode cur_pt "Morph 0" cur_mt
select cur_pt

--end done sculpting create Skin_Morph


--sculpt
	
-- start update target -----------------------------------------------------------------------------------
--after sculpting, update target
cur_mt=$
str_ary=filterString cur_mt "_"
cur_obj=getNodeByName str_ary[1]
cur_obj.modifiers[#Skin_Morph].skinMorphOps.reloadTarget cur_mt "Morph 0"
-- end update target -----------------------------------------------------------------------------------
	
--continue sculpting, select mt
cur_mt=$
str_ary=filterString cur_mt "_"
cur_obj=getNodeByName str_ary[1]
	
addModifier cur_obj (Morpher ())
cur_obj.modifiers[#Morpher].Autoload_of_targets=1
WM3_MC_BuildFromNode cur_obj.modifiers[#Morpher] 1 cur_mt
WM3_MC_SetValue cur_obj.modifiers[#Morpher] 1 100.0
cur_obj.modifiers[#Morpher].name=cur_obj.modifiers[#Morpher].name+"_del"

--done sculpting
--delete temp morpher modifier	
	for m in cur_obj.modifiers do
		(
			if cur_obj.modifiers[m].name=="Morpher_del" do deleteModifier cur_obj m
		)