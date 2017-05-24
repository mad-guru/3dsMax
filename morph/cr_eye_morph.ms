--nmy_eye_mt_02_100
char_str="riz"
cur_obj=getNodeByName(char_str+"_eye_r")

cur_obj.material=undefined

trg_01=copy cur_obj
trg_01.name=char_str+"_eye_mt_01_100"

trg_02=copy cur_obj
trg_02.name=char_str+"_eye_mt_02_100"

--trg_01.EditablePoly.SetSelection #Vertex #{1..32, 385, 416, 482..545}
--scale trg_01.selectedVerts [180,180,180]
--scale 1 180
--scale 2 40



