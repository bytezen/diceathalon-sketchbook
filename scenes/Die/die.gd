extends Node2D
class_name Die


@onready var face: Sprite2D = %Face
@onready var roll: Sprite2D = %Roll
@onready var roll_animation: AnimationPlayer = %RollAnimation
@onready var timer: Timer = $Timer

signal animation_start
signal animation_stop

enum State {ACTIVE,INACTIVE}
var _value : int = 0
var value : int :
	get:
		return _value  + 1
		
var state : State = State.INACTIVE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	#roll_die()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#if Input.is_action_pressed("left_mouse"):
		#if not roll_animation.is_playing():
			#roll_die()
			
func _set_value() -> void:
	_value = randi_range(0,face.hframes - 1)
	#print(_value)
	face.frame = _value

func roll_die() -> void:
	roll.visible = true
	face.visible = false
	roll_animation.play("roll")
	var roll_time:= randf_range(0.25,0.75)
	timer.wait_time = roll_time
	timer.start()
	animation_start.emit()

	
func on_timer_timeout() -> void:
	roll_animation.stop()
	_set_value()
	roll.visible = false
	face.visible = true
	print("value: " + str(value))
	animation_stop.emit()
