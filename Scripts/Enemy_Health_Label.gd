extends Label

@onready var Owner: Node2D = get_parent()

var maxHealth

func _ready():
	maxHealth = Owner.health
	text = "Health: " + str(maxHealth) + "/" + str(maxHealth)

func _physics_process(delta: float) -> void:
	text = "Health: " + str(Owner.health) + "/" + str(maxHealth)
