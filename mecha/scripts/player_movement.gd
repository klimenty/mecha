extends CharacterBody2D

var movement_key_buffer: Array[Vector2i] = []
var look_direction_key_buffer: Array[Vector2i] = []
var look_direction: Vector2i = Vector2.DOWN
var direction_vector: Vector2i = Vector2i.ZERO
var last_direction_vector: Vector2i = Vector2i.ZERO
@export var speed: float = 300.0
var walking_speed: float = 300.0
var running_speed: float = 500.0
var sideway_movement_multiplicator: float = 0.5
var backward_movement_multiplicator: float = 0.25
var is_runnign: bool = false
@onready var animated_sprite_2d = $AnimatedSprite2D
#enum States {IDLE, WALKING, RUNNING}
#var state: States = States.IDLE

func _input(event: InputEvent) -> void:
	#TEMPORARY!
	#Exit game key
	if event.is_action_pressed("escape"):
		get_tree().quit()

	#Store all pressed movement buttons to movement_key_buffer variable
	if event.is_action_pressed("move_up"):
		movement_key_buffer.append(Vector2i.UP)
	elif event.is_action_pressed("move_down"):
		movement_key_buffer.append(Vector2i.DOWN)
	elif event.is_action_pressed("move_left"):
		movement_key_buffer.append(Vector2i.LEFT)
	elif event.is_action_pressed("move_right"):
		movement_key_buffer.append(Vector2i.RIGHT)
		
	#Store all pressed buttons for look direction to look_direction_key_buffer variable
	if event.is_action_pressed("look_up"):
		look_direction_key_buffer.append(Vector2i.UP)
	elif event.is_action_pressed("look_down"):
		look_direction_key_buffer.append(Vector2i.DOWN)
	elif event.is_action_pressed("look_left"):
		look_direction_key_buffer.append(Vector2i.LEFT)
	elif event.is_action_pressed("look_right"):
		look_direction_key_buffer.append(Vector2i.RIGHT)
		
	if event.is_action_pressed("shift"):
		is_runnign = true
	if event.is_action_released("shift"):
		is_runnign = false

	#Delete buttons from movement_key_buffer if button was released
	if event.is_action_released("move_up"):
		movement_key_buffer.erase(Vector2i.UP)
	elif event.is_action_released("move_down"):
		movement_key_buffer.erase(Vector2i.DOWN)
	elif event.is_action_released("move_left"):
		movement_key_buffer.erase(Vector2i.LEFT)
	elif event.is_action_released("move_right"):
		movement_key_buffer.erase(Vector2i.RIGHT)

	#Delete buttons from look_direction_key_buffer if button was released
	if event.is_action_released("look_up"):
		look_direction_key_buffer.erase(Vector2i.UP)
	elif event.is_action_released("look_down"):
		look_direction_key_buffer.erase(Vector2i.DOWN)
	elif event.is_action_released("look_left"):
		look_direction_key_buffer.erase(Vector2i.LEFT)
	elif event.is_action_released("look_right"):
		look_direction_key_buffer.erase(Vector2i.RIGHT)


func _physics_process(_delta: float) -> void:
	
	if movement_key_buffer.size() > 0:
		direction_vector = movement_key_buffer.back()
	else:
		direction_vector = Vector2i.ZERO

	#Store last look or movement direction to look_direction variable
	if look_direction_key_buffer:
		look_direction = look_direction_key_buffer.back()
	elif movement_key_buffer:
		look_direction = movement_key_buffer.back()

	if is_runnign:
		speed = running_speed
	else:
		speed = walking_speed
		
	if (direction_vector + look_direction) == Vector2i.ZERO:
		speed = speed * backward_movement_multiplicator
	elif direction_vector != look_direction:
		speed = speed * sideway_movement_multiplicator

	if direction_vector:
		velocity = direction_vector * speed
	else:
		velocity = velocity.move_toward(Vector2i.ZERO, speed)

	if direction_vector == Vector2i.ZERO:
		match look_direction:
			Vector2i.DOWN:
				animated_sprite_2d.play("idle_down")
			Vector2i.UP:
				animated_sprite_2d.play("idle_up")
			Vector2i.LEFT:
				animated_sprite_2d.play("idle_left")
			Vector2i.RIGHT:
				animated_sprite_2d.play("idle_right")
	elif is_runnign:
		if direction_vector and look_direction_key_buffer.size() > 0:
			match look_direction:
				Vector2i.DOWN:
					animated_sprite_2d.play("run_down")
				Vector2i.UP:
					animated_sprite_2d.play("run_up")
				Vector2i.LEFT:
					animated_sprite_2d.play("run_left")
				Vector2i.RIGHT:
					animated_sprite_2d.play("run_right")
		elif direction_vector:
			match direction_vector:
				Vector2i.DOWN:
					animated_sprite_2d.play("run_down")
				Vector2i.UP:
					animated_sprite_2d.play("run_up")
				Vector2i.LEFT:
					animated_sprite_2d.play("run_left")
				Vector2i.RIGHT:
					animated_sprite_2d.play("run_right")
	else:
		if direction_vector and look_direction_key_buffer.size() > 0:
			match look_direction:
				Vector2i.DOWN:
					animated_sprite_2d.play("walk_down")
				Vector2i.UP:
					animated_sprite_2d.play("walk_up")
				Vector2i.LEFT:
					animated_sprite_2d.play("walk_left")
				Vector2i.RIGHT:
					animated_sprite_2d.play("walk_right")
		elif direction_vector:
			match direction_vector:
				Vector2i.DOWN:
					animated_sprite_2d.play("walk_down")
				Vector2i.UP:
					animated_sprite_2d.play("walk_up")
				Vector2i.LEFT:
					animated_sprite_2d.play("walk_left")
				Vector2i.RIGHT:
					animated_sprite_2d.play("walk_right")
					
					
	move_and_slide()
