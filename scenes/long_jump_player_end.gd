extends Control

@export var score:int = 0:
	set(val):
		score = val
		if not is_node_ready():
			await ready
			
		set_result(score)
			
signal close

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%EventResult.close.connect(_on_event_result_close)
	pass # Replace with function body.

func _on_event_result_close():
	print("event result closed pressed")
	close.emit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_result(score:int,country:String = "norway") -> void:
	%EventResult.score = score	
