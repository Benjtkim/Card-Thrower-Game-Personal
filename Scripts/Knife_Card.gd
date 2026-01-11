extends Projectile2D

@export var explodingKnife: PackedScene

func _ready() -> void:
	set_damage(0.0)
	set_speed(500)
	set_lifetime(2.0)
	timer.wait_time = lifetime
	timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		queue_free()
	if body is Projectile2D:
		if body.name == "Explosion_Card":
			var explodeKnifeInstance = explodingKnife.instantiate()
			explodeKnifeInstance = explodeKnifeInstance as Projectile2D
			explodeKnifeInstance.position = position
			explodeKnifeInstance.direction = direction
			explodeKnifeInstance.projectile_owner = projectile_owner
			get_tree().current_scene.add_child(explodeKnifeInstance)
		body.queue_free()
