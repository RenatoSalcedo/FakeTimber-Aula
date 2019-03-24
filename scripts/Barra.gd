extends Node2D

onready var mark = get_node("Preenchimento")
var perct = 1

var larg = 188
var alt = 23

signal perdeu

func _ready():
	set_process(true)

func _process(delta):
	if perct > 0:
		perct -= 0.15 * delta
		mark.set_region_rect(Rect2(0, 0, perct * larg, alt))
		mark.position = Vector2(-(1-perct)*larg/2, 0)
	else:
		emit_signal("perdeu")

func increase(delta):
	perct += delta
	if perct > 1: perct = 1