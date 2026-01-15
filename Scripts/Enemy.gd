extends CharacterBody2D
class_name Enemy2D

var health: float 
var speed: float 
var collisionDamage: float
var isColliding: bool

func set_health(newHealth: float):
	health = newHealth

func set_speed(newSpeed: float):
	speed = newSpeed

func set_collision_damage(newCollisionDamage: float):
	collisionDamage = newCollisionDamage

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Projectile2D:
		body.queue_free()
		health -= body.damage
		if health <= 0:
			queue_free()
	elif body.name == "Player":
		if !body.isInvincible:
			body.health -= collisionDamage
			body.tookDamage = true
		body.isColliding = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.isColliding = false
