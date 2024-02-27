extends Node

var availableSFX : Array = []
var queueSFX : Array = []

var availableBGM = AudioStreamPlayer.new()
var savedBGM : String
var savedBGMTime : Array = []
var priorityBGM : Array = []

func _ready():
	# Always runs even when paused.
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Initializes available players for SFX.
	var num_playersSFX : int = 8
	
	for players in num_playersSFX:
		var playerSFX = AudioStreamPlayer.new()
		add_child(playerSFX)
		availableSFX.append(playerSFX)
		playerSFX.finished.connect(_on_SFX_finished.bind(playerSFX))
		playerSFX.bus = "SFX"
		
	# Initializes the BGM player.
	add_child(availableBGM)
	availableBGM.bus = "BGM"

func _on_SFX_finished(stream):
	# Clears player when finished playing SFX.
	availableSFX.append(stream)
	
func playSFX(filename : String):
	# Primary function to call for SFX.
	queueSFX.append(filename)

func playBGM(filename : String):
	# Primary function to call to put a BGM onto priority stack. The last called BGM will play. Will not accept BGM that is already on the stack.
	if priorityBGM.has(filename) : return
	if availableBGM.playing and priorityBGM.size() > 0 : savedBGMTime.push_back(availableBGM.get_playback_position()) 
	priorityBGM.append(filename)
	
func clearBGM():
	# Clears the latest BGM from the priority stack. Resumes next BGM if there is one.
	priorityBGM.pop_back()
	
func clearAllBGM():
	# Clears the entire BGM priority stack.
	savedBGMTime.clear()
	priorityBGM.clear()

func _process(_delta):
	# Plays queued sound when there is an available slot.
	if !queueSFX.is_empty() and !availableSFX.is_empty():
		availableSFX[0].stream = load(queueSFX.pop_front())
		availableSFX[0].play()
		availableSFX.pop_front()
	
	# Plays BGM on top of priority stack.
	if priorityBGM.back() != savedBGM:
		var previousTime : float = 0.0
		if priorityBGM.size() == savedBGMTime.size(): previousTime = savedBGMTime.pop_back()
		savedBGM = priorityBGM.back()
		availableBGM.stream = load(savedBGM)
		availableBGM.play(previousTime)
