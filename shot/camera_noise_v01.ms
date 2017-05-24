cur_cam=$

if cur_cam.pos.controller!=position_list() then cur_cam.pos.controller = position_list ()

cur_cam.pos.controller.Available.controller = Noise_position ()
cur_cam.pos.controller[2].seed=0
cur_cam.pos.controller[2].frequency = 0.05
cur_cam.pos.controller[2].fractal = true
cur_cam.pos.controller[2].roughness = 0.01
cur_cam.pos.controller[2].noise_strength=[0.02,0.03,0.01]

if cur_cam.rotation.controller!=position_list() then cur_cam.rotation.controller = rotation_list ()

cur_cam.rotation.controller = rotation_list ()
cur_cam.rotation.controller.Available.controller = Noise_rotation ()
cur_cam.rotation.controller[2].seed=0
cur_cam.rotation.controller[2].frequency = 0.01
cur_cam.rotation.controller[2].fractal = true
cur_cam.rotation.controller[2].roughness = 0.01
cur_cam.rotation.controller[2].noise_strength=[0.1,0.2,0.3]