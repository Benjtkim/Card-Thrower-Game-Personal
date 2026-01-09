extends Control

@onready var deck: Deck = preload("res://Resources/PlayerDeck.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _process(delta: float) -> void:
	update_slots()

func update_slots():
	for i in range(slots.size()):
		slots[i].update(deck.get_card(i))
		
