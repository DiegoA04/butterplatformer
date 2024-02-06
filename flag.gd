extends Area2D

var flagOut = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("no_Flag")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flagOut and not $AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("flag_Idle")


func _on_body_entered(body):
	print(body.get_class())
	if body is Player and not flagOut:
		$AnimatedSprite2D.play("flag_Out")
		flagOut = true
		body.respawnPoint = global_position
