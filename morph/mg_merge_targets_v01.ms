--mg_merge_targets

char_str="nmy"

--define vert arrays for character face
r_sel=#{1..377, 379..386, 403, 414, 417, 531..532, 537..539, 902..922, 1850..1864, 1866..1870, 1897..1936}
l_sel=#{2027..2040, 2042, 2044..2045, 2047, 2049..2050, 2052..2241, 2244..2302, 2304..2306, 2308..2321, 2323..2330, 2332..2354, 2356..2361, 2363..2381, 2383..2386, 2388..2438, 2440..2460, 2479, 2492, 2495, 2613, 2617..2618, 2623..2624, 2626, 2995..3017, 3019..3020, 3022..3029, 3031..3036, 4018..4019, 4021..4028}
mid_sel=#{378, 387, 1840..1845, 1849, 1865, 1880..1881, 1885..1891, 1895..1896, 1992..2004, 2014..2018, 2041, 2043, 2046, 2048, 2051, 2242..2243, 2303, 2307, 2322, 2331, 2355, 2362, 2382, 2387, 2439, 2452, 2461..2463, 2478, 2616, 2625, 3018, 3021, 3030, 4014..4017, 4020}

node_ary=#(
(getNodeByName (char_str+"_body_mt_01_25")),
(getNodeByName (char_str+"_body_mt_01_100")),
(getNodeByName (char_str+"_body_mt_03_100")),
(getNodeByName (char_str+"_body_mt_05_50")),
(getNodeByName (char_str+"_body_mt_05_100")),
(getNodeByName (char_str+"_body_mt_07_100")),
(getNodeByName (char_str+"_body_mt_09_100")),
(getNodeByName (char_str+"_body_mt_11_100")),
(getNodeByName (char_str+"_body_mt_13_75")),
(getNodeByName (char_str+"_body_mt_13_100")),
(getNodeByName (char_str+"_body_mt_15_100")),
(getNodeByName (char_str+"_body_mt_17_100")),
(getNodeByName (char_str+"_body_mt_19_100")),
(getNodeByName (char_str+"_body_mt_21_100")),
(getNodeByName (char_str+"_body_mt_23_100")),
(getNodeByName (char_str+"_body_mt_25_100")),
(getNodeByName (char_str+"_body_mt_27_100")),
(getNodeByName (char_str+"_body_mt_29_50")),
(getNodeByName (char_str+"_body_mt_29_75")),
(getNodeByName (char_str+"_body_mt_29_100")),
(getNodeByName (char_str+"_body_mt_31_100")),
(getNodeByName (char_str+"_body_mt_33_100")),
(getNodeByName (char_str+"_body_mt_35_50")),
(getNodeByName (char_str+"_body_mt_35_100")),
(getNodeByName (char_str+"_body_mt_37_100")),
(getNodeByName (char_str+"_body_mt_39_100")),
(getNodeByName (char_str+"_body_mt_41_100")),
(getNodeByName (char_str+"_body_mt_43_100")),
(getNodeByName (char_str+"_body_mt_45_100")),
(getNodeByName (char_str+"_body_mt_47_100")),
(getNodeByName (char_str+"_body_mt_51_100")),
(getNodeByName (char_str+"_body_mt_53_100"))
)

for cur_obj in node_ary do
(
	max modify mode
	
	if cur_obj!=undefined do
	(
		--based on cur_obj mt number, choose trg obj
		str_ary= filterString cur_obj.name "_"
		trg_num=(str_ary[4] as integer+1) as string
		if (trg_num as integer)<10 then trg_num="0"+trg_num

		cur_trg=getNodeByName(str_ary[1]+"_"+str_ary[2]+"_"+str_ary[3]+"_"+trg_num+"_"+str_ary[5])
		
		if cur_trg!=undefined then
		(
			convertToMesh cur_trg
			
			setVertSelection cur_trg l_sel
			
			addmodifier cur_obj (morpher ())
				
			select cur_obj
				
			WM3_MC_BuildFromNode cur_obj.morpher 1 cur_trg
			WM3_MC_SetUseVertexSel cur_obj.morpher 1 true
			WM3_MC_SetValue cur_obj.morpher 1 100.0

			collapsestack cur_obj
				
			delete cur_trg
		)
		else print ("undefined "+(str_ary[1]+"_"+str_ary[2]+"_"+str_ary[3]+"_"+trg_num+"_"+str_ary[5]))
	)
	max create mode
)