extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var speed: float = 130.0

var direction := Vector2.ZERO
var last_direction := Vector2.DOWN
var status = PlayerState.Idle

enum PlayerState {
	Idle,
	Walk
}

func _ready():
	go_to_idle_state()

func _physics_process(_delta: float) -> void:
	move()
			
	match status:
		PlayerState.Idle:
			idle_state()
		PlayerState.Walk:
			walk_state()
	
	move_and_slide()
	
	
	
func go_to_idle_state():
	status = PlayerState.Idle
	update_animation()
	if last_direction == Vector2.DOWN:
		animated_sprite_2d.play("Idle_D")
	elif last_direction == Vector2.UP:
		animated_sprite_2d.play("Idle_U")
	elif last_direction	 == Vector2.RIGHT:
		animated_sprite_2d.play("Idle_R")
	elif last_direction == Vector2.LEFT:
		animated_sprite_2d.play("Idle_L")
		
func idle_state():
	move()
	upd_direction()
	if direction != Vector2.ZERO:
		go_to_walk_state()
		return
		

func walk_state():
	move()
	if direction == Vector2.ZERO:
		go_to_idle_state()
		return
	
func go_to_walk_state():
	status = PlayerState.Walk

	if last_direction == Vector2.DOWN:
		animated_sprite_2d.play("Walk_D")
	elif last_direction == Vector2.UP:
		animated_sprite_2d.play("Walk_U")
	elif last_direction == Vector2.RIGHT:
		animated_sprite_2d.play("Walk_R")
	elif last_direction == Vector2.LEFT:
		animated_sprite_2d.play("Walk_L")

func move():
	direction.x = Input.get_axis("Left", "Right")
	direction.y = Input.get_axis("Up", "Down")
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		upd_direction()
		update_animation()
	
	velocity = direction * speed
	
	
func upd_direction():
	if Input.is_action_just_pressed("Left"):
		last_direction = Vector2.LEFT
	elif Input.is_action_just_pressed("Right"):
		last_direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("Up"):
		last_direction = Vector2.UP
	elif Input.is_action_just_pressed("Down"):
		last_direction = Vector2.DOWN
		
func update_animation():
	if status == PlayerState.Idle:
		if last_direction == Vector2.DOWN:
			animated_sprite_2d.play("Idle_D")
		elif last_direction == Vector2.UP:
			animated_sprite_2d.play("Idle_U")
		elif last_direction == Vector2.LEFT:
			animated_sprite_2d.play("Idle_L")
		elif last_direction == Vector2.RIGHT:
			animated_sprite_2d.play("Idle_R")

	elif status == PlayerState.Walk:
		if last_direction == Vector2.DOWN:
			animated_sprite_2d.play("Walk_D")
		elif last_direction == Vector2.UP:
			animated_sprite_2d.play("Walk_U")
		elif last_direction == Vector2.LEFT:
			animated_sprite_2d.play("Walk_L")
		elif last_direction == Vector2.RIGHT:
			animated_sprite_2d.play("Walk_R")
	
