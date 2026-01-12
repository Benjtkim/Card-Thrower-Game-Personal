extends Projectile2D

@export var explodingKnifeCard: PackedScene

func _ready() -> void:
	set_damage(0.0)
	set_speed(300)
	set_lifetime(2.0)
	timer.wait_time = lifetime
	timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		queue_free()
	if body is Projectile2D:
		if body.name == "Explosion_Card":
			var explodeKnifeCardInstance = explodingKnifeCard.instantiate()
			explodeKnifeCardInstance = explodeKnifeCardInstance as Projectile2D
			explodeKnifeCardInstance.position = position
			explodeKnifeCardInstance.direction = direction
			explodeKnifeCardInstance.projectile_owner = projectile_owner
			get_tree().current_scene.add_child(explodeKnifeCardInstance)
		body.queue_free()
