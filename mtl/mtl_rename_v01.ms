for cur_obj in selection do
(
	if cur_obj.material!=undefined then cur_obj.material.name=substituteString cur_obj.material.name "riz" "zfr" 
)