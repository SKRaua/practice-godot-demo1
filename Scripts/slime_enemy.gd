extends Area2D

@export var slime_speed: float = -50
var i: int = 0
var is_dead: bool = false
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_dead: 
		position += Vector2(slime_speed,0) * delta
	
	if position.x > 250 or position.x < -250:
		print("d a b e")
		queue_free()
		


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.game_over()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		area.queue_free()
		get_tree().current_scene.score += 1
		$AnimatedSprite2D.play("death")
		is_dead = true #不再移动
		await get_tree().create_timer(0.5).timeout
		queue_free()
