extends CharacterBody2D

var temp_velocity = Vector2.ZERO
const MAX_SPEED = 80
const ACCELLERATION = 200
const FRICTION = 70

var animationPlayer = null
var animationTree = null
var animationState = null


@onready var sprite = $Sprite2D


func _ready():
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationState = animationTree.get("parameters/playback")
	animationTree.active = true

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELLERATION * delta)
		#velocity += input_vector * ACCELLERATION * delta
		animationState.travel("Walk")
		velocity = velocity.clamp(-Vector2.ONE * MAX_SPEED, Vector2.ONE * MAX_SPEED)
	else:
		velocity =  velocity.move_toward(Vector2.ZERO, FRICTION)
		animationState.travel("Idle")
	move_and_slide()
