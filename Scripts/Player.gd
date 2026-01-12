extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var FireTimer = $FireCooldown

# Movement support.
const walkSpeed = 200
const jumpVelocity = -350

#Shooting support.
var lookAngle
var canShoot = true
var shotCount: int = 0
@export var deck: Deck
var deckCounter: int = 0

func _ready() -> void:
	deck.get_card(deckCounter).isBordered = true

func _physics_process(delta):
	
	# Related to left/right movement:
	if Input.is_action_pressed("left"):
		velocity.x = -walkSpeed
	elif Input.is_action_pressed("right"):
		velocity.x =  walkSpeed
	else:
		velocity.x = 0
	move_and_slide() # "move_and_slide" takes delta time into account.
	
	# Makes sure the player's sprite is always facing the correct 
	# direction.
	if velocity.x < 0:
		sprite.flip_h = true 
	elif velocity.x > 0:
		sprite.flip_h = false 
	
	# Related to jumping:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity
		
	# Makes it so that the jumping doesn't feel as floaty and
	# allows for different jump heights depending on how long the spacebar
	# is pressed.
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = jumpVelocity / 4.0
	
	velocity += delta * get_gravity()
	
	# Related to shooting:
	
	# Gets the direction the projectiles the player shoots should 
	# travel in:
	# Mouse position in viewport coordinates.
	var mouse_position = get_viewport().get_mouse_position()
	
	# Players position in viewport coordinates.
	var player_viewport_position = get_global_transform_with_canvas().origin
	lookAngle = (mouse_position - player_viewport_position).angle()
	
	if Input.is_action_pressed("fire") and canShoot:
		_handle_fire()

func _handle_fire():
	canShoot = false
	FireTimer.start()
	var currCard: Card = deck.get_card(deckCounter)
	if currCard == null:
		deckCounter = 0
		currCard = deck.get_card(deckCounter)
	var proj = currCard.projectileScene.instantiate()
	proj = proj as Projectile2D
	proj.position = position
	proj.direction = Vector2.from_angle(lookAngle)
	proj.projectile_owner = self
	get_tree().current_scene.add_child(proj)
	deck.get_card(deckCounter).isBordered = false
	deckCounter += 1
	if deck.get_card(deckCounter) == null:
		deck.get_card(0).isBordered = true
	else:
		deck.get_card(deckCounter).isBordered = true

func _on_fire_cooldown_finish() -> void:
	canShoot = true 
