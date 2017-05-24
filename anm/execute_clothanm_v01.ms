
sim_cloth=$blkt_sim
rnd_cloth=$blkt_rnd
vert_ary=getVertSelection sim_cloth sim_cloth.modifiers[1]
start_time=1
end_time=100
skip_frame=3
cr_verts=true
bk_verts=false

cloth_anm.cloth_cr_bake_sel sim_cloth rnd_cloth vert_ary start_time end_time skip_frame cr_verts bk_verts


