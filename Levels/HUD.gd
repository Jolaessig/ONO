extends CanvasLayer

var coins = 0

func _ready():
	$Coins.text = str(coins)


func _on_coin_collected():
	coins = coins + 1
	_ready()
