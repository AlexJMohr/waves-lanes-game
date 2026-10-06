class_name Levels

const MELEE = preload("res://melee_unit.tres")
const RANGED = preload("res://ranged_unit.tres")

# array of levels, each item is array of waves
const LEVELS = [
	# Level 1
	[
		{ delay = 5.0, units = [MELEE] },
		{ delay = 6.0, units = [MELEE, MELEE] },
		{ delay = 6.0, units = [MELEE, RANGED] },
	],
]
