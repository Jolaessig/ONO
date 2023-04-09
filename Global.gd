extends Node

var max_lives = 3
var lives = max_lives
var hud

func lose_life():
	lives -= 1
	hud.load

