extends Area2D

export (PackedScene) var collect_particles

func _on_Coin_body_entered(body):
	if !body.is_in_group("players"): return

	Global.increment_score()
	SoundManager.playSFX("CoinCollect")
	if collect_particles:
		var particles = collect_particles.instance()
		get_parent().add_child(particles)
		particles.emitting = true
		particles.global_position = global_position
	queue_free()
	pass # Replace with function body.
