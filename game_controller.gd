extends Node



enum State {START, IDLE, SETUP_TURN}
func _state_string(which:String="current") -> String:
	var idx
	if which == "current":
		idx = current_state
	#elif which == "previous":
		#idx = previous_state
		
	return ["START","IDLE","SETUP_TURN"][idx]	
	

var Players:Array[PackedScene]

# preload all of the player flags
var country := {
	"australia": {"flag": preload("res://assets/icons/flags/australia-flag-button-square-icon-256.png"),
		"name":"australia",
		"label":"aus",
		},
	"bahamas": {"flag": preload("res://assets/icons/flags/bahamas-flag-button-square-icon-256.png"),
		"name":"bahamas",
		"label":"bah",
		},
	"brazil": {"flag": preload("res://assets/icons/flags/brazil-flag-button-square-icon-256.png"),
		"name":"brazil",
		"label":"bra",
		},
	"canada": {"flag": preload("res://assets/icons/flags/canada-flag-button-square-icon-256.png"),
		"name":"canada",
		"label":"can",
	},
	"estonia": {"flag": preload("res://assets/icons/flags/estonia-flag-button-square-icon-256.png"),
		"name":"estonia",
		"label":"est",
	},
	"france": {"flag": preload("res://assets/icons/flags/france-flag-button-square-icon-256.png"),
		"name":"france",
		"label":"fra",
	},
	"germany": {"flag": preload("res://assets/icons/flags/germany-flag-button-square-icon-256.png"),
		"name":"germany",
		"label":"ger",
	},
	"grenada": {"flag": preload("res://assets/icons/flags/grenada-flag-button-square-icon-256.png"),
		"name":"grenada",
		"label":"gre",
	},
	"netherlands": {"flag": preload("res://assets/icons/flags/netherlands-flag-button-square-icon-256.png"),
		"name":"netherlands",
		"label":"net",
	},
	"norway": {"flag": preload("res://assets/icons/flags/norway-flag-button-square-icon-256.png"),
		"name":"norway",
		"label":"nor",
	},
	"puerto": {"flag": preload("res://assets/icons/flags/puerto-rico-flag-button-square-icon-256.png"),
		"name":"puerto",
		"label":"pr",
	},
	"usa": {"flag": preload("res://assets/icons/flags/united-states-of-america-flag-button-square-icon-256.png"),
		"name":"usa",
		"label":"usa",
	},
	"spain": {"flag": preload("res://assets/icons/flags/spain-flag-button-square-icon-256.png"),
	"name":"spain",
	"label":"esp",
	},

}

var players := {}
var current_state: State
var Player := preload("res://scenes/player.tscn")
var Game : Node
var turn_idx := 0
var current_player = null

var events
var event_idx := 0


func _ready():
	#temporary data to test somethings 
	#Players.append()
	print("{READY} This is the Singleton GameController!")

	

func add_player(country_name:String) -> Node:
	print("calling add player with: country = " + country_name)
	#var plyr = players[country]
	if not players.has(country_name):
		print("\t add_player should be creating a new player")
		var new_player = Player.instantiate()
		new_player.flag = country[country_name]["flag"]
		new_player.country = country_name
		players[country_name] = new_player
		#print("\t new player node" + str(new_player))
		#Game.add_child(new_player)
		#return new_player
	
	return players[country_name]
	
func _process(_delta: float) -> void:
	if Input.is_action_just_released("left_mouse"):
		Game.get_child(0).visible = true
		#add_player("spain")
	
	if current_state == State.START:
		# select the event or something?
		pass
	elif current_state == State.IDLE:
		pass

	elif current_state == State.SETUP_TURN:
		current_player = players[turn_idx]
		pass 
