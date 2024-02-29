extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var inputX = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var inputY = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var inputA = Input.get_action_strength("ui_accept")
	velocity.x = inputX*40
	velocity.y = -inputY*40
	move_and_slide()
	
	if velocity.x != 0 || velocity.y != 0:
		$AnimationTree.set("parameters/Walk/blend_position",Vector2(inputX,inputY))
		$AnimationTree.set("parameters/Attack/blend_position",Vector2(inputX,inputY))
		$AnimationTree.set("parameters/Idle/Idle/blend_position",Vector2(inputX,inputY))
		$AnimationTree.get("parameters/playback").travel("Walk")
		if inputA:
			$AnimationTree.get("parameters/playback").travel("Attack")
		
	else:
		$AnimationTree.get("parameters/playback").travel("Idle")
		if inputA:
			$AnimationTree.get("parameters/playback").travel("Attack")
		

