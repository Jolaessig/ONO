extends CharacterBody2D

signal changed_hp(value: int)
signal changed_o2(value: float)
signal changed_h2o(value: float)

@export var ACCELERATION: int = 500
@export var MAX_SPEED: int = 120
@export var FRICTION: int = 1200
@export var INTERACTION_RANGE = 40

@export var HP: int = 100
@export var O2: float = 100
@export var H2O: float = 100

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get('parameters/playback')
@onready var take = %Take

var closest_object = null

var face_direction = Vector2.DOWN

func _ready():
	print('INIT--------------')
	process_priority = 10
	update_animation_parameters(Vector2(0,1))
	
func _physics_process(delta):
	handle_interaction_input()
	handle_movement_input(delta)
	
	O2 -= 0.1
	H2O -= 0.2
	changed_o2.emit(O2)
	changed_h2o.emit(H2O)

func handle_movement_input(delta):
	var input_direction = Vector2.ZERO
	input_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_direction = input_direction.normalized()
	if input_direction != Vector2.ZERO:
		update_animation_parameters(input_direction)
		velocity = velocity.move_toward(input_direction * MAX_SPEED, ACCELERATION * delta)
		state_machine.travel('Walk')
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		state_machine.travel('Idle')
	move_and_slide()

func update_animation_parameters(move_input: Vector2):
	animation_tree.set('parameters/Idle/blend_position', move_input)
	animation_tree.set('parameters/Walk/blend_position', move_input)
	
	face_direction = move_input

func handle_interaction_input():
	var nearby_objects = get_tree().get_nodes_in_group("interactable")

	closest_object = null
	var closest_distance = INTERACTION_RANGE

	for obj in nearby_objects:
		var distance = obj.global_position.distance_to(global_position)

		if distance < closest_distance:
			var AP = global_position.direction_to(obj.global_position)
			if AP.dot(face_direction) > 0:
				closest_distance = distance
				closest_object = obj

	take.visible = false

	if closest_object:
		take.visible = true
		take.global_position = closest_object.global_position - Vector2(0, 15)
		if Input.is_action_just_pressed("interact"):
			closest_object.interact()
