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
		queue_free()
		


func _on_body_entered(body: Node2D) -> void:
	if is_dead:
		return  # 直接忽略已死亡状态下的碰撞
	if body is CharacterBody2D:
		if !body.is_game_over:
			body.game_over()


func _on_area_entered(area: Area2D) -> void:
	if is_dead:
		return  # 直接忽略已死亡状态下的碰撞
	if area.is_in_group("bullet") and !is_dead:
		area.queue_free()
		get_tree().current_scene.score += 1
		is_dead = true #不再移动
		$CollisionShape2D.disabled = true
		$AnimatedSprite2D.play("death")
		$AudioStreamPlayer.play()
		await get_tree().create_timer(0.5).timeout
		queue_free()
