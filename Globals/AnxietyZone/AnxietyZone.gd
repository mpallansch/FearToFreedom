extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if has_meta("width") && has_meta("height"):
		%CollisionShape2D.shape.extents = Vector2(get_meta("width"), get_meta("height"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if has_meta("priority") && has_meta("drain"):
		PlayerVariables.add_zone(get_instance_id(), get_meta("priority"), get_meta("drain"))


func _on_area_2d_body_exited(body):
	if has_meta("priority") && has_meta("drain"):
		PlayerVariables.remove_zone(get_instance_id())
