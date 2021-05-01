-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- Converted to 'creatures' mob engine API by Jordan Irwin (AntumDeluge)
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief shark implementation
--! @copyright Sapier
--! @author Sapier
--! @date 2014-05-30
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

local S = core.get_translator("shark")


shark = {
	modname = core.get_current_modname()
}
shark.modpath = core.get_modpath(shark.modname)

local version = "1.0"
local variant = "creatures"
local version_full = tostring(version) .. "-" .. variant


local function mlog(lvl, msg)
	if lvl and msg == nil then
		msg = lvl
		lvl = nil
	end

	if lvl == nil then
		core.log("[" .. shark.modname .. "] " .. msg)
	else
		core.log(lvl, "[" .. shark.modname .. "] " .. msg)
	end
end


mlog("action", "v" .. version_full .. " loading ...")


local mobname = "creatures:shark"
local scripts = {
	"settings",
	"items",
}

for _, script in ipairs(scripts) do
	dofile(shark.modpath .. "/" .. script .. ".lua")
end


--[[
--local shark_collisionbox = {-0.75, -0.5, -0.75, 0.75, 0.5, 0.75}
--local shark_collisionbox = {-0.38, -0.25, -0.38, 0.38, 0.25, 0.38}
local shark_drop = {
	{name="shark:meat_raw", chance=1, min=3, max=3},
	{name="shark:tooth", chance=4, min=1, max=3},  -- FIXME: Original 'chance' value was 0.01
	{name="shark:skin", chance=4, min=1, max=1},  -- FIXME: Original 'chance' value was 0.01
}
]]

--[[
mobs:register_mob(":" .. mobname, {
	type = "monster",
	--passive = nil,
	--docile_by_day = nil,
	--attacks_monsters = nil,
	--group_attack = nil,
	owner_loyal = true,
	attack_animals = true,
	--specific_attack = nil,
	hp_min = 10,  -- CHANGED (ORIGINAL: 5)
	hp_max = 15,  -- CHANGED (ORIGINAL: 5)
	--physical = nil,
	collisionbox = shark_collisionbox,
	visual = "mesh",
	visual_size = {x=0.5, y=0.5},  -- CHANGED (ORIGINAL: {x=1, y=1, z=1})
	mesh = "shark.b3d",
	textures = {
		{"shark_mesh.png"},
	},
	--gotten_texture = nil,
	--child_texture = nil,
	--gotten_mesh = nil,
	makes_footstep_sound = false,
	--follow = nil,
	view_range = 10,
	--walk_chance = nil,
	walk_velocity = 2,
	run_velocity = 3,
	--runaway = nil,
	stepheight = 0.1,
	jump = false,
	jump_height = 0,
	fly = true,
	fly_in = "default:water_source",  -- FIXME: Should be able to swim in 'default:water_flowing' as well
	damage = 6,
	--recovery_time = nil,
	--knock_back = nil,
	--immune_to = nil,
	--blood_amount = nil,
	--blood_texture = nil,
	drops = shark_drop,
	armor = 100,
	--drawtype = nil,
	rotate = 270,
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	--suffocation = nil,
	--fall_damage = nil,
	fall_speed = -9,
	--fear_height = nil,
	--on_die = nil,
	--floats = nil,
	--on_rightclick = nil,
	--pathfinding = nil,
	attack_type = "dogfight",
	--custom_attack = nil,
	--double_melee_attack = nil,
	--on_blast = nil,
	reach = 2,
	--sounds = nil,
	animation = {
		speed_normal = 24,
		speed_run = 24,
		stand_start = 1,
		stand_end = 80,
		walk_start = 80,
		walk_end = 160,
		run_start = 80,
		run_end = 160,
	},
})
]]

local spawn_nodes = {"default:sand", "default:desert_sand", "default:clay"}
if core.global_exists("ethereal") then
	table.insert(spawn_nodes, "ethereal:seaweed")
end

--[[
mobs:spawn({
	name = mobname,
	nodes = spawn_nodes,
	neighbors = {"default:water_source"},  -- 'default:water_flowing'},
	interval = interval,
	chance = chance,
	min_light = min_light,
	max_light = max_light,
	min_height = min_height,
	max_height = max_height,
	day_toggle = day_toggle,
})

mobs:register_egg(":" .. mobname, S("Shark"), "mobs_shark_inv.png", 0, false)
]]

local shark_def = {
	name = "creatures:shark",
	stats = {
		hp = 15, -- TODO: add setting to change
		--hp_min = 10,
		--hp_max = 15,
		hostile = true,
		lifetime = 600, -- 10 minutes
		can_jump = 0,
		can_swim = true,
	},
	-- FIXME:
	-- - shark moves on land after being attacked
	-- - shark doesn't attack until attacked
	-- - shark floats into air when attacked
	modes = {
		idle = {
			chance = 0.1,
			duration = 30,
			moving_speed = 0,
		},
		follow = {
			chance = 0.1,
			duration = 120,
			moving_speed = 2,
		},
		attack = {
			chance = 0.8,
			moving_speed = 3,
		},
	},
	model = {
		mesh = "shark.b3d",
		textures = {"shark_mesh.png"},
		collisionbox = {-0.38, -0.25, -0.38, 0.38, 0.25, 0.38},
		--rotation = 0.0,
		animations = {
			idle = {
				start = 1,
				stop = 80,
				speed = 24,
			},
			follow = {
				start = 80,
				stop = 160,
				speed = 24,
			},
			attack = {
				start = 80,
				stop = 160,
				speed = 24,
			},
		},
	},
	drops = {
		{"shark:meat_raw", 3, 1.0},
		{"shark:tooth", {min=1, max=3}, 0.4},
		{"shark:skin", 1, 0.4},
	},
	combat = {
		attack_damage = 6,
		--attack_speed = 1.0,
		attack_radius = 2.0,
		--search_enemy = ,
		--search_timer = ,
		search_radius = 10.0,
		--search_type = ,
	},
	spawning = {
		abm_nodes = {
			spawn_on = spawn_nodes,
			neighbors = {"default:water_source", "default:water_flowing",},
		},
		abm_interval = shark.interval,
		abm_chance = shark.chance,
		--max_number = 1,
		number = 1,
		time_range = {min=shark.min_time, max=shark.max_time},
		light = {min=shark.min_light, max=shark.max_light},
		height_limit = {min=shark.min_height, max=shark.max_height},
		spawn_egg = {
			description = S("Shark"),
			texture = "shark_inv.png",
		},
		--spawner = {},
	},
}

creatures.register_mob(shark_def)


mlog("action", "v" .. version_full .. " loaded")
