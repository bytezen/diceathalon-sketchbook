extends Control
@onready var player_label: Label = $Background/PlayerLabel
@onready var player_flag: TextureRect = $Background/PlayerFlag

@export var country:String:
	set(val):
		country = val 
		if not is_node_ready():
			await ready
			
		player_label.text = val
		
@export var flag:Texture2D:
	set(val):
		flag = val 
		if not is_node_ready():
			await ready
				
		player_flag.texture = val
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
