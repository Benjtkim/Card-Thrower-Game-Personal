extends ProgressBar

@onready var Owner: Node2D = get_parent()
var maxHealth
var health

func _ready() -> void: 
	max_value = Owner.health

func _physics_process(delta: float) -> void:
	health = Owner.health
	value = health
	
