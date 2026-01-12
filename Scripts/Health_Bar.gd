extends ProgressBar

@onready var Apple_Boss: Enemy2D = get_parent()
var maxHealth
var health

func _ready() -> void: 
	max_value = Apple_Boss.health

func _physics_process(delta: float) -> void:
	health = Apple_Boss.health
	value = health
	
