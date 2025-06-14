extends Node2D

@export var slime_scene: PackedScene 
@export var spwan_timer: Timer 
@export var score: int = 0
@export var score_label: Label
@export var game_over_label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var slime_node = slime_scene.instantiate()
	slime_node.position = Vector2(240,randf_range(55,140))
	get_tree().current_scene.add_child(slime_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spwan_timer.wait_time -= 0.2 * delta
	spwan_timer.wait_time = clamp(spwan_timer.wait_time,0.4,3)
	
	score_label.text = "Score: " + str(score)

func _create_enemy() -> void:
	
	var slime_node = slime_scene.instantiate()
	#slime_node.position = Vector2(240, 55 + randi() % (140 - 55 + 1))
	slime_node.position = Vector2(240,randf_range(55,140))
	get_tree().current_scene.add_child(slime_node)

func show_game_over() -> void:
	game_over_label.visible = true
	$CanvasLayer/game_over_voice.play()
