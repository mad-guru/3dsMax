--create initial morph targets
-- merge morph targets for an existing character that most closely resembles the current one.
char_str="mlw"
ref_str="nmy"
cur_obj="_body"
--cur_obj="_tng"
--cur_obj="_eye"

char_obj=undefined
ref_obj=undefined

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


	addmodifier ref_obj (morpher ())

	--add char body as first morph target
	WM3_MC_BuildFromNode ref_obj.morpher 1 char_obj
	WM3_MC_SetValue ref_obj.morpher 1 100.0
		
	cur_num=1
---------------------------------------------------------------------------------
		---------------------------------------------------------------------------------
		---------------------------------------------------------------------------------
		---------------------------------------------------------------------------------
		---------------------------------------------------------------------------------
-- ran till here and then ran the rest to make it work...
---------------------------------------------------------------------------------
	for cur_mt in mt_ary do
		(
			
			cur_num+=1
			WM3_MC_BuildFromNode ref_obj.morpher cur_num cur_mt
			WM3_MC_SetValue ref_obj.morpher cur_num 100.0
			
			cur_trg_nm=(WM3_MC_GetName ref_obj.morpher cur_num)
			new_trg=snapshot ref_obj
			new_trg.name=(char_str+(substring cur_trg_nm 4 cur_trg_nm.count))
			--print (char_str+(substring cur_trg_nm 4 cur_trg_nm.count))
			WM3_MC_SetValue ref_obj.morpher cur_num 0.0
			print cur_num
		)