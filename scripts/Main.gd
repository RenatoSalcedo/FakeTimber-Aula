extends Node

var barril = preload("res://scene/Barril.tscn")
var barrilDir = preload("res://scene/BarrilDir.tscn")
var barrilEsq = preload("res://scene/BarrilEsq.tscn")

onready var bixin = get_node("Bixin")
onready var cam = get_node("Camera")
onready var barris = get_node("Barris")
onready var destroy = get_node("DestroyBarris")
onready var restart = get_node("TimerToRestart")
onready var barra = get_node("Barra")
onready var lblScore = get_node("Control/Score")

var enemy
var state
var score = 0

const JOGANDO = 1
const PERDEU = 2

func _ready():
	randomize()
	set_process_input(true)
	initialize()
	state = JOGANDO
	
	barra.connect("perdeu", self, "perder")

func _input(event):
	event = cam.make_input_local(event)
	if state == JOGANDO:
		if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.is_pressed():
			
			if event.position.x < 360:
				bixin.esq()
			else:
				bixin.dir()
			
			if !verifyCollision():
				bixin.bater()
				var barr = barris.get_children()[0]
				barris.remove_child(barr)
				destroy.add_child(barr)
				barr.destroy(bixin.lado)
				
				randBarril(Vector2(360, -630))
				descerBarris()
				
				barra.increase(0.028)
				score += 1
				lblScore.set_text(str(score))
				
				if verifyCollision():
					perder()
					
			else:
				perder()

func gerarBarril(tipo, pos):
	var nB
	
	if tipo == 0:
		nB = barril.instance()
		enemy = false
	elif tipo == 1:
		nB = barrilDir.instance()
		nB.add_to_group("barrilDir")
		enemy = true
	else:
		nB = barrilEsq.instance()
		nB.add_to_group("barrilEsq")
		enemy = true
		
	nB.position = pos
	barris.add_child(nB)

func randBarril(pos):
	var randN = rand_range(0, 3)
	if enemy: randN = 0
	
	gerarBarril(int(randN), pos)

func initialize():
	for i in range(0, 3):
		gerarBarril(0, Vector2(360, 1090 - i*172))
		
	for i in range(3, 10):
		randBarril(Vector2(360, 1090 - i*172))

func verifyCollision():
	var lado = bixin.lado
	var barr = barris.get_children()[0]
	
	return (lado == bixin.ESQ and barr.is_in_group("barrilEsq")) or (lado == bixin.DIR and barr.is_in_group("barrilDir"))

func descerBarris():
	for b in barris.get_children():
		b.position += Vector2(0, 172)

func perder():
	bixin.morrer()
	restart.start()
	state = PERDEU
	barra.set_process(false)

func _on_TimerToRestart_timeout():
	score = 0
	lblScore.set_text(str(score))
	state = JOGANDO
	get_tree().reload_current_scene()

