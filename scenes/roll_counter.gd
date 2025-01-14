extends Node2D
@onready var number_tag: Sprite2D = %NumberTag

var _remaining_throws : int

@export_range(0,7) var remaining_throws:int = 7:
	set(val):
		_remaining_throws = val - 1 
		if %NumberTag:
			%NumberTag.frame = _remaining_throws

func _ready() -> void:
	%NumberTag.frame = _remaining_throws
