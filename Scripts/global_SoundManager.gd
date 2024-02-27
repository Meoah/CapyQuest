extends Node

var num_players : int = 8

var availableSFX : Array = []
var queueSFX : Array = []

func _ready():
	# Initialize available players for SFX
	for players in num_players:
		var playerSFX = AudioStreamPlayer.new()
		add_child(playerSFX)
		availableSFX.append(playerSFX)
		playerSFX.finished.connect(_on_stream_finished.bind(playerSFX))
		playerSFX.bus = "SFX"
		
	# Initialize three available players for BGM
	var playerBGM = AudioStreamPlayer.new()
	add_child(playerBGM)
	playerBGM.bus = "BGM"

func _on_stream_finished(stream):
	# Clears player when finished playing SFX
	availableSFX.append(stream)
	
func playSFX(filename):
	queueSFX.append(filename)

func playBGM(filename):
	pass

func _process(delta):
	# Plays queued sound when there is an available slot.
	if !queueSFX.is_empty() and !availableSFX.is_empty():
		availableSFX[0].stream = load(queueSFX.pop_front())
		availableSFX[0].play()
		availableSFX.pop_front()
