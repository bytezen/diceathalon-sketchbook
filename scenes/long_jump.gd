extends Control

enum State {INIT,IDLE, ROLLING, USER_CHOICE}
var current_state:State = State.INIT
var dice : Array[Die] = []
var _throws := 0
var _die_rolling_count := 0
var _score := 0
var _roll1_score := 0
var _roll2_score := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Die:
			dice.append(child)
			child.animation_stop.connect(on_die_animation_stopped)
			
	%RollButton.pressed.connect(on_roll_button_pressed)
	%ScoreButton.pressed.connect(on_score_button_pressed)


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# For Debug output
	%DebugState.text = _state_string()
	
	if current_state == State.INIT:
		%ScoreButton.disabled = true
		%RollButton.disabled = false
		
	elif current_state == State.IDLE:
		%ScoreButton.disabled = true
		%RollButton.disabled = false
		
	elif current_state == State.ROLLING:
		pass
		
	elif current_state == State.USER_CHOICE:
		%ScoreButton.disabled = false
		%RollButton.disabled = false
		
		
func _state_string() -> String:
	return ["init","idle","rolling","user_choice"][current_state]

func on_roll_button_pressed() -> void:
	if %RollButton.disabled:
		return
	# roll all of the dice for now
	if current_state == State.INIT:
		# all the dice are active
		_die_rolling_count = 4
		for d in dice:
			d.roll_die()
		%RollButton.disabled = true

func on_score_button_pressed() -> void:
	if %ScoreButton.disabled:
		return	
	_total_dice()
	
func on_die_animation_stopped() -> void:
	_die_rolling_count -= 1
	
	if current_state == State.INIT:
		if _die_rolling_count == 0:
			%ScoreButton.disabled = false
			%RollButton.disabled = false
			%RollCounter.remaining_throws -= 1
			_total_dice()
			%ScoreValue.text = str(_score) 			
			current_state = State.USER_CHOICE
	pass
	
func _total_dice() -> void:
	var _tot := 0
	for d in dice:
		if d.value == 6:
			_tot -= 6
		else:
			_tot += d.value
	_score += max(0,_tot)	
