extends Projectile2D

@export var explosionScene: PackedScene

func _ready() -> void:
	set_damage(5.0)
	set_speed(400)
	set_lifetime(3.0)
	timer.wait_time = lifetime
	timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Floor":
		body.queue_free()
	queue_free()
	var explosionInstance = explosionScene.instantiate()
	explosionInstance.position = position
	explosionInstance.rotation = rotation
	explosionInstance.explode()
	get_tree().current_scene.add_child(explosionInstance)
