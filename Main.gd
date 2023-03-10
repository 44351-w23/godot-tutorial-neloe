extends Node

var score
export (PackedScene) var mob_scene

func _ready():
	randomize()
	#new_game()
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$Music.stop()
	$DeathSound.play()
	$HUD.show_game_over()
	
func new_game():
	get_tree().call_group('mobs', 'queue_free')
	score = 0
	$Music.play()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	var mob_spawn_location = get_node("MobPath/MobSpawnPoint")
	mob_spawn_location.offset = randi()
	mob.position = mob_spawn_location.position
	var direction = mob_spawn_location.rotation + PI/2
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
