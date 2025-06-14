extends CharacterBody2D

@export var move_speed: float = 80
@export var animator: AnimatedSprite2D
@export var bullet_scene: PackedScene 


var is_game_over: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hello")
	#velocity = Vector2(50,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#print(Input.get_vector("left", "right", "up", "down"))
	
	if is_game_over == false:
		velocity = Input.get_vector("left", "right", "up", "down") * move_speed
		
		if velocity == Vector2.ZERO:
			animator.play("idle")
		else:
			animator.play("run")
		 
		move_and_slide() 
	
func game_over():
	is_game_over = true
	animator.play("game_over")
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()
	

func _on_fire() -> void:
	if velocity != Vector2.ZERO or is_game_over:
		return
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2(6,6)
	get_tree().current_scene.add_child(bullet_node)
	
