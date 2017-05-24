filein @"c:\temp\projects\pd\scripts\mgbuild\mgbuild_v25.ms"

cont_ary = getFiles @"C:\temp\projects\pd\models\env\shp\containers\*.maxc"
path_ary=selection as array
do_flip=true

for cur_path in path_ary do
(
	--reset prev_d value 
	prev_d=undefined
	
	if do_flip==true then
		(
		--reverse spline
		reverse cur_path 1
		)

	path_pt=point()
	path_pt.name="path_pt_"+cur_path.name

	cur_segs= numSegments cur_path 1
	cur_knots=numKnots cur_path 1
	spl_end_pt=getKnotPoint cur_path 1 cur_knots
	
	ref_pt=point()
	ref_pt.name="ref_pt"+cur_path.name
		
	path_pt.position=getKnotPoint cur_path 1 1
	ref_pt.position=spl_end_pt

	for num in 1 to 50 while ((distance path_pt ref_pt)>150) do mg_build.builder cont_ary cur_path ref_pt path_pt prev_d num do_flip
	
	if do_flip==true then
		(
		--reverse spline
		reverse cur_path 1
		)
)
