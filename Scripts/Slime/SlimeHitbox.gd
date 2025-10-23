extends Area2D

@onready var Slime = get_parent().get_parent()

func on_player_attacked(damage, timer, _attacker):
	print("Игрок атаковал! Урон: {damage}".format({"damage":damage}))
	await get_tree().create_timer(timer).timeout
	Slime.take_damage(damage)
	pass
