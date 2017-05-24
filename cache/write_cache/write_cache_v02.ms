cache_path = "h:\\robot\\shots\\sc02\\sh0050\\anm\\hair\\cache\\"
shot_start = 1
shot_end = 85

for cur_obj in selection do
(
if cur_obj.modifiers[#Point_Cache]==undefined do (addmodifier cur_obj (Point_Cache ()))
cur_obj.modifiers[#Point_Cache].recordStart = shot_start
cur_obj.modifiers[#Point_Cache].recordEnd = shot_end

cur_obj.modifiers[#Point_Cache].filename = (cache_path+cur_obj.name+".pts")
cur_obj.modifiers[#Point_Cache].Record ()
)