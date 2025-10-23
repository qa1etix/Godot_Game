extends Node2D

func _ready():
	var _ChestSprite = get_node("ChestSprite")
	var AnimationPlayerChest = get_node("AnimationPlayerChest")
	#position = Vector2(get_window().size.x / 2.0, get_window().size.y - 16*ChestSprite.scale.x)
	AnimationPlayerChest.play("Idle")

func _process(_delta: float) -> void:
	pass
