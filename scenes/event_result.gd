extends Control

@export var score_tier1_threshold:int = 10
@export var score_tier2_threshold:int = 18
@export var score_tier3_threshold:int = 25
@onready var score_field: RichTextLabel = %Score


@onready var gray_star_1: Sprite2D = %GrayStar1
@onready var gray_star_3: Sprite2D = %GrayStar3
@onready var star_1: Sprite2D = %Star1
@onready var star_2: Sprite2D = %Star2
@onready var star_3: Sprite2D = %Star3

@export var score : int:
	set(val):
		score = val
		
		# solution to children not being ready from here:
		#https://github.com/godotengine/godot-proposals/issues/325#issuecomment-1643230075
				
		if not is_node_ready():
			await ready
		#if %Score:
			%Score.text = str(val)
		#if %Star1 and %Star2 and %Star3:
			%Star1.visible = score >= score_tier1_threshold
			%Star2.visible = score >= score_tier2_threshold
			%Star3.visible = score >= score_tier3_threshold
			%GrayStar1.visible = not %Star1.visible
			%GrayStar2.visible = not %Star2.visible
			%GrayStar3.visible = not %Star3.visible

			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = score
