extends Node

var Breath_count : float = 100
var Is_Breathing : bool = false

var Night : int = 1
var SleepyCount : int = 0

func PSFX(stream: AudioStream):
	var asp = AudioStreamPlayer.new()
	add_child(asp)
	asp.stream = stream
	asp.finished.connect(asp.queue_free) # Delete the node when done
	asp.play()
