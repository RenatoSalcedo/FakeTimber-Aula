extends Node2D

onready var idle = get_node("Idle")
onready var bate = get_node("Bate")
onready var animation = get_node("AnimBate")
onready var lapide = get_node("Lapide")

var lado
const DIR = 1
const ESQ = 0

func _ready():
	pass

func esq():
	position = Vector2(220, 1070)
	idle.set_flip_h(false)
	bate.set_flip_h(false)
	
	lapide.position = Vector2(-44, 41)
	lapide.set_flip_h(true)
	lado = ESQ

func dir():
	position = Vector2(500, 1070)
	idle.set_flip_h(true)
	bate.set_flip_h(true)
	
	lapide.position = Vector2(28, 41)
	lapide.set_flip_h(false)
	lado = DIR

func bater():
	animation.play("AnimBate")

func morrer():
	animation.stop()
	idle.hide()
	bate.hide()
	lapide.show()