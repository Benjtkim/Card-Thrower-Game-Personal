extends Resource

class_name Deck

@export var deck: Array[Card]

func get_card(index: int):
	return deck[index]
