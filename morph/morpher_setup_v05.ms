--fn_morph_add "riz" "*mt*" "body" false
--fn_morph_add "nmy" "*mt*" "tongue" false
fn fn_morph_add char_str nm_str mbase_str vertsel=
(	
	execute ("mstr_ary=$"+char_str+nm_str)

	cur_obj=execute ("$"+char_str+"_"+mbase_str)

	if cur_obj.modifiers[#Morpher]==undefined do addmodifier cur_obj (morpher ())

	--if cur_obj.morpher==undefined do addmodifier cur_obj (morpher ())
		
		for cur_targ in mstr_ary do
		(
				--ary=filterString "string" "div"
				targ_ary=filterString cur_targ.name "_"
			
				if targ_ary[targ_ary.count]=="100" do
				(
				cur_trg_num=targ_ary[targ_ary.count-1] as integer
				WM3_MC_BuildFromNode cur_obj.morpher cur_trg_num cur_targ
				WM3_MC_SetUseVertexSel cur_obj.morpher cur_trg_num vertsel
				)
		)

	for cur_targ in mstr_ary do
	(
		--ary=filterString "string" "div"
		targ_ary=filterString cur_targ.name "_"
		
		if targ_ary[targ_ary.count]!="100" do
			(
			cur_trg_num=targ_ary[targ_ary.count-1] as integer

				--print (substring cur_targ.name (5+char_str.count) (cur_targ.name.count))
			cur_trg_prog=targ_ary[targ_ary.count] as float
			cur_trg_100 = execute("$"+(substring cur_targ.name 1 (cur_targ.name.count-2)+"100"))
			WM3_AddProgressiveMorphNode cur_obj.morpher cur_trg_num cur_targ
			WM3_SetProgressiveMorphWeight cur_obj.morpher cur_trg_num cur_targ cur_trg_prog
			WM3_SetProgressiveMorphWeight cur_obj.morpher cur_trg_num cur_trg_100 100.0
			)
	)
)