-- GLOBAL CONSTANTS
-- SCALE things
SCALE = 3

-- catagories for items of ode - for identifing what things interact with other items

category_body = 1
category_tire = 2
category_world = 4
category_all = category_world + category_body + category_tire


-- Position of camera
pos_x   = 0
pos_y   = 5
pos_z   = 0

-- relative positon of camera to car
kx = 0
ky = 2
kz = 10

-- object table
objects = { }

-- global bouncyness, friction
geom_bounce = 0.5 -- default
geom_friction = 1/0 -- infinity
geom_erp = 0.2 -- default
geom_cfm = 0.01 -- default

max_angle = 20 -- max turn for car
-- Mouse coordinates - updated by do_point
mouse_x = 0
mouse_y = 0

----- Helper functions

--Add Dumbell
function add_dumbell()
    local left = add_ball("../data/blueball.obj")
    local right = add_ball("../data/blueball.obj")
    E.set_entity_position(left, -1.5, 8.0, -10.0) -- move a bit to the left
    E.set_entity_position(right, 1.5, 8.0, -10.0) -- move a bit to the right 
    -- join them as a slider
    E.set_entity_joint_type(left, right, E.joint_type_slider)
    -- set the axis
    E.set_entity_joint_attr(left, right, E.joint_attr_axis_1, 1, 0, 0)
    -- set min and max of the slider
    E.set_entity_joint_attr(left, right, E.joint_attr_lo_stop,2)
    E.set_entity_joint_attr(left, right, E.joint_attr_hi_stop,20)
    -- set ERP and CFM of joint
    E.set_entity_joint_attr(left, right, E.joint_attr_stop_erp, 0.50)
    E.set_entity_joint_attr(left, right, E.joint_attr_stop_cfm, 0.05)
end


--Add ramp
function add_ramp(x, y, z, a, r)
    local ramp = E.create_object("../data/pool2.obj")

    E.parent_entity(ramp, pivot)

    -- make it a box of diminsions 8x2x16
    E.set_entity_geom_type(ramp, E.geom_type_box, 8, 2, 16)
    -- is a world item interacts with all
    E.set_entity_geom_attr(ramp, E.geom_attr_category, category_world)
    E.set_entity_geom_attr(ramp, E.geom_attr_collider, category_all)
    -- position and angle ramp
    E.set_entity_position (ramp, x, y, z)
    E.set_entity_rotation (ramp, a, r, 0)
    table.insert(objects, ramp)
end

-- Add a ball
function add_ball(path)
    local object = E.create_object(path)
    E.parent_entity(object, pivot)
    E.set_entity_geom_type(object, E.geom_type_sphere, 1)
    E.set_entity_geom_attr(object, E.geom_attr_category, category_world)
    E.set_entity_geom_attr(object, E.geom_attr_collider, category_all)

    E.set_brush_image(E.get_mesh(object, 2), envmap, 1)
    E.set_brush_flags(E.get_mesh(object, 2), E.brush_flag_env_map_1, true)

-- set postion of ball 8 above plane and 10 units from where the camera is
    E.set_entity_position(object, 0.0, 8.0, -10.0)

    E.set_entity_rotation(object, math.random(-180, 180),
                                  math.random(-180, 180),
                                  math.random(-180, 180))


-- Make this a object which is under control of ode
    E.set_entity_body_type(object, true)

-- Make a sphere type with radius 1
    E.set_entity_geom_type(object, E.geom_type_sphere, 1)
-- Set this up as a "world type" item
    E.set_entity_geom_attr(object, E.geom_attr_category, category_world)
-- Interacts with all items
    E.set_entity_geom_attr(object, E.geom_attr_collider, category_all)

    table.insert(objects, object)

    return object
end

---- Event functions
-- keyboard
function do_keyboard(key, down)
    if down then
        if key == E.key_1 then
            add_ball("../data/ball.obj")
        end

        if key == E.key_F9 then
            add_dumbell()
        end

        if key == E.key_3 then
            change_erp(0.2)
        end
        if key == E.key_4 then
            change_erp(-0.2)
        end            
        if key == E.key_5 then
            change_cfm(0.01)
        end
       if key == E.key_6 then
            change_cfm(-0.01)
        end            
            
        if key == E.key_7 then -- increase bouncyness
            change_bounce(0.25)
        end
        if key == E.key_8 then -- decrease bouncyness
            change_bounce(-0.25)
        end
        if key == E.key_9 then -- increase friction
            change_friction(1)
        end
        if key == E.key_0 then -- decrease friction
            change_friction(-1)           
        end
        if key == E.key_up then -- change camera
            move_camera(0, -1, 0)
        end
        if key == E.key_down then
            move_camera(0, 1, 0)
        end
        if key == E.key_left then
            move_camera(-1, 0, 0)
        end
        if key == E.key_right then
            move_camera(1, 0, 0)
        end
        if key == E.key_d then
            move_camera(0, 0, -1)
        end
        if key == E.key_u then
            move_camera(0, 0, 1)
        end

        if key == E.key_2 then -- print
            E.print_console("Bounce: ", geom_bounce, "  Friction: ",geom_friction, "\n")
            E.print_console("ERP: ", geom_erp, "  CFM: ",geom_cfm, "\n")
        end
        return true
    end
    return false
end
-- Mouse movement
function do_point(dx, dy)
    mouse_x = mouse_x + dx
    mouse_y = mouse_y + dy
    return true
end

-- timer
function do_timer(dt)

        local mx = (mouse_x - 400)/400.0
        local my = (mouse_y - 300)/300.0
        --update_camera()

        local px, py, pz = E.get_entity_position(base)
        local xx, xy, xz = E.get_entity_x_vector(base)
        local yx, yy, yz = E.get_entity_y_vector(base)
        local zx, zy, zz = E.get_entity_z_vector(base)

        --local kx =  0
        --local ky =  2
        --local kz = 10

        local x = px + xx * kx + yx * ky + zx * kz
        local y = py + xy * ky + yy * ky + zy * ky
        local z = pz + xz * kx + yz * ky + zz * kz

        local d = math.sqrt((pos_x - px) * (pos_x - px) +
                            (pos_z - pz) * (pos_z - pz));

        local a = math.atan2(pos_x - px, pos_z - pz) * 180 / math.pi
        local k = 10

        pos_x = ((k - 1) * pos_x + x) / k
        pos_y = ((k - 1) * pos_y + y) / k
        pos_z = ((k - 1) * pos_z + z) / k

        pos_y = math.abs(pos_y)

        --E.set_entity_position(camera, SCALE * pos_x, SCALE * pos_y, SCALE * pos_z)
	E.set_entity_position(camera, 0, 160, 0)
        E.set_entity_rotation(camera, -90, 90, 0)
end

-- main setup
function do_start()

    -- Set up background
    E.set_background(0.8, 0.8, 1.0, 0.2, 0.4, 1.0)

    -- Set up camera and position
    camera = E.create_camera(E.camera_type_perspective)
    E.set_entity_position(camera, SCALE * pos_x, SCALE * pos_y, SCALE * pos_z)
   
    -- Set up light
    light  = E.create_light(E.light_type_positional)
	E.set_entity_position(light, 0, 50, 0);

    -- Set up item to hang things off of for scaling
    pivot  = E.create_pivot()

    -- Obtain objects for enviornment
    sky    = E.create_object("../data/sky.obj")

    plane = E.create_object("../data/checker.obj")
    envmap = E.create_image("../data/sky_nx.png",
                            "../data/sky_px.png",
                            "../data/sky_ny.png",
                            "../data/sky_py.png",
                            "../data/sky_nz.png",
                            "../data/sky_pz.png")

    -- view of camera
    E.set_camera_range(camera, 1, 10000)

    -- relationships
    E.parent_entity(light, camera)
    E.parent_entity(pivot, light)
    E.parent_entity(plane, pivot)
    E.parent_entity(sky,   plane)

    -- set up plane as plane with normal in y direction
    E.set_entity_geom_type(plane, E.geom_type_plane, 0, 1, 0, 0)
    -- interacts with all items - part of world
    E.set_entity_geom_attr(plane, E.geom_attr_category, category_world)
    E.set_entity_geom_attr(plane, E.geom_attr_collider, category_all)

    table.insert(objects, plane)
    -- locate light
    E.set_entity_position(light, 0.0, 48.0, 32.0)

    -- Scale items
    E.set_entity_scale   (pivot,  SCALE,  SCALE,  SCALE)
    E.set_entity_scale   (plane, 32, 32, 32)
    E.set_entity_scale   (sky, 8, 8, 8)

    -- Set up sky
    E.set_brush_image(E.get_mesh(sky, 0), envmap)
    E.set_brush_flags(E.get_mesh(sky, 0), E.brush_flag_unlit,     true)
    E.set_brush_flags(E.get_mesh(sky, 0), E.brush_flag_sky_map_0, true)
    

    -- tell user how to toggle console and exit
    E.print_console("Type F1 to toggle this console -- F2 to toggle full screen\n")
    E.print_console("Type up/down/left/right to move camera\n")
    E.print_console("Type 1 to add spheres\n")
    E.print_console("Type F9 to add dumbells\n")
    E.print_console("Type 2 to see values\n")
    E.print_console("Type escape to exit this program\n")

    add_ramp(0, 0, -5, 10, 0)

    E.enable_timer(true)
    
end

do_start()

