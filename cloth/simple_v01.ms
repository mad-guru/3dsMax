--print wirecolor

for cur_obj in selection do (print ("$'"+cur_obj.name+"'.wirecolor="+(cur_obj.wirecolor as string)))

-- print meshlist for skinwrap modifier
	for cur_obj in $.modifiers[1].meshlist do print cur_obj.name
		
-- pc check file setup
actionMan.executeAction 0 "550"  -- Views: Viewport Visual Style Shaded
actionMan.executeAction 0 "40023"  -- Views: Viewport Configuration
actionMan.executeAction 0 "60010"  -- Render: Render SetUp...
--saveMaxFile "G:\Kraken2015\01_Shots\Sc002\S0011.00\Cloth\Celebrimbor_V01_01_pccheck.max"
actionMan.executeAction 0 "219"  -- Tools: Viewport Safeframes Toggle

--merge safe megaman

actionMan.executeAction 0 "40068"  -- Views: Camera View

--set to material color

select $*Sd1*

modPanel.addModToSelection (TurboSmooth ()) ui:on
	
select $*Sd2*

modPanel.addModToSelection (TurboSmooth ()) ui:on
	
--set iterations to 2

--select camera	
cam_name_ary=filterstring $.name "_"
frame_ary=filterstring cam_name_ary[3] "-"
animationRange=interval (frame_ary[1] as time) (frame_ary[2] as time)