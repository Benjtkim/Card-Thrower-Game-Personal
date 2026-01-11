extends Projectile2D

@export var knife: PackedScene
@export var explosionScene: PackedScene

func _ready() -> void:
	set_damage(1.0)
	set_lifetime(1.0)
	set_speed(300)
	timer.wait_time = lifetime
	timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		queue_free()
	if body is Projectile2D:
		if body.name == "Knife_Card":
			var knife_proj = knife.instantiate()
			knife_proj = knife_proj as Projectile2D
			knife_proj.position = position
			knife_proj.direction = direction
			knife_proj.projectile_owner = projectile_owner
			get_tree().current_scene.add_child(knife_proj)
		if body.name == "Explosion_Card":
			var explosionInstance = explosionScene.instantiate()
			explosionInstance.position = body.position
			explosionInstance.rotation = body.rotation
			explosionInstance.explode()
			get_tree().current_scene.add_child(explosionInstance)
		body.queue_free()
