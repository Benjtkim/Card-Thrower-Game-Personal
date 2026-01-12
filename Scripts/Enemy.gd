extends CharacterBody2D
class_name Enemy2D

var health: float 
var speed: float 

func set_health(newHealth: float):
	health = newHealth

func set_speed(newSpeed: float):
	speed = newSpeed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Projectile2D:
		pass
	else:
		body.queue_free()
		health -= body.damage
		if health <= 0:
			queue_free()
