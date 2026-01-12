extends Enemy2D

func _init() -> void:
	set_health(10)

func _ready() -> void:
	set_health(10.0)
	set_speed(200.0)
	name = "Apple_Boss"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
