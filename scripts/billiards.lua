SCALE = 3
-- Position of camera
pos_x = 0
pos_y = 120
pos_z = 0
-- Rotation of camera
rot_x = -90
rot_y = 0
rot_z = 0

objects = { }

geom_bounce = 0.8 -- default
geom_friction = 1/0 -- infinity
geom_erp = 0.0 -- default .2
geom_cfm = 0.00 -- default
ball_mass = 100

wall_bounce = 0
wall_friction = 1/0
wall_erp = 0.0
wall_cfm = 0.0

mouse_x = 0
mouse_y = 0
category_world = 4
category_all = category_world

slate_width = 10.0
slate_height = 1.0
slate_length = 5.0

global_scale_value = 1.5
ball_scale_value = .5

brush_count = 0;

--for the balls
radius = .50
hval = ((2*radius)/1.41)+.18
dotOffset = 7.5
yval = .5

force_scale = 500

-- Add a ball
function add_ball(red, green, blue, striped)
	local path = "../data/ball.obj"
	local object = E.create_object(path)
	E.parent_entity(object, pivot)
	--E.set_entity_geom_type(object, E.geom_type_sphere, 0.7)
	--E.set_entity_geom_attr(object, E.geom_attr_category, category_world)
	--E.set_entity_geom_attr(object, E.geom_attr_collider, category_all)
	local brush = E.create_brush()
	--local color = math.floor(brush_count/2)
	E.set_brush_color(brush, red, green, blue, 1)
	E.set_mesh(object, 0, brush)
	if striped == 0 then
		E.set_mesh(object, 1, brush)
	end
	brush_count=brush_count+1
	E.set_brush_image(E.get_mesh(object, 2), envmap, 1)
	E.set_brush_flags(E.get_mesh(object, 2), E.brush_flag_env_map_1, true)

	E.set_entity_position(object, 0, 1.0, 2)
	E.set_entity_scale(object, ball_scale_value, ball_scale_value, ball_scale_value)
	E.set_entity_rotation(object, math.random(-180, 180),
                                  math.random(-180, 180),
                                  math.random(-180, 180))
	E.set_entity_body_type(object, true)
	E.set_entity_geom_type(object, E.geom_type_sphere, 0.5)
	E.set_entity_geom_attr(object, E.geom_attr_category, category_world)
	E.set_entity_geom_attr(object, E.geom_attr_collider, category_all)
	E.set_entity_geom_attr(object, E.geom_attr_friction, geom_friction)
	E.set_entity_geom_attr(object, E.geom_attr_mass, ball_mass)
	E.set_entity_geom_attr(object, E.geom_attr_bounce, geom_bounce)
	E.set_entity_geom_attr(object, E.geom_attr_soft_erp, geom_erp)
	E.set_entity_geom_attr(object, E.geom_attr_soft_cfm, geom_cfm)
	table.insert(objects, object)
	return object
end
function get_offset(dist)
	return (-1*dotOffset)-(dist*hval)
end
function set_ball_positions()
	E.set_entity_position(cue, dotOffset, yval, 0)


	E.set_entity_position(yellow_stripe, get_offset(0), yval, 0)
	E.set_entity_position(brown, get_offset(1), yval, radius)
	E.set_entity_position(blue_stripe, get_offset(1), yval, -1*radius)
	E.set_entity_position(black, get_offset(2), yval, 0)
	E.set_entity_position(brown_stripe, get_offset(2), yval, 2*radius)
	E.set_entity_position(yellow, get_offset(2), yval, -2*radius)
	E.set_entity_position(green_stripe, get_offset(3), yval, -3*radius)
	E.set_entity_position(red, get_offset(3), yval, -1*radius)
	E.set_entity_position(purple_stripe, get_offset(3), yval, radius)
	E.set_entity_position(green, get_offset(3), yval, 3*radius)
	E.set_entity_position(orange, get_offset(4), yval, -4*radius)
	E.set_entity_position(purple, get_offset(4), yval, -2*radius)
	E.set_entity_position(orange_stripe, get_offset(4), yval, 0)
	E.set_entity_position(blue, get_offset(4), yval, 2*radius)
	E.set_entity_position(red_stripe, get_offset(4), yval, 4*radius)
end
function delete_balls()

	E.delete_entity(cue)
	E.delete_entity(yellow_stripe)
	E.delete_entity(brown)
	E.delete_entity(blue_stripe)
	E.delete_entity(black)
	E.delete_entity(brown_stripe)
	E.delete_entity(yellow)
	E.delete_entity(green_stripe)
	E.delete_entity(red)
	E.delete_entity(purple_stripe)
	E.delete_entity(green)
	E.delete_entity(orange)
	E.delete_entity(purple)
	E.delete_entity(orange_stripe)
	E.delete_entity(blue)
	E.delete_entity(red_stripe)
end
function add_balls()


	cue = add_ball(1.0, 1.0, 1.0, 0)
	yellow_stripe = add_ball(1.0, 0.9, 0.2, 1)
	brown = add_ball(0.5, 0.25, 0.25, 0)
	blue_stripe = add_ball(0.0, 0.0, 1.0, 1)
	black = add_ball(0.2, 0.2, 0.2, 0)
	brown_stripe = add_ball(0.5, 0.25, 0.25, 1)
	yellow = add_ball(1.0, 0.9, 0.2, 0)
	green_stripe = add_ball(0.25, 0.5, 0.25, 1)
	red = add_ball(0.85, 0.25, 0.0, 0)
	purple_stripe = add_ball(0.8, 0.1, 1.0, 1)
	green = add_ball(0.25, 0.5, 0.25, 0)
	orange = add_ball(1.0, 0.5, 0.25, 0)
	purple = add_ball(0.8, 0.1, 1.0, 0)
	orange_stripe = add_ball(1.0, 0.5, 0.25, 1)
	blue = add_ball(0.0, 0.0, 1.0, 0)
	red_stripe = add_ball(0.85, 0.25, 0.0, 1)

	set_ball_positions()

end

function add_slate()
	box = E.create_object("../data/boxGreen.obj")
	E.parent_entity(box, pivot)

	E.set_entity_geom_type(box, E.geom_type_plane, 0, 1, 0, 0)
	E.set_entity_geom_attr(box, E.geom_attr_category, category_world)
	E.set_entity_geom_attr(box, E.geom_attr_collider, category_all)
	E.set_entity_geom_attr(box, E.geom_attr_soft_cfm, 0.00)
	E.set_entity_geom_attr(box, E.geom_attr_soft_erp, 0.0)
	E.set_entity_geom_attr(box, E.geom_attr_bounce, 0.5)
	E.set_entity_flags(box, E.entity_flag_visible_geom, false)

	E.set_entity_position(box, 0.0, 0.0, 0.0)
	E.set_entity_scale(box, slate_width*global_scale_value, .01, slate_length*global_scale_value)
	E.set_entity_rotation(box, 0, 0, 0)
	table.insert(objects, box)

	return box

end

function add_walls()
	local longSide  = (slate_width+1.0)*global_scale_value
	local shortSide = slate_length*global_scale_value
	local heightSide = 1.5*global_scale_value
	local widthSide = .5*global_scale_value

	local northWall = E.create_object("../data/boxWall.obj")
	local southWall = E.create_clone(northWall)
	local eastWall = E.create_clone(northWall)
	local westWall = E.create_clone(northWall)
	
	E.parent_entity(northWall, pivot)
	E.parent_entity(westWall, pivot)
	E.parent_entity(eastWall, pivot)
	E.parent_entity(southWall, pivot)

	--E.set_entity_geom_type(northWall, E.geom_type_box, 10, 6, 1)
	E.set_entity_geom_type(northWall, E.geom_type_plane, 0, 0, 1, -7.65)
	E.set_entity_geom_attr(northWall, E.geom_attr_category, category_world)
	E.set_entity_geom_attr(northWall, E.geom_attr_collider, category_all)

	--E.set_entity_geom_type(southWall, E.geom_type_box, 10, 6, 1)
	E.set_entity_geom_type(southWall, E.geom_type_plane, 0, 0, -1, -7.65)
	E.set_entity_geom_attr(southWall, E.geom_attr_category, category_world)
	E.set_entity_geom_attr(southWall, E.geom_attr_collider, category_all)

	--E.set_entity_geom_type(eastWall, E.geom_type_box, 1, 6, 10)
	E.set_entity_geom_type(eastWall, E.geom_type_plane, 1, 0, 0, -15)
	E.set_entity_geom_attr(eastWall, E.geom_attr_category, category_world)
	E.set_entity_geom_attr(eastWall, E.geom_attr_collider, category_all)

	--E.set_entity_geom_type(westWall, E.geom_type_box, 1, 6, 10)
	E.set_entity_geom_type(westWall, E.geom_type_plane, -1, 0, 0, -15)
	E.set_entity_geom_attr(westWall, E.geom_attr_category, category_world)
	E.set_entity_geom_attr(westWall, E.geom_attr_collider, category_all)


	E.set_entity_geom_attr(northWall, E.geom_attr_soft_erp, wall_erp)
	E.set_entity_geom_attr(northWall, E.geom_attr_soft_cfm, wall_cfm)
	E.set_entity_geom_attr(northWall, E.geom_attr_bounce, wall_bounce)
	E.set_entity_geom_attr(northWall, E.geom_attr_friction, wall_friction)

	E.set_entity_geom_attr(southWall, E.geom_attr_soft_erp, wall_erp)
	E.set_entity_geom_attr(southWall, E.geom_attr_soft_cfm, wall_cfm)
	E.set_entity_geom_attr(southWall, E.geom_attr_bounce, wall_bounce)
	E.set_entity_geom_attr(southWall, E.geom_attr_friction, wall_friction)

	E.set_entity_geom_attr(westWall, E.geom_attr_soft_erp, wall_erp)
	E.set_entity_geom_attr(westWall, E.geom_attr_soft_cfm, wall_cfm)
	E.set_entity_geom_attr(westWall, E.geom_attr_bounce, wall_bounce)
	E.set_entity_geom_attr(westWall, E.geom_attr_friction, wall_friction)

	E.set_entity_geom_attr(eastWall, E.geom_attr_soft_erp, wall_erp)
	E.set_entity_geom_attr(eastWall, E.geom_attr_soft_cfm, wall_cfm)
	E.set_entity_geom_attr(eastWall, E.geom_attr_bounce, wall_bounce)
	E.set_entity_geom_attr(eastWall, E.geom_attr_friction, wall_friction)


	E.set_entity_flags(northWall, E.entity_flag_visible_geom, false)
	E.set_entity_flags(southWall, E.entity_flag_visible_geom, false)
	E.set_entity_flags(westWall, E.entity_flag_visible_geom, false)
	E.set_entity_flags(eastWall, E.entity_flag_visible_geom, false)
	--E.set_entity_flags(northWall, E.entity_flag_visible_body, false)
	
	E.set_entity_position(northWall, 0, -1, -8.25)
	E.set_entity_position(southWall, 0, -1, 8.25)
	E.set_entity_position(westWall, 15.75, -1, 0)
	E.set_entity_position(eastWall, -15.75, -1, 0)

	E.set_entity_scale(northWall, longSide, heightSide, widthSide)
	E.set_entity_scale(southWall, longSide, heightSide, widthSide)
	E.set_entity_scale(westWall, widthSide, heightSide, shortSide)
	E.set_entity_scale(eastWall, widthSide, heightSide, shortSide)

	E.set_entity_rotation(northWall, 0, 0, 0)
	E.set_entity_rotation(southWall, 0, 0, 0)
	E.set_entity_rotation(westWall, 0, 0, 0)
	E.set_entity_rotation(eastWall, 0, 0, 0)

	E.set_entity_body_type(northWall, false)
	E.set_entity_body_type(southWall, false)
	E.set_entity_body_type(westWall, false)
	E.set_entity_body_type(eastWall, false)

	table.insert(objects, northWall)
	table.insert(objects, southWall)
	table.insert(objects, westWall)
	table.insert(objects, eastWall)
end
function set_camera()
	E.set_entity_position(camera, pos_x, pos_y, pos_z)
	E.set_entity_rotation(camera, rot_x, rot_y, rot_z)
end

function do_point(dx, dy)
    mouse_x = mouse_x + dx
    mouse_y = mouse_y + dy
    return true
end

function do_cue()
	local xc, yc, zc = E.get_entity_position(cue)
	local ax = getAbsX(xc)
	local ay = getAbsY(zc)
	local dx = mouse_x - ax
	local dy = mouse_y - ay

	
	E.add_entity_force(cue, dx*force_scale, 0, dy*force_scale)
end

function do_click(b, s)
	if b == 1 then
		if s == false then

			do_cue()

			--E.print_console("X:", mouse_x, "Y:", mouse_y)
		end
	end
end
function do_keyboard(key, down)
    if down then
	if key == E.key_r then
		delete_balls()
		add_balls()
		--set_ball_positions()
	end
	if key == E.key_1 then
		pos_x = -90
		pos_y = 70
		pos_z = 0
		rot_x = -44
		rot_y = -90
		rot_z = 0
		set_camera()
	end
	if key == E.key_2 then
		pos_x = 0
		pos_y = 120
		pos_z = 0
		rot_x = -90
		rot_y = 0
		rot_z = 0
		set_camera()
	end
	if key == E.key_3 then
		pos_x = 90
		pos_y = 70
		pos_z = 0
		rot_x = -44
		rot_y = 90
		rot_z = 0
		set_camera()
	end
	if key == E.key_up then
		local xc, yc, zc = E.get_entity_position(cue)
		E.set_entity_position(cue, xc, yc, zc-1)
		--E.print_console("absx: ", getAbsX(xc), "absy: ", getAbsY(zc-1), "\n")
	end
	if key == E.key_down then
		local xc, yc, zc = E.get_entity_position(cue)
		E.set_entity_position(cue, xc, yc, zc+1)
		--E.print_console("absx: ", getAbsX(xc), "absy: ", getAbsY(zc+1), "\n")
	end
	if key == E.key_left then
		local xc, yc, zc = E.get_entity_position(cue)
		E.set_entity_position(cue, xc-1, yc, zc)
		--E.print_console("absx: ", getAbsX(xc-1), "absy: ", getAbsY(zc), "\n")
	end
	if key == E.key_right then
		local xc, yc, zc = E.get_entity_position(cue)
		E.set_entity_position(cue, xc+1, yc, zc)
		--E.print_console("absx: ", getAbsX(xc+1), "absy: ", getAbsY(zc), "\n")
	end
        return true
    end
    return false
end


function do_timer(dt)
        --local mx = (mouse_x - 400)/400.0
        --local my = (mouse_y - 300)/300.0
        --update_camera()
end
function getAbsX(localx)
	local toReturn = 400 + 20*localx
	return toReturn
end
function getAbsY(localz)
	local toReturn = 300 + 20*localz
	return toReturn
end

-- main setup
function do_start()
	--E.set_background(0.0, 0.0, 0.0, 0.1, 0.2, 0.4)
	E.set_background(0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

	-- Set up camera and position
	camera = E.create_camera(E.camera_type_perspective)
	set_camera()

	light  = E.create_light(E.light_type_positional)
	pivot  = E.create_pivot()
	plane = E.create_object("../data/checker.obj")
	E.set_camera_range(camera, 1, 10000)

	-- relationships
	E.parent_entity(light, camera)
	E.parent_entity(pivot, light)

	E.set_entity_position(light, 0.0, 100.0, -10.0)
	E.set_entity_scale(pivot,  SCALE,  SCALE,  SCALE)
	E.set_entity_scale(sky, 8, 8, 8)
	E.enable_timer(true)
	add_slate()
	add_walls()
	add_balls()
end

do_start()
