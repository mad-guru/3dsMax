--select objects in xref scene file, run script to create obj_pos_ary with obj name str and position. use this to rename objects in an existing scene to match, before merge replacing


--create obj_pos_ary in xref scene file
obj_pos_ary=#()
obj_name_ary=#()

for cur_obj in selection do
(
	--print ("(#(\""+cur_obj.name+"\","+(cur_obj.position as string)+")),")
	obj_name_ary[obj_name_ary.count+1]=cur_obj.name
	obj_pos_ary[obj_pos_ary.count+1]=cur_obj.position
)

--test_ary=#(#("win_grn_bar03",[-131.818,-85.1046,92.0207]))



--sort and rename objects in lighting file to match xref scene file
for cur_obj in selection do
(
cur_pos=cur_obj.position
cur_idx=findItem obj_pos_ary cur_pos
	
--print "renamed";print cur_obj.name;print"to"
	
if cur_idx!=0 then cur_obj.name=obj_name_ary[cur_idx]
else print (cur_obj.name+" has no match")
	
--print cur_obj.name
)