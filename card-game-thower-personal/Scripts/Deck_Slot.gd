extends Panel

@onready var card_visual: Sprite2D = $CenterContainer/Panel/Card_Display

func update(card: Card):
	if !card:
		card_visual.visible = false
	else:
		card_visual.visible = true
		if card.isBordered:
			card_visual.texture = card.textureBordered
		else:
			card_visual.texture = card.texture
