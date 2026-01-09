extends Projectile2D

func _ready() -> void:
	set_damage(5.0)
	set_speed(1500)
	set_lifetime(3.0)
	timer.wait_time = lifetime
	timer.start()
