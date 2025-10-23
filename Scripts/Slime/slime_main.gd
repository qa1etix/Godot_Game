extends Node2D

@onready var sprite = $Sprite

var health = 10.0

enum States {IDLE}
var State = States.IDLE

func _ready() -> void:
	if State == States.IDLE:
		sprite.play("Idle")
		
func _process(_delta: float) -> void:
	pass

func take_damage(amount):
	health -= amount
	if health <= 0:
		print("Slime died")
