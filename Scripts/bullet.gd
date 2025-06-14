extends Area2D

@export var bullet_speed: float = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(bullet_speed,0) * delta
	if position.x > 250 or position.x < -250:
		queue_free()
