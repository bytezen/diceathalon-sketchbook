extends Control

@export var score_tier1_threshold:int = 10
@export var score_tier2_threshold:int = 18
@export var score_tier3_threshold:int = 25
@onready var score_field: RichTextLabel = %Score

@export var score : int:
	set(val):
		score = val
		
		# solution to children not being ready from here:
		#https://github.com/godotengine/godot-proposals/issues/325#issuecomment-1643230075
				
		if not is_node_ready():
			await ready
			
		%Score.text = str(val)
		%Message.text = "nice try"
			
		for rating in [%LowRating,%MedRating,%HighRating]:
			rating.is_fullfilled = false
			
		if score >= score_tier1_threshold:
			%LowRating.is_fullfilled = true
			%Message.text = "not bad!"
			
		if  score >= score_tier2_threshold:
			%MedRating.is_fullfilled = true
			%Message.text = "good job!"

		if score >= score_tier3_threshold:
			%HighRating.is_fullfilled = true
			%Message.text = "great!"
			
signal close			
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#score = score
	print("DEBUG: Should not see this message more than once!...ready function for the EventResult")
	print("\t...ready function for the EventResult Scene connecting more than one signal")
	%Close.pressed.connect(_on_closed_pressed)

func _on_closed_pressed():
	print("close button presses")
	close.emit()
