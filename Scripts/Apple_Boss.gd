extends Enemy2D

@onready var timer := $Timer
@export var appleProjectile: PackedScene
var direction = 1

func _init() -> void:
	set_health(10)

func _ready() -> void:
	timer.wait_time = 2.0
	timer.start()
	set_health(10.0)
	set_speed(100.0)
	set_collision_damage(3)
	name = "Apple_Boss"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		move()
	move_and_slide()

func move():
	velocity.x = speed * direction
	
func reverse_direction():
	direction = -direction
	
func _on_timer_timeout() -> void:
	reverse_direction()
