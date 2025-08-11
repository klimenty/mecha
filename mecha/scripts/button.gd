extends Button

@export var player: CharacterBody2D
@export var target_position: Marker2D
@export var animation_player: AnimationPlayer
@export var move_duration: float = 1.0

func _ready():
	connect("pressed", _on_button_pressed)
	
func _on_button_pressed():
	if player and target_position:
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)  # плавное ускорение/замедление
		tween.set_trans(Tween.TRANS_SINE)  # тип интерполяции
		
		# Запускаем анимацию перемещения
		tween.tween_property(
			player,  # объект
			"global_position",  # свойство
			target_position.global_position,  # целевое значение
			move_duration  # время
		)
