for cur_obj in selection do
(
	cur_obj.material=StandardMaterial()
	cur_obj.material.name=cur_obj.name
	cur_obj.material.selfIllumAmount = 100
	cur_obj.material.diffuseMap = Bitmaptexture fileName:(maxFilePath+cur_obj.name+"CompleteMap.tga")--("C:\Users\madguru\Documents\3dsMax\sceneassets\images\BARK5.jpg")
	cur_obj.material.diffuseMap.output.output_amount=3.0
	cur_obj.material.useSelfIllumColor = on
	cur_obj.material.selfillumMap = cur_obj.material.diffuseMap

)