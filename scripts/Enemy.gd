extends CharacterBody2D


enum SlimeState { Idle, Chase, Attack }

var currentState = SlimeState.Idle

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentState == SlimeState.Chase:
		print("Slime")
		print(global_position.x)
		print("Player")
		print(get_node("/root/World/Player").position.x)
		if get_node("/root/World/Player").position.x < global_position.x:
			velocity.x = -15
		elif get_node("/root/World/Player").position.x > global_position.x:
			velocity.x = 15
		if get_node("/root/World/Player").position.y < global_position.y:
			velocity.y = -15
		elif get_node("/root/World/Player").position.y > global_position.y:
			velocity.y = 15
	else:
		velocity = Vector2.ZERO
	if currentState == SlimeState.Attack:
		velocity = Vector2.ZERO
	
	move_and_slide()


func _on_detection_radius_body_entered(body):
	if body.name == "Player":
		currentState = SlimeState.Chase
		print("Player entered the radius")

func _on_detection_radius_body_exited(body):
	if body.name == "Player":
		currentState = SlimeState.Idle
		print("Player left the radius")


func _on_attack_radius_body_entered(body):
	if body.name == "Player":
		currentState = SlimeState.Attack
		print("Player entered the radius")
		

func _on_attack_radius_body_exited(body):
	if body.name == "Player":
		currentState = SlimeState.Chase
		print("Player exited the radius")
