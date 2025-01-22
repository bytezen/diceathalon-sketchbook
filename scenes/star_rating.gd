extends Control

@export var fulfilled:Texture2D: 
	set(val):
		fulfilled = val
		if not is_node_ready():
			await ready
			%Fulfilled.texture = val
			 
@export var unfulfilled:Texture2D:
	set(val):
		unfulfilled = val
		if not is_node_ready():
			await ready
			%UnFulfilled.texture = val

@export var is_fullfilled:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%Fulfilled.visible = is_fullfilled
	
