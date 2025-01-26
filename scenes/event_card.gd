extends Node2D

@onready var event_label: Label = $Event
@onready var score_label: Label = $Score
@onready var rank_label: Label = $Rank
@onready var forward_button: TextureButton = $ForwardButton
@onready var backward_button: TextureButton = $BackwardButton 

var event:String:
	set(val):
		event = val
		event_label.text = event
var score:int:
	set(val):
		score = val
		score_label.text = str(val) 

var rank:int:
	set(val):
		rank = val
		rank_label.text = str(rank) + " place "

signal nav_forward 
signal nav_backward

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	forward_button.pressed.connect(_on_forward_button_pressed)
	backward_button.pressed.connect(_on_backward_button_pressed)
	
func _on_forward_button_pressed() -> void:
	if forward_button.disabled:
		return
	nav_forward.emit()
	
func _on_backward_button_pressed() -> void:
	if backward_button.disabled:
		return
	nav_backward.emit()
	
