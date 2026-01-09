extends Projectile2D

@export var knife: PackedScene

func _ready() -> void:
	set_damage(0.0)
	set_speed(200)
	set_lifetime(2.0)
	timer.wait_time = lifetime
	timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		queue_free()
	if body is Projectile2D:
		if body.name == "Blank_Card":
			var knife_proj = knife.instantiate()
			knife_proj = knife_proj as Projectile2D
			knife_proj.position = position
			knife_proj.direction = direction
			knife_proj.projectile_owner = projectile_owner
			get_tree().current_scene.add_child(knife_proj)
		body.queue_free()
