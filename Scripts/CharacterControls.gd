extends Node2D

var damage = 5.0
signal player_attacked(damage, timer, attacker)
var detected_enemies = []

var Speed = 100.0
var left = KEY_A
var right = KEY_D
var attack = KEY_J
enum CharacterState { IDLE, WALKING, ATTACK }
var CurrentState = CharacterState.IDLE
@onready var character_sprite = $AnimatedSprite2D
@onready var Hitbox = $AnimatedSprite2D/PlayerHitbox

func _ready() -> void:
	Hitbox.area_entered.connect(_on_area_entered)
	Hitbox.area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area2D):
	#if area.is_in_group("enemy"):
		detected_enemies.append(area)
		# Подключаемся к сигналу атаки
		player_attacked.connect(area.on_player_attacked)

func _on_area_exited(area: Area2D):
	#if area.is_in_group("enemy"):
		detected_enemies.erase(area)
		# Отключаемся от сигнала
		player_attacked.disconnect(area.on_player_attacked)

func _process(delta: float) -> void:
	if CurrentState == CharacterState.IDLE or CurrentState == CharacterState.WALKING:
		if CurrentState == CharacterState.IDLE:
			character_sprite.play("Idle")
		
		# Проверяем движение влево
		if Input.is_key_pressed(left):
			character_sprite.flip_h = true
			character_sprite.play("Walk")
			position.x -= Speed * delta
			CurrentState = CharacterState.WALKING
			
		# Проверяем движение вправо
		elif Input.is_key_pressed(right):
			character_sprite.flip_h = false
			character_sprite.play("Walk")
			position.x += Speed * delta
			CurrentState = CharacterState.WALKING
		
		else:
			CurrentState = CharacterState.IDLE
		
		if Input.is_key_pressed(attack):
			CurrentState = CharacterState.ATTACK
			character_sprite.play("Attack_1")
			player_attacked.emit(damage, 0.3, self)
			await character_sprite.animation_finished
			CurrentState = CharacterState.IDLE
			
