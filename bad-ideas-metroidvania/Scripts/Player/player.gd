extends CharacterBody2D

# Node References
@onready var player_sprite: AnimatedSprite2D = $PlayerSprite

#Constants
const SPEED = 300.0
const JUMP_VELOCITY = -520.0

func _ready() -> void:
	add_to_group("player")
	if RoomChangeGlobal.activate:
		global_position = RoomChangeGlobal.playerPos
		if RoomChangeGlobal.playerJumpOnEnter:
			velocity.y = JUMP_VELOCITY
		RoomChangeGlobal.activate = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			player_sprite.scale = Vector2(1.0, -1.0)
			player_sprite.rotation_degrees = 180.0
		elif direction > 0:
			player_sprite.scale = Vector2(1.0, 1.0)
			player_sprite.rotation_degrees = 0.0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
