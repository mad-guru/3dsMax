------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- user defined variables
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
scene_str="sc02"
shot_str="sh0010"
root_path=@"d:\projects\pd\"

for cur_obj in selection do
(
	cur_obj.material=StandardMaterial()
	cur_obj.material.name=cur_obj.name
	cur_obj.material.selfIllumAmount = 100
	cur_obj.material.diffuseMap = CompositeTexturemap ()
	cur_obj.material[#Maps][4].mapEnabled.count = 2
	cur_obj.material[#Maps][4].layername[1] = "white"
	cur_obj.material[#Maps][4].layername[2] = "colormap"
	cur_obj.material[#Maps][4].mapList[1] = output ()
	cur_obj.material[#Maps][4].mapList[2] = Bitmaptexture fileName:(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\maps\completemap\"+cur_obj.name+"CompleteMap.tga")
	cur_obj.material[#Maps][4].Mask[2] = Bitmaptexture fileName:(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\maps\mask\"+cur_obj.name+"mask.tga")

	rm = renderMap cur_obj.material.diffuseMap size:[1024,1024] fileName:(root_path+@"shots\"+scene_str+@"\"+shot_str+@"\maps\comp\"+cur_obj.name+"CompleteMap.jpg")
	save rm
	close rm
)