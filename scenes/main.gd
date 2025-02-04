extends Node

@onready var one_hundred_meter: Control = $OneHundredMeter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("{main.READY}" + "DEBUG_INFO: adding 2 players for testing")
	GameController.Game = self
	GameController.add_player("estonia")
	GameController.add_player("germany")
	GameController.events.push_front(one_hundred_meter)
	
	assert( len(GameController.players) == 2, "2 players were not created")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
