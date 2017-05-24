/*
for a in selection do
(
	print ("execute(\"$\"+char_str+\""+(substring a.name 4 a.name.count)+".pos.controller[2].controller.value="+(a.pos.controller[2].controller.value)as string+"\")")
)
*/

char_str="nmy"

VisemeFloater = newRolloutFloater "Visemes Floater" 200 400

rollout VisemeRollout "Visemes";-- width:187 height:223
(
	button aa_h "aa_h" pos:[8,10] width:80 height:30 toolTip:"aa_h"
	button b_pp_m "b_pp_m" pos:[10,45] width:80 height:30 toolTip:"b_pp_m"
	button s_z "s_z" pos:[10,80] width:80 height:30 toolTip:"s_z"
	button j_ch_zsh_sh "j_ch_zsh_sh" pos:[10,115] width:80 height:30 toolTip:"j_ch_zsh_sh"
	button f "f" pos:[10,150] width:80 height:30 toolTip:"f"
	button w_oo "w_oo" pos:[95,10] width:80 height:30 toolTip:"w_oo"
	button t_d "t_d" pos:[95,45] width:80 height:30 toolTip:"t_d"
	button tt_dd_r_rr_n "tt_dd_r_rr_l_n" pos:[95,80] width:80 height:30 toolTip:"tt_dd_r_rr_l_n"
	button kh_gh_q_k_g "kh_gh_q_k_g" pos:[95,115] width:80 height:30 toolTip:"kh_gh_q_k_g"
	button ee_ae_aen "ee_ae_aen" pos:[95,150] width:80 height:30 toolTip:"ee_ae_aen"
	button ll "ll" pos:[10,185] width:80 height:30 toolTip:"ll"
	button th "th" pos:[95,185] width:80 height:30 toolTip:"th"
	button default "default" pos:[50,220] width:80 height:30 toolTip:"default"
	spinner jawz "jawz" range:[-6.5,20,0] type:#float scale:0.1 fieldWidth:40 toolTip:"jawz" controller:(execute("$"+char_str+"_s_skel_jaw01_rot.rotation.controller[2][3]")) setKeyBrackets:on align:#center
	spinner jawy "jawy" range:[-20,20,0] type:#float scale:0.1 fieldWidth:40 toolTip:"jawy" controller:(execute("$"+char_str+"_s_skel_jaw01_rot.rotation.controller[2][2]")) setKeyBrackets:on align:#center
	spinner tng1 "TH" range:[0,100,0] type:#float scale:0.1 fieldWidth:40 toolTip:"tng_th" controller:(execute("$"+char_str+"_tng.morpher[1].controller")) setKeyBrackets:on align:#left
	spinner tng2 "TT" range:[0,100,0] type:#float scale:0.1 fieldWidth:40 toolTip:"tng_tt" controller:(execute("$"+char_str+"_tng.morpher[2].controller")) setKeyBrackets:on align:#left
	spinner tng3 "LL" range:[0,100,0] type:#float scale:0.1 fieldWidth:40 toolTip:"tng_ll" controller:(execute("$"+char_str+"_tng.morpher[3].controller")) setKeyBrackets:on align:#left
	spinner tng4 "KHGH" range:[0,100,0] type:#float scale:0.1 fieldWidth:40 toolTip:"tng_khgh" controller:(execute("$"+char_str+"_tng.morpher[4].controller")) setKeyBrackets:on align:#left
	spinner tng5 "?" range:[0,100,0] type:#float scale:0.1 fieldWidth:40 toolTip:"??" controller:(execute("$"+char_str+"_tng.morpher[5].controller")) setKeyBrackets:on align:#left
	spinner tng6 "?" range:[0,100,0] type:#float scale:0.1 fieldWidth:40 toolTip:"??" controller:(execute("$"+char_str+"_tng.morpher[6].controller")) setKeyBrackets:on align:#left
	spinner tng7 "?" range:[0,100,0] type:#float scale:0.1 fieldWidth:40 toolTip:"??" controller:(execute("$"+char_str+"_tng.morpher[7].controller")) setKeyBrackets:on align:#left
	spinner tng8 "?" range:[0,100,0] type:#float scale:0.1 fieldWidth:40 toolTip:"??" controller:(execute("$"+char_str+"_tng.morpher[8].controller")) setKeyBrackets:on align:#left
	spinner tng9 "?" range:[0,100,0] type:#float scale:0.1 fieldWidth:40 toolTip:"??" controller:(execute("$"+char_str+"_tng.morpher[9].controller")) setKeyBrackets:on align:#left
	spinner tng10 "?" range:[0,100,0] type:#float scale:0.1 fieldWidth:40 toolTip:"??" controller:(execute("$"+char_str+"_tng.morpher[10].controller")) setKeyBrackets:on align:#left

	on aa_h pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,0.384931,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,0.760418,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,0.760418,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,-0.210231,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,-0.210232,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[0.371153,1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[-0.504028,-1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,-4.76837e-007,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,0.384931,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,0.381985,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,0.381985,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=0")		
	)

	on b_pp_m pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,-0.509821,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,-0.509821,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,0.531887,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,0.531887,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[0,1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[0,-1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,0.535674,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,0.535673,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=0")	
	)

	on s_z pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,0.677507,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,0.677507,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[0.371153,1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[-0.441041,-1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,-4.76837e-007,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,0.827193,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,0.827193,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=0")	
	)

	on j_ch_zsh_sh pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,-0.28706,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,-0.28706,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,-0.581291,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,-0.581291,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[-0.519296,1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[0.597816,-1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,-4.76837e-007,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,0.678895,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,0.678895,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=0")		
	)

	on f pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,-0.212911,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,-0.212911,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0.81369,0.0866787,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[-0.957783,0.0866783,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[0,1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[0,-1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,-4.76837e-007,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=0")		
	)

	on w_oo pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,-1.66893e-006,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,-1.66893e-006,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[0.67467,-1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[-0.5859,1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,-4.76837e-007,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=0")		
	)

	on t_d pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,0.603358,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,0.529208,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[0.296948,1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[-0.218429,-1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,-4.76837e-007,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,-0.285672,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,-0.285672,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=0")		
	)

	on tt_dd_r_rr_n pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,0.603358,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,0.529208,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[0.593071,1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[-0.510455,-1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,-4.76837e-007,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,0.690785,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,0.690785,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=100")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=0")		
	)

	on kh_gh_q_k_g pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,0.455059,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,0.455059,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,0.234977,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,0.234977,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[0,1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[0,-1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,-4.76837e-007,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,0.753044,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,0.753044,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=100")
	)

	on ee_ae_aen pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,0.455059,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,0.455059,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,0.234977,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,0.234977,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[0.742173,1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[-0.584453,-1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,-4.76837e-007,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,0.753044,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,0.753044,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=0")		
	)

	on ll pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,-1.66893e-006,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,-1.66893e-006,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[0.593765,1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[-0.589449,-1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,-4.76837e-007,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,1.05965,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,1.05965,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=100")
execute("$"+char_str+"_tng.morpher[4].controller.value=0")		
	)

		on th pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,-1.66893e-006,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,-1.66893e-006,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,-1.43051e-006,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[-0.446613,1.90735e-006,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[0.603637,-1.90735e-006,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,-4.76837e-007,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,-9.53674e-007,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,-2.38419e-007,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,-0.193376,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,-0.193376,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=100")
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=0")		
	)
	
	on default pressed do 
	(
execute("$"+char_str+"_fc_nostril_l.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_fc_uplip_l.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_fc_uplip_r.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_fc_lowlip_l.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_fc_lowlip_r.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_fc_lipO_l.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_fc_lipO_r.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_fc_chin_l.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_fc_chin_r.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_fc_nostril_r.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_fc_lpcrnr_l.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_fc_lpcrnr_r.pos.controller[2].controller.value=[0,0,0]")
execute("$"+char_str+"_tng.morpher[1].controller.value=0")	
execute("$"+char_str+"_tng.morpher[2].controller.value=0")		
execute("$"+char_str+"_tng.morpher[3].controller.value=0")	
execute("$"+char_str+"_tng.morpher[4].controller.value=0")		
	)

)

addRollout VisemeRollout VisemeFloater 