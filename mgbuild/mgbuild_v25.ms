struct mg_build
(
	-- for creating initial container from modeling file
	fn cr_cont=
		(
		cur_cont=Containers.CreateContainer #()

		str_ary=filterString (getFilenameFile maxfilename) "_"
		cur_cont.name=str_ary[1]+"_"+str_ary[2]+"_container"

		--cur_cont.sourceDefinitionFilename=cur_cont.name
		makeDir (maxFilePath+@"/containers/") all:true 
		cur_cont.localDefinitionFilename=(maxFilePath+@"/containers/"+cur_cont.name+".maxc")

		actionMan.executeAction 0 "40044"  -- Selection: Select Invert
		cur_objs=selection as array
		cur_cont.AddNodesToContent cur_objs

		cur_cont.SetAccessType #anythingUnlocked

		cur_cont.SetOpen false
		),
		
--cont_ary = getFiles "c:\\foo\\*.maxc"		
	fn cont_placer cont_ary =
		(
			cur_cont_source = cont_ary[(random 1 cont_ary.count)]

			cur_cont=Containers.CreateContainer #()
			cur_cont.sourceDefinitionFilename=cur_cont_source
			cur_cont.name=getFilenameFile cur_cont_source
			cur_cont
		),

	--creates pts based off the cur container type		
	fn cr_pts cur_cont=
		(
		--create shpa pts
		str_ary=filterString cur_cont.name "_"
			
		if (substring str_ary[2] (str_ary[2].count) str_ary[2].count)=="a" do
			(
				center_pt=point()
				center_pt.name=str_ary[1]+"_"+str_ary[2]+"_pt_c"
				center_pt.transform=(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0.104286,0,-0.0154648])

				cur_pt=point()
				cur_pt.name=str_ary[1]+"_"+str_ary[2]+"_pt_bd"
				cur_pt.transform=(matrix3 [1,0,0] [0,0,1] [0,-1,0] [84.6986,0,-0.0154648])
				cur_pt.parent=center_pt

				cur_pt=point()
				cur_pt.name=str_ary[1]+"_"+str_ary[2]+"_pt_tp"
				cur_pt.transform=(matrix3 [1,0,0] [0,0,1] [0,-1,0] [-87.3479,-7.03499e-006,160.926])
				cur_pt.parent=center_pt

				cur_pt=point()
				cur_pt.name=str_ary[1]+"_"+str_ary[2]+"_pt_td"
				cur_pt.transform=(matrix3 [1,0,0] [0,0,1] [0,-1,0] [84.6986,-7.03499e-006,160.926])
				cur_pt.parent=center_pt
				
				cur_pt=point()
				cur_pt.name=str_ary[1]+"_"+str_ary[2]+"_pt_bp"
				cur_pt.transform=(matrix3 [1,0,0] [0,0,1] [0,-1,0] [-87.3479,0,-0.0154648])
				center_pt.parent=cur_pt
		
				cur_cont.parent=cur_pt
			)
			
		if (substring str_ary[2] (str_ary[2].count) str_ary[2].count)=="b" do
			(
				center_pt=point()
				center_pt.name=str_ary[1]+"_"+str_ary[2]+"_pt_c"
				center_pt.transform=(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0.104286,0,-0.0154648])

				cur_pt=point()
				cur_pt.name=str_ary[1]+"_"+str_ary[2]+"_pt_bd"
				cur_pt.transform=(matrix3 [1,0,0] [0,0,1] [0,-1,0] [124.34,0,-0.0154648])
				cur_pt.parent=center_pt

				cur_pt=point()
				cur_pt.name=str_ary[1]+"_"+str_ary[2]+"_pt_tp"
				cur_pt.transform=(matrix3 [1,0,0] [0,0,1] [0,-1,0] [-124.86,-7.03499e-006,160.926])
				cur_pt.parent=center_pt

				cur_pt=point()
				cur_pt.name=str_ary[1]+"_"+str_ary[2]+"_pt_td"
				cur_pt.transform=(matrix3 [1,0,0] [0,0,1] [0,-1,0] [124.34,-7.03499e-006,160.926])
				cur_pt.parent=center_pt

				cur_pt=point()
				cur_pt.name=str_ary[1]+"_"+str_ary[2]+"_pt_bp"
				cur_pt.transform=(matrix3 [1,0,0] [0,0,1] [0,-1,0] [-124.86,0,-0.0154648])
				center_pt.parent=cur_pt
						
				cur_cont.parent=cur_pt
			)

		),

--prints trans for above script
fn print_trans=
		(
			for a in selection do
			(
				print ("cur_pt.name="+a.name)
				print "cur_pt.transform="
				print a.transform
			)
		),

--create path con
	fn path_con path_pt cur_path num do_flip=
		(
		path_pt.pos.controller = Path_Constraint ()
		if do_flip==true then
			(
				--turn flip on
				--needed to put buildings on opposite side of spline
				path_pt.pos.controller.axisFlip=true
			)
		path_pt.pos.controller.follow = on
		--needed to place building horizonal rather than vertical
		path_pt.pos.controller.allowUpsideDown=true
		path_pt.pos.controller.axis=0 --x axis
		--<boolean>appendTarget <node>target<float>weight 
		path_pt.pos.controller.appendTarget cur_path 0
		path_pt.pos.controller.setWeight 1 50
		
		if do_flip==true and num==1 then
			(
			--trying to rotate 180 so buildings are built on spline
			in coordsys local rotate path_pt (angleaxis -180.000 [0,0,1])
			--in coordsys local rotate path_pt (angleaxis 180.000 [1,0,0])
			)
		),

--align building to path
	fn path_align path_pt cur_obj prev_obj do_prev_obj ref_pt do_flip=
		(
			best_dist=100000000000
			start_perc=undefined;cur_perc=undefined;end_perc=undefined;by_num=undefined
			--seems to make no change for now
		--	if do_flip==true and num==1 then (start_perc=100;end_perc=0;by_num=-1)
		--	else (start_perc=0;end_perc=100;by_num=1)
			start_perc=0;end_perc=100;by_num=1
			
			best_perc=copy start_perc
			
			path_pt.pos.controller.PERCENT=copy start_perc
				
			if do_prev_obj != "no" do cur_obj.position=prev_obj.position
			
			--cycle through increase percent on path
			for cur_perc in start_perc to end_perc by by_num do
				(
				path_pt.pos.controller.PERCENT = cur_perc
				cur_dist=distance path_pt cur_obj
					
				if cur_dist<best_dist then 
					(
						best_dist=copy cur_dist
						best_perc=copy cur_perc
					)
				)

			path_pt.pos.controller.PERCENT = best_perc
				
			if do_prev_obj !="no" do
				(
				cur_obj.transform=path_pt.transform
				cur_obj.position=prev_obj.position
				)
		),

--build it..combines above fns.
	fn builder cont_ary cur_path ref_pt path_pt prev_obj num do_flip=
		(
		cur_cont=mg_build.cont_placer cont_ary

		--create points using fn
		mg_build.cr_pts cur_cont
			
		mg_build.path_con path_pt cur_path num do_flip
			
		cur_p=cur_cont.parent
			
		if prev_d==undefined then
		(
			prev_d=point()
			prev_d.name="prev_d_start"
			prev_d.transform=path_pt.transform
			--does nothing
			--rotate prev_d (angleaxis -180.000 [0,0,1])
		)
				
			
		--place container
		mg_build.path_align path_pt cur_p prev_d "" ref_pt do_flip

		--trying offf
		cur_p.parent=prev_d
	
		prev_d=cur_p.children[1].children[1]
		
		cur_d = cur_p.children[1].children[1]
			
		mg_build.path_align path_pt cur_d prev_d "no" ref_pt do_flip
		
		--deletes off path building
		--if do_flip==true and num==1 do delete cur_cont
		)
		
)
/*
cont_ary = getFiles @"C:\temp\projects\pd\models\env\shp\containers\*.maxc"
cur_path=$line001
--reset prev_d value 
prev_d=undefined
for num in 1 to 100 do mg_build.builder cont_ary cur_path
*/