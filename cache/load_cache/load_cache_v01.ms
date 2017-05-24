cache_path = "h:\\robot\\shots\\sc02\\sh0050\\anm\\hair\\cache\\"
shot_start = 1
shot_end = 85

for cur_obj in selection do
(
if cur_obj.modifiers[#Point_Cache]==undefined do (addmodifier cur_obj (Point_Cache ()))
cur_obj.modifiers[#Point_Cache].start_time = shot_start
cur_obj.modifiers[#Point_Cache].end_time = shot_end
cur_obj.modifiers[#Point_Cache].time = shot_start
cur_obj.modifiers[#Point_Cache].cache_file = (cache_path+cur_obj.name+".pts")
cur_obj.modifiers[#Point_Cache].relativeOffset = off
)