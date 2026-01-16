extends Projectile2D

func _ready() -> void:
	set_damage(10.0)
	set_lifetime(500.0)
	set_speed(500)
	timer.wait_time = lifetime
	timer.start()

func _physics_process(delta: float) -> void:
	#velocity += get_gravity() * delta
	#move_and_collide(velocity * delta)
	velocity = velocity.normalized() * speed
	move_and_slide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if !body.isInvincible:
			body.health -= damage
			body.tookDamage = true
	queue_free()
