extends CanvasLayer

var coins = 0

func _ready():
	$Coins.text = str(coins)
	load_hearts()
	Global.hud = self

func _on_coin_collected():
	coins += 1
	$Coins.text = str(coins)
	load_hearts()

func load_hearts():
	$HeartsFull.size.x = Global.lives * 16
	if Global.lives < Global.max_lives:
		$HeartsEmpty.size.x = (Global.max_lives - Global.lives) * 16
		$HeartsEmpty.position.x = $HeartsFull.position.x + $HeartsFull.size.x * $HeartsFull.scale.x
	else:
		$HeartsEmpty.size.x = 0
		$HeartsEmpty.position.x = $HeartsFull.position.x - 16
