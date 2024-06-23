extends CharacterBody2D

const SPEED = 1000.0
const interval = 5
var elapsed = 0
var direction_facing = "down"

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
		
		if velocity.x > 0:
			direction_facing = "right"
		elif velocity.x < 0:
			direction_facing = "left"
		elif velocity.y > 0:
			direction_facing = "down"
		elif velocity.y < 0:
			direction_facing = "up"
		
		if %AnimatedSprite2D.animation != str("run-", direction_facing):
			%AnimatedSprite2D.play(str("run-", direction_facing))
	else:
		if %AnimatedSprite2D.animation != str("idle-", direction_facing):
			%AnimatedSprite2D.play(str("idle-", direction_facing))

	move_and_slide()
