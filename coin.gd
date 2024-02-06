extends Area2D
signal dingle
func _ready():
	$AnimatedSprite2D.play("default")


func _on_body_entered(body):
	print(body.get_class())
	if body is Player:
		emit_signal("dingle")
		queue_free()
