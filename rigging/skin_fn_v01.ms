--print a list of bones used in an object's skin mod
fn skin_print_bn_list cur_obj= (
for cur_bn in 1 to (skinOps.GetNumberBones cur_obj.modifiers[#Skin]) do
(print (skinOps.GetBoneName cur_obj.modifiers[#Skin] cur_bn 0))
)
skin_print_bn_list $

