extends Control

@export var player_score : RichTextLabel
@export var player_flag : CompressedTexture2D:
	set(val):
		player_flag = val
		if not is_node_ready():
			await ready
			%Flag.texture = player_flag

enum State {INIT,IDLE, ROLLING, USER_CHOICE, LAST_ROLL,END, USER_ROLL_SECOND_SET}

var current_state:State = State.INIT
var previous_state:State = State.INIT

var dice : Array[Die] = []
var _die_rolling_count := 0
var _score := 0
var _dice_total := 0
var _rolls_scored := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Die:
			dice.append(child)
			child.animation_stop.connect(on_die_animation_stopped)
			
	%RollButton.pressed.connect(on_roll_button_pressed)
	%ScoreButton.pressed.connect(on_score_button_pressed)
	%RollCounter.oops_animation_stopped.connect(on_roll_counter_oops_animation_stopped)
	
	%LongJumpPlayerEnd.close.connect(_on_long_jump_player_end_close)

func _on_long_jump_player_end_close():
	print("long jump player end closed")
	%LongJumpPlayerEnd.visible = false
	_change_state(State.INIT)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# For Debug output
	%DebugState.text = "previous: " + _state_string("previous") + "current: " +  _state_string()
	
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
		
		if %RollCounter.remaining_throws == 0:
			%RollButton.disabled = true
		else: 	
			%RollButton.disabled = false
		
	elif current_state == State.LAST_ROLL:
		%RollCounter.animate_oops()
		_roll_dice()
		
	elif current_state == State.USER_ROLL_SECOND_SET:
		# Move the dice set indicator down
		# Make that scene the active current scene
		%ScoreButton.disabled = true
		%RollButton.disabled = false
		pass
		
	elif current_state == State.END:
		%LongJumpPlayerEnd.visible = true
		%LongJumpPlayerEnd.score = _score
		# TODO: signal listener for when the end screen is closed
		# LongJump sends a signal for whoever is interested in the player being done??
		pass
		
		
func _roll_dice() -> void:
	if current_state == State.ROLLING:
		return
		
	_die_rolling_count = 4
	for d in dice:
		d.roll_die()
	%RollButton.disabled = true
	_change_state(State.ROLLING)
	
func on_roll_button_pressed() -> void:
	if %RollButton.disabled:
		return
	_roll_dice()
		
func on_score_button_pressed() -> void:
	if %ScoreButton.disabled:
		return	
		
	# update the player score
	_score += _total_dice() 
	player_score.text = str(_score)
	# update the number of rolls scored
	_rolls_scored += 1
	
	if _rolls_scored == 2:
		_change_state(State.END)
	else:
		%RollTotal.text = str(0)
		#%RollTotal.visible = false
		%RollButton.disabled  = true
		_change_state(State.USER_ROLL_SECOND_SET)
	
func on_die_animation_stopped() -> void:
	_die_rolling_count -= 1
	
	# keep track of all of the dice that are rolling
	# TODO: Move the management of dice rolling into a component
	# this into a component with signals
	if _die_rolling_count != 0:
		return
	
	%RollCounter.remaining_throws -= 1
	var _throws:int =  %RollCounter.remaining_throws
	
	_dice_total = _total_dice()
	%RollTotal.text = str(_dice_total)
			
	if previous_state == State.INIT:
		%ScoreButton.disabled = false
		%RollButton.disabled = false
	
		#player_score.text = str(_score) 			
		_change_state(State.USER_CHOICE)
	
	elif previous_state == State.USER_CHOICE:
		# see if we have any more throws left
		if _throws > 1:
			_change_state(State.USER_CHOICE)
		else:
			_change_state(State.LAST_ROLL)
	
	elif previous_state == State.USER_ROLL_SECOND_SET:
		# see if we have any more throws left
		if _throws > 1:
			_change_state(State.USER_CHOICE)
		else:
			_change_state(State.LAST_ROLL)		
		
	elif current_state	== State.LAST_ROLL:
		# save the score and then transition to the end screen
		_score += _dice_total
		
		pass
		
func on_roll_counter_oops_animation_stopped() -> void:
	_change_state(State.END)

func _total_dice() -> int:
	var _tot := 0
	for d in dice:  
		if d.value == 6:
			_tot -= 6
		else:
			_tot += d.value
	return max(0,_tot)	

func _change_state(next_state:State) -> void:
	previous_state = current_state	
	current_state = next_state

func _state_string(which:String="current") -> String:
	var idx
	if which == "current":
		idx = current_state
	elif which == "previous":
		idx = previous_state
		
	return ["INIT","IDLE","ROLLING",
			"USER_CHOICE","LAST_ROLL",
			"END","USER_ROLL_SECOND_SET"][idx]
