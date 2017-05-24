--copy scene file, rename to del.max, open 2nd max session with file. collapse all in del.max, then select objs and run. fix obj in other max session.
--polyop.getMapFace $ 1

for cur_obj in selection do
(
print cur_obj.name
meshop.getMapFace cur_obj 10 1
)