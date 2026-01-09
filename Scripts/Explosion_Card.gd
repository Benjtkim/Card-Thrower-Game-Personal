extends Projectile2D

func _ready() -> void:
	set_damage(0.0)
	set_speed(800)
	set_lifetime(2.0)
	timer.wait_time = lifetime
	timer.start()
