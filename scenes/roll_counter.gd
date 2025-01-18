extends Node2D

#@onready var number_tag: Sprite2D = %NumberTag
@onready var number_tag: Sprite2D = $NumberTag

var _remaining_throws : int
signal oops_animation_stopped

@export_range(0,7) var remaining_throws:int = 7:
	set(val):
		remaining_throws = val
		if number_tag:
			number_tag.frame = val
	#get():
		#return remaining_throws

func animate_oops() -> void:
	%Ooops.visible = true
	
func _ready() -> void:
	number_tag.frame = remaining_throws
	%Ooops.visible = false

		
