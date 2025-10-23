extends Node2D

# Загрузка префаба при компиляции
var Ground = preload("res://Scenes/ground.tscn")
var Chest = preload("res://Scenes/chest.tscn")
var Character = preload("res://Scenes/character.tscn")
var GSlime = preload("res://Scenes/slime.tscn")
var Window_Size: Vector2

func _ready() -> void:
	# Получаем размер окна только после того как нод добавлен в дерево
	Window_Size = get_window().size
	
	var GroundInstance = Ground.instantiate()
	var GroundSprite   = GroundInstance.get_node("Sprite2D")
	
	var ChestInstance = Chest.instantiate()
	var ChestSprite   = ChestInstance.get_node("ChestSprite")
	var Chest_texture_size = ChestSprite.sprite_frames.get_frame_texture("DefaultState", 0).get_size()
	
	var CharacterInstance = Character.instantiate()
	var CharacterSprite   = CharacterInstance.get_node("AnimatedSprite2D")
	var Character_texture_size = CharacterSprite.sprite_frames.get_frame_texture("Idle", 0).get_size()
	
	var GSlimeInstance = GSlime.instantiate()
	var GSlimeSprite = GSlimeInstance.get_node("Sprite")
	
	var GroundLevel = Window_Size.y - GroundSprite.texture.get_height()/2 * GroundSprite.scale.y
	
	add_child(GroundInstance)
	add_child(ChestInstance)
	add_child(CharacterInstance)
	add_child(GSlimeInstance)
	
	# Теперь Window_Size доступен и GroundSprite тоже
	GroundInstance.position    = Vector2(Window_Size.x / 2.0, GroundLevel)
	ChestInstance.position     = Vector2(Window_Size.x / 2.0, Window_Size.y - Chest_texture_size.y/2 * GroundSprite.scale.y)
	CharacterInstance.position = Vector2(Window_Size.x / 2.0, Window_Size.y - Character_texture_size.y/2 * CharacterSprite.scale.y - GroundSprite.texture.get_height()/1.8)
	GSlimeInstance.position    = Vector2(250, GroundLevel)
	# Также установите позицию для сундука, если нужно
	# ChestInstance.position = Vector2(Window_Size.x / 2.0, ...)
