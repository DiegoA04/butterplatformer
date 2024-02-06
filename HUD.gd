extends CanvasLayer
var money: int = 0 :
	set(value):
		GameState.playerMoola = value
	get:
		return GameState.playerMoola
	

# Called when the node enters the scene tree for the first time.
func _ready():
	change_Moola(0) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_Moola(val):
	money += val
	$coinCount.text = "Fortnite V-Bucks: " + str(money)
