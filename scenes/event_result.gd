extends Control

@export var score_tier1_threshold:int = 10
@export var score_tier2_threshold:int = 18
@export var score_tier3_threshold:int = 25

@export var score : int:
	set(val):
		score = val
		if %Score:
			%Score.text = str(val)
	
		if %Star1 and %Star2 and %Star3:
			%Star1.visible = score >= score_tier1_threshold
			%Star2.visible = score >= score_tier2_threshold
			%Star3.visible = score >= score_tier3_threshold
			%GrayStar1.visible = not %Star1.visible
			%GrayStar2.visible = not %Star2.visible
			%GrayStar3.visible = not %Star3.visible
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = score
