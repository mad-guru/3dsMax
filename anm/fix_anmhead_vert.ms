
cur_body= (getNodeByName (char_str+"_body")
select cur_body
subobjectLevel = 1
modPanel.setCurrentObject cur_body.modifiers[#Skin]
cur_body.modifiers[#Skin].filter_vertices = on
skinOps.SelectVertices cur_body.modifiers[#Skin] #{388..538, 540..903, 910, 916, 918..919, 923..1839, 1846..1848, 1852..1853, 1855, 1863..1867, 1869..1879, 1882..1885, 1892..1894, 1937..1991, 2005..2013, 2015, 2019..2026, 2464..2624, 2627..2996, 3003, 3011, 3013..3014, 3021..3023, 3026..3029, 3031, 3037..4013, 4018..4020, 4029..4036}
cur_body.modifiers[#Skin].effect = 0
skinOps.setWeight cur_body.modifiers[#Skin] 1