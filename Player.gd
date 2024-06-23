extends CharacterBody2D

const SPEED = 1000.0
const interval = 5
var elapsed = 0

func _ready():
	PlayerVariables.set_hud(%HUD)
	
	%Fog.update_pos(position.x, position.y)

func _physics_process(delta):
	elapsed += delta
	if(elapsed > interval):
		elapsed = 0
		PlayerVariables.update_anxiety()
	
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	
	if velocity.x != 0 || velocity.y != 0:
		%Fog.update_pos(position.x, position.y)

	move_and_slide()
