extends Label

@export var Player: CharacterBody2D
var maxHealth

func _ready():
	maxHealth = Player.health
	text = "Health: " + str(maxHealth) + "/" + str(maxHealth)

func _physics_process(delta: float) -> void:
	text = "Health: " + str(Player.health) + "/" + str(maxHealth)
	
