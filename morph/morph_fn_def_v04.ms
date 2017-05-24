struct mg_morph
(
	--create initial morph targets
fn cr_intial_mt root_path char_str ref_str cur_obj=
	(	
	--char_obj=undefined
	--ref_obj=undefined

	if cur_obj!="_eye" then
	(
	char_obj=getNodeByName(char_str+cur_obj)
	ref_obj=getNodeByName(ref_str+cur_obj)
	)
	else
	(
	char_obj=getNodeByName(char_str+cur_obj+"_r")
	ref_obj=getNodeByName(ref_str+cur_obj+"_r")
	)

	execute ("mt_ary=$"+ref_str+cur_obj+"*mt*")
setCommandPanelTaskMode #modify
	collapseStack ref_obj
	addmodifier ref_obj (morpher ())

	--add char body as first morph target
	WM3_MC_BuildFromNode ref_obj.morpher 1 char_obj
	WM3_MC_SetValue ref_obj.morpher 1 100.0
		
	cur_num=1

		
	for cur_mt in mt_ary do
		(
	WM3_MC_BuildFromNode ref_obj.morpher 1 char_obj
	WM3_MC_SetValue ref_obj.morpher 1 100.0			
			cur_num+=1
			WM3_MC_BuildFromNode ref_obj.morpher cur_num cur_mt
			WM3_MC_SetValue ref_obj.morpher cur_num 100.0
			
			cur_trg_nm=(WM3_MC_GetName ref_obj.morpher cur_num)
			new_trg=snapshot ref_obj
			new_trg.name=(char_str+(substring cur_trg_nm 4 cur_trg_nm.count))
			--print (char_str+(substring cur_trg_nm 4 cur_trg_nm.count))
			WM3_MC_SetValue ref_obj.morpher cur_num 0.0
			--print cur_num
		)
setCommandPanelTaskMode #create
		
	),
	
	fn cr_split_morph char_str=
	(
		--this script takes a morph target and splits it into a right and left side morph
			setCommandPanelTaskMode #modify

			--define vert arrays for character face
			r_sel=#{1..377, 379..386, 403, 414, 417, 531..532, 537..539, 902..922, 1850..1864, 1866..1870, 1897..1936}
			l_sel=#{2027..2040, 2042, 2044..2045, 2047, 2049..2050, 2052..2241, 2244..2302, 2304..2306, 2308..2321, 2323..2330, 2332..2354, 2356..2361, 2363..2381, 2383..2386, 2388..2438, 2440..2460, 2479, 2492, 2495, 2613, 2617..2618, 2623..2624, 2626, 2995..3017, 3019..3020, 3022..3029, 3031..3036, 4018..4019, 4021..4028}
			mid_sel=#{378, 387, 1840..1845, 1849, 1865, 1880..1881, 1885..1891, 1895..1896, 1992..2004, 2014..2018, 2041, 2043, 2046, 2048, 2051, 2242..2243, 2303, 2307, 2322, 2331, 2355, 2362, 2382, 2387, 2439, 2452, 2461..2463, 2478, 2616, 2625, 3018, 3021, 3030, 4014..4017, 4020}

			if (getNodeByName (char_str+"_body_mt_05_15"))!=undefined then
			(
			cur_copy=copy (getNodeByName (char_str+"_body_mt_05_15"))
			cur_copy.name= (char_str+"_body_mt_11_15")
			cur_copy=copy (getNodeByName (char_str+"_body_mt_05_50"))
			cur_copy.name= (char_str+"_body_mt_11_50")
			)

			sel_ary=#(
			getNodeByName (char_str+"_body_mt_01_25"),
			getNodeByName (char_str+"_body_mt_01_100"),
			getNodeByName (char_str+"_body_mt_03_100"),
			getNodeByName (char_str+"_body_mt_05_100"),
			getNodeByName (char_str+"_body_mt_05_75"),
			getNodeByName (char_str+"_body_mt_05_50"),
			getNodeByName (char_str+"_body_mt_05_15"),
			getNodeByName (char_str+"_body_mt_07_100"),
			getNodeByName (char_str+"_body_mt_09_100"),
			getNodeByName (char_str+"_body_mt_11_15"),
			getNodeByName (char_str+"_body_mt_11_50"),
			getNodeByName (char_str+"_body_mt_11_100"),
			getNodeByName (char_str+"_body_mt_13_75"),
			getNodeByName (char_str+"_body_mt_13_100"),
			getNodeByName (char_str+"_body_mt_15_100"),
			getNodeByName (char_str+"_body_mt_17_100"),
			getNodeByName (char_str+"_body_mt_19_100"),
			getNodeByName (char_str+"_body_mt_21_100"),
			getNodeByName (char_str+"_body_mt_23_100"),
			getNodeByName (char_str+"_body_mt_25_100"),
			getNodeByName (char_str+"_body_mt_27_100"),
			getNodeByName (char_str+"_body_mt_29_50"),
			getNodeByName (char_str+"_body_mt_29_75"),
			getNodeByName (char_str+"_body_mt_29_100"),
			getNodeByName (char_str+"_body_mt_31_100"),
			getNodeByName (char_str+"_body_mt_33_100"),
			getNodeByName (char_str+"_body_mt_35_50"),
			getNodeByName (char_str+"_body_mt_35_100"),
			getNodeByName (char_str+"_body_mt_37_100"),
			getNodeByName (char_str+"_body_mt_39_100"),
			getNodeByName (char_str+"_body_mt_41_100"),
			getNodeByName (char_str+"_body_mt_43_100"),
			getNodeByName (char_str+"_body_mt_45_100"),
			getNodeByName (char_str+"_body_mt_51_100"),
			getNodeByName (char_str+"_body_mt_53_100"))

			orig_base=getNodeByName (char_str+"_body")

			--odd
			source_target=undefined

			--delete modifiers for body
			if orig_base!=undefined and orig_base.modifiers.count>0 then
				(
					select orig_base
					setCommandPanelTaskMode #modify
					
					for cur_mod in 1 to orig_base.modifiers.count do
					(
						deleteModifier orig_base 1
					)
				)
				
			for source_target in sel_ary do
			(
				if source_target!=undefined then
				(
					--even
					targ_ary=filterString source_target.name "_"
					targetb_num=((targ_ary[4] as integer) +1) as string
					if (targetb_num as integer)<10 then targetb_num="0"+targetb_num

					source_targetb_name=(char_str+"_body_mt_"+targetb_num+"_"+targ_ary[5])

					--copy source_target
					tmp_mt=copy source_target

					select source_target
					--morph source_target to orig_base
					addmodifier source_target (morpher ())
					WM3_MC_BuildFromNode source_target.morpher 1 orig_base
					WM3_MC_SetValue source_target.morpher 1 100.0
					collapseStack source_target

					source_targetb=undefined
						
					if getNodeByName source_targetb_name ==undefined then
						(
							source_targetb=copy source_target	
						)
						else
						(
							source_targetb=getNodebyName source_targetb_name
							unhide source_targetb
						)
					
					source_targetb.name=source_targetb_name
						
					select source_targetb
					--morph source_targetb to orig_base
					addmodifier source_targetb (morpher ())
					WM3_MC_BuildFromNode source_targetb.morpher 1 orig_base
					WM3_MC_SetValue source_targetb.morpher 1 100.0
					collapseStack source_targetb

					select source_target	
					--source_target morph
					setVertSelection tmp_mt r_sel
					addmodifier source_target (morpher ())
					WM3_MC_BuildFromNode source_target.morpher 1 tmp_mt
					WM3_MC_SetUseVertexSel source_target.morpher 1 true
					WM3_MC_SetValue source_target.morpher 1 100.0
					collapseStack source_target

					setVertSelection tmp_mt mid_sel
					addmodifier source_target (morpher ())
					WM3_MC_BuildFromNode source_target.morpher 1 tmp_mt
					WM3_MC_SetUseVertexSel source_target.morpher 1 true
					WM3_MC_SetValue source_target.morpher 1 50.0
					collapseStack source_target

					select source_targetb
					--source_targetb morph
					setVertSelection tmp_mt l_sel
					addmodifier source_targetb (morpher ())
					WM3_MC_BuildFromNode source_targetb.morpher 1 tmp_mt
					WM3_MC_SetUseVertexSel source_targetb.morpher 1 true
					WM3_MC_SetValue source_targetb.morpher 1 100.0
					collapseStack source_targetb

					setVertSelection tmp_mt mid_sel
					addmodifier source_targetb (morpher ())	
					WM3_MC_BuildFromNode source_targetb.morpher 1 tmp_mt
					WM3_MC_SetUseVertexSel source_targetb.morpher 1 true
					WM3_MC_SetValue source_targetb.morpher 1 50.0
					collapseStack source_targetb

					delete tmp_mt
				)
			)
			
			if (getNodeByName(char_str+"_body_mt_47_100"))!=undefined do
				(
				if (getNodeByName(char_str+"_body_mt_48_100"))==undefined do
						(
							cur_trg=(getNodeByName(char_str+"_body_mt_47_100"))
								
							new_trg=copy (getNodeByName(char_str+"_body"))
							new_trg.name= (char_str+"_body_mt_48_100")
								
							tmp_obj=copy (getNodeByName(char_str+"_body"))
							collapseStack tmp_obj
								
							addModifier tmp_obj (morpher())
							--add cur_trg as target set to 0
							WM3_MC_BuildFromNode tmp_obj.morpher 1 cur_trg
							WM3_MC_SetValue tmp_obj.morpher 1 0.0
								
							addModifier tmp_obj (mirror ())
							tmp_obj.modifiers[#Mirror].mirror_axis = 0
								
							addModifier new_trg (skin_Wrap ())
							new_trg.modifiers[#Skin_Wrap].engine = 0
							new_trg.modifiers[#Skin_Wrap].meshList=#(tmp_obj)
							
							WM3_MC_SetValue tmp_obj.morpher 1 100.0
								
							collapseStack new_trg
							
							delete tmp_obj
								
						)
				)
	
	)
	
)
--End Struct Def