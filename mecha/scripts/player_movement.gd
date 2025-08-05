extends CharacterBody2D

var movement_key_buffer: Array[Vector2i] = []
var direction_vector: Vector2i = Vector2i.ZERO
var last_direction_vector: Vector2i = Vector2i.ZERO
@export var speed: float = 300.0

func _input(event: InputEvent) -> void:
	#TEMPORARY!
	#Exit game key
	if event.is_action_pressed("escape"):
		get_tree().quit()

	#Store all pressed movement buttons to key_buffer variable
	if event.is_action_pressed("move_up"):
		movement_key_buffer.append(Vector2i.UP)
	elif event.is_action_pressed("move_down"):
		movement_key_buffer.append(Vector2i.DOWN)
	elif event.is_action_pressed("move_left"):
		movement_key_buffer.append(Vector2i.LEFT)
	elif event.is_action_pressed("move_right"):
		movement_key_buffer.append(Vector2i.RIGHT)

	#Delete buttons from key_buffer if button was released
	if event.is_action_released("move_up"):
		movement_key_buffer.erase(Vector2i.UP)
	elif event.is_action_released("move_down"):
		movement_key_buffer.erase(Vector2i.DOWN)
	elif event.is_action_released("move_left"):
		movement_key_buffer.erase(Vector2i.LEFT)
	elif event.is_action_released("move_right"):
		movement_key_buffer.erase(Vector2i.RIGHT)


func _physics_process(_delta: float) -> void:
		if movement_key_buffer.size() > 0:
			direction_vector = movement_key_buffer.back()
		else:
			direction_vector = Vector2i.ZERO
			
		if direction_vector:
			velocity = direction_vector * speed
		else:
			velocity = velocity.move_toward(Vector2i.ZERO, speed)
			
		move_and_slide()
