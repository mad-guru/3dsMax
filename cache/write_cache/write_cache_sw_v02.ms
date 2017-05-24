cache_path = maxFilePath+@"cache\"
DOSCommand ("mkdir "+cache_path)
shot_start = -50
shot_end = 220
cache_comp="no"

for cur_obj in selection do
(
if cur_obj.modifiers[#Point_Cache_Binding]==undefined do (addmodifier cur_obj (Point_CacheSpacewarpModifier ()))
--addmodifier cur_obj (Point_Cache ())

cur_obj.modifiers[#Point_Cache_Binding].recordStart = shot_start
cur_obj.modifiers[#Point_Cache_Binding].recordEnd = shot_end

if cache_comp=="yes" then
(cur_obj.modifiers[#Point_Cache_Binding].filename = (cache_path+"cachecomp//"+cur_obj.name+".pc2"))
else
(cur_obj.modifiers[#Point_Cache_Binding].filename = (cache_path+cur_obj.name+".pc2"))

cacheOps.RecordCache cur_obj.modifiers[#Point_Cache_Binding]
)