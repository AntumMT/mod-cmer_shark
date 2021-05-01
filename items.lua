-- Items for mob_shark mod


local S = core.get_translator("shark")


core.register_craftitem(':mobs:shark_meat_raw', {
	description = S('Raw Shark Meat'),
	inventory_image = 'mobs_shark_meat_raw.png',
	on_use = core.item_eat(4),
})
core.register_alias('mobs:shark_meat', 'mobs:shark_meat_raw')

core.register_craftitem(':mobs:shark_meat_cooked', {
	description = S('Cooked Shark Meat'),
	inventory_image = 'mobs_shark_meat_cooked.png',
	on_use = core.item_eat(9),
})

core.register_craftitem(':mobs:shark_tooth', {
	description = S('Shark Tooth'),
	inventory_image = 'mobs_shark_tooth.png',
})

core.register_craftitem(':mobs:shark_skin', {
	description = S('Shark Skin'),
	inventory_image = 'mobs_shark_skin.png',
})


core.register_craft({
	type = 'cooking',
	output = 'mobs:shark_meat_cooked',
	recipe = 'mobs:shark_meat_raw',
	cooktime = 5,
})
