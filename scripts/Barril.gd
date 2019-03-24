extends Node2D

onready var animation = get_node("AnimeBarril")

const DIR = 1
const ESQ = 0

func _ready():
	pass 

func destroy(sentido):
	if sentido == DIR:
		animation.play("PraEsq")
	else:
		animation.play("PraDir")