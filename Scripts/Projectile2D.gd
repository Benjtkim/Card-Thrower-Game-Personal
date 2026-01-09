extends CharacterBody2D
class_name Projectile2D

@onready var timer := $Timer
var speed
var direction
var projectile_owner: Node2D
var lifetime
var damage

func _ready() -> void:
	timer.wait_time = lifetime
	timer.start()

func _physics_process(_delta: float) -> void:
	rotation = direction.angle()
	velocity = direction.normalized() * speed
	move_and_slide()

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()
	
func set_lifetime(new_lifetime: float) -> void:
	lifetime = new_lifetime
	
func set_damage(new_damage: float) -> void:
	damage = new_damage
	
func set_speed(new_speed: float) -> void:
	speed = new_speed
	
