extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var FireTimer = $FireCooldown
@export var blank_card: PackedScene
@export var knife_card: PackedScene

# Movement support.
const gravity = 200.0
const walkSpeed = 200
const jumpVelocity = -350

#Shooting support.
var lookAngle
var canShoot = true
var count := 0
@export var deck: Deck
var deckCounter: int = 0

func _physics_process(delta):
	velocity.y += delta * gravity
	
	# Gets the direction player projectiles should travel in:
	# Mouse position in viewport coordinates.
	var mouse_position = get_viewport().get_mouse_position()
	# Players position in viewport coordinates.
	var player_viewport_position = get_global_transform_with_canvas().origin
	lookAngle = (mouse_position - player_viewport_position).angle()
	
	if Input.is_action_pressed("fire") and canShoot:
		_handle_fire()

	if velocity.x < 0:
		sprite.flip_h = true 
	elif velocity.x > 0:
		sprite.flip_h = false 

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity
		
	# Makes it so that the jumping doesn't feel as floaty and
	# allows for different jump heights depending on how long the spacebar
	# is pressed.
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = jumpVelocity / 4.0

	if Input.is_action_pressed("left"):
		velocity.x = -walkSpeed
	elif Input.is_action_pressed("right"):
		velocity.x =  walkSpeed
	else:
		velocity.x = 0

	# "move_and_slide" already takes delta time into account.
	move_and_slide()

func _handle_fire():
	canShoot = false
	FireTimer.start()
	var currCard: Card = deck.get_card(deckCounter)
	if currCard == null:
		currCard = deck.get_card(0)
		deckCounter = 0
	var currCardName: String = currCard.name
	if currCardName == "Knife_Card":
		var knife_card_proj = knife_card.instantiate()
		knife_card_proj = knife_card_proj as CharacterBody2D
		knife_card_proj.position = position
		knife_card_proj.direction = Vector2.from_angle(lookAngle)
		knife_card_proj.projectile_owner = self
		get_tree().current_scene.add_child(knife_card_proj)
		deckCounter = deckCounter + 1
	elif currCardName == "Blank_Card": 
		var blank_card_proj = blank_card.instantiate()
		blank_card_proj = blank_card_proj as CharacterBody2D
		blank_card_proj.position = position
		blank_card_proj.direction = Vector2.from_angle(lookAngle)
		blank_card_proj.projectile_owner = self
		get_tree().current_scene.add_child(blank_card_proj)
		deckCounter = deckCounter + 1

func _on_fire_cooldown_finish() -> void:
	canShoot = true 
