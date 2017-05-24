
		for cur_targ in 1 to 99 do
		(
			cur_cam=undefined
			if cur_targ<12 and (mod cur_targ 2)!=0 do cur_cam=$Cam_eye_r
			if cur_targ<12 and (mod cur_targ 2)==0 do cur_cam=$Cam_eye_l
			
			if cur_targ>14 and (mod cur_targ 2)!=0 do cur_cam=$Cam_mth_r
			if cur_targ>14 and (mod cur_targ 2)==0 do cur_cam=$Cam_mth_l
			
			if cur_targ==13 and (mod cur_targ 2)!=0 do cur_cam=$Cam_mth_r
			if cur_targ==14 and (mod cur_targ 2)==0 do cur_cam=$Cam_mth_l

			if cur_targ==13 or cur_targ==15 or cur_targ==17 or cur_targ==21 or cur_targ==25 or cur_targ==29 or cur_targ==33 or cur_targ==35 or cur_targ==37 or cur_targ==45 do cur_cam=$Cam_mth_r_iso
			if cur_targ==14 or cur_targ==16 or cur_targ==18 or cur_targ==22 or cur_targ==26 or cur_targ==30 or cur_targ==34 or cur_targ==36 or cur_targ==38 or cur_targ==46 do cur_cam=$Cam_mth_l_iso
			if cur_targ==51 or cur_targ==53 do cur_cam=$Cam_eye_r
			if cur_targ==52 or cur_targ==54 do cur_cam=$Cam_eye_l

			if WM3_MC_HasData $nmy_body.modifiers[#Morpher] cur_targ==true and cur_cam!=undefined and cur_targ!=47 or cur_targ!=48 then
			(
				if (mod cur_targ 2)==0 then
				(
					WM3_MC_SetValue $nmy_body.modifiers[#Morpher] cur_targ 100.0
					WM3_MC_SetValue $nmy_body.modifiers[#Morpher] (cur_targ-1) 100.0
				)
				else
				(
					WM3_MC_SetValue $nmy_body.modifiers[#Morpher] cur_targ 100.0
					WM3_MC_SetValue $nmy_body.modifiers[#Morpher] (cur_targ+1) 100.0
				)
				
			render camera: cur_cam frame: 1 outputwidth: 300 outputsize:[300,300] outputfile:("c:\\temp\\"+(WM3_MC_GetName $nmy_body.modifiers[#Morpher] cur_targ) as string+".jpg") vfb:true

				if (mod cur_targ 2)==0 then
				(
					WM3_MC_SetValue $nmy_body.modifiers[#Morpher] cur_targ 0.0
					WM3_MC_SetValue $nmy_body.modifiers[#Morpher] (cur_targ-1) 0.0
				)
				else
				(
					WM3_MC_SetValue $nmy_body.modifiers[#Morpher] cur_targ 0.0
					WM3_MC_SetValue $nmy_body.modifiers[#Morpher] (cur_targ+1) 0.0
				)				
		)
		else
			(
			WM3_MC_SetValue $nmy_body.modifiers[#Morpher] cur_targ 100.0
			render camera: cur_cam frame: 1 outputwidth: 300 outputsize:[300,300] outputfile:("c:\\temp\\"+(WM3_MC_GetName $nmy_body.modifiers[#Morpher] cur_targ) as string+".jpg") vfb:true
			WM3_MC_SetValue $nmy_body.modifiers[#Morpher] cur_targ 0.0
			)
		
)