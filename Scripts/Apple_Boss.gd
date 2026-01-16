extends Enemy2D

@onready var movementTimer := $MovementTimer
@onready var fireTimer := $FireCooldown
@export var bigAppleBomb: PackedScene
var direction = 1
var playerPosition: Vector2
var gravity: float = 200.0

func _init() -> void:
	set_health(10)

func _ready() -> void:
	movementTimer.wait_time = 2.0
	movementTimer.start()
	fireTimer.wait_time = 4.0
	fireTimer.start()
	set_health(10.0)
	set_speed(80.0)
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

# Code from https://www.youtube.com/watch?v=_kA1fbBH4ug. Don't think it works
# for this particular application.
#func calculate_arc_velocity(source_position, target_position, \
	#arc_height, gravity):
	#var proj_velocity = Vector2()
	#
	#var displacement = target_position - source_position
	#
	#if displacement.y > arc_height:
		#var time_up = sqrt(-2 * arc_height / float(gravity))
		#var time_down = sqrt(2 * (displacement.y - arc_height) / \
			#float(gravity))
		#
		#proj_velocity.y = -sqrt(-2 * gravity * arc_height)
		#proj_velocity.x = displacement.x / float(time_up)
		#
	#return proj_velocity
	
func shoot(player_position):
	#var arc_height = player_position.y - global_position.y - 100
	#var proj_velocity = calculate_arc_velocity(global_position, \
		#player_position, arc_height, gravity)
	var bigBombProj = bigAppleBomb.instantiate()
	bigBombProj = bigBombProj as Projectile2D
	bigBombProj.position = global_position
	bigBombProj.velocity = playerPosition - global_position
	#bigBombProj.velocity = proj_velocity
	bigBombProj.projectile_owner = self
	get_tree().current_scene.add_child(bigBombProj)
	print(bigBombProj.velocity)

func _on_movement_timer_timeout() -> void:
	reverse_direction()

func _on_fire_cooldown_timeout() -> void:
	shoot(playerPosition) # Replace with function body.

func _on_player_current_position(position: Variant) -> void:
	playerPosition = position
