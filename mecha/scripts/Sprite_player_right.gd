extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("right")
		print(_animated_sprite)
	if Input.is_action_pressed("ui_left"):
		_animated_sprite.play("left")
		print(_animated_sprite)
	else:
		_animated_sprite.stop("left")
		print(_animated_sprite)
