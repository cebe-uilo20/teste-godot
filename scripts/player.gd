extends CharacterBody2D


@export var speed: float = 200.0


func _physics_process(_delta: float) -> void:
	var direction := Vector2.ZERO
	
	direction.x = Input.get_axis("Left", "Right")
	direction.y = Input.get_axis("Up", "Down")
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		
	velocity = direction * speed
	
	move_and_slide()
