extends Node

@export var mob_secene: PackedScene

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	# restart()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$scoreTimer.stop()
	$mobTimer.stop()
	$HUD.gameOver_message()

func restart():
	score = 0
	$Player.start($StartPosition.position)
	$startTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("GET READY !")
	await get_tree().create_timer(1).timeout
	$HUD.show_message("GO !")


func _on_start_timer_timeout():
	$mobTimer.start()
	$scoreTimer.start()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_mob_timer_timeout():
	var mob = mob_secene.instantiate()
	var mab_spawn_location = get_node("MobPath/MobSpawnLocation")
	mab_spawn_location.progress_ratio = randf()
	
	var direction = mab_spawn_location.rotation + PI / 2;
	
	mob.position = mab_spawn_location.position;
	
	var velocity = Vector2(randf_range(150.0, 250), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

