extends CharacterBody2D

@export var ghost_node: PackedScene
@onready var flip = $flip
@onready var animations = $flip/animations
@onready var trail = $flip/trail
@onready var foot_steps = $sounds/footSteps
@onready var simple_jump = $sounds/simpleJump
@onready var footstep_timer = $Timers/StepTimer
@onready var dash_sound = $sounds/dashSound
@onready var dash_timer = $Timers/DashTimer
@onready var running = $sounds/running
@onready var progress_bar = $ProgressBar
@onready var health_bar = $Control/HealthBar
@onready var wait_timer = $Timers/WaitTimer
@onready var animation_player = $AnimationPlayer
@onready var landing = $flip/landing
@onready var wall_impact = $flip/wallImpact
@onready var ghosting_timer = $Timers/GhostingTimer
@onready var death_impact = $flip/deathImpact
@onready var death_timer = $Timers/DeathTimer
@onready var camera_2d = $Camera2D

const SPEED = 300
const JUMP_VELOCITY = -630.0
const ACCELERATION = 3500
const FRICTION = 4000
const DASH_COST = 25
const DASH_RECOVER_TIME = 4
const MAX_DASH_POWER = 100
const MAX_HEALTH = 100
const JUMP_DAMAGE = 5
const HEALTH_RECOVER_TIME = 1.5
const FALL_GRAVITY_MULTIPLIER = 1.5
const COYOTE_TIME = 0.5
const WALL_SLIDE_SPEED = 2
const UPWARD_DASH_SPEED = -500
const CEILING_STICK_SPEED = 80
const MAX_JUMPS = 2


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dashing = false
var dash_direction = 0
var dash_power = MAX_DASH_POWER
var health = MAX_HEALTH
var is_landing = false
var time_since_last_health_recover = 0.0
var coyote_time_left = 0.0
var is_wall_sticking = false
var is_ceiling_sticking = false
var wall_impact_played = false
var has_jumped = false
var count_down = 0.0
var is_dead = false
var current_jumps = 0  # New variable to track current jumps

func _ready():
	# Timer settings
	dash_timer.wait_time = 0.5
	dash_timer.one_shot = true

	# Initialize ghosting timer settings
	ghosting_timer.wait_time = 0.1  # Adjust the interval as needed
	ghosting_timer.one_shot = false

	# Initialize progress bar for dash power
	progress_bar.max_value = MAX_DASH_POWER
	progress_bar.value = dash_power

	# Initialize health bar
	health_bar.max_value = MAX_HEALTH
	health_bar.value = health

func _physics_process(delta):
	if is_dead:
		return

	var direction = Input.get_axis("go_left", "go_right")
	apply_gravity(delta)
	handle_wall_and_ceiling_stick(delta, direction)
	handle_jumps(delta)
	flip_character(direction)
	apply_movement(direction, delta)
	update_animations_and_sounds(direction)
	handle_dash(delta)
	recover_dash_power(delta)
	recover_health(delta)
	move_and_slide()
	check_landing()

func apply_gravity(delta):
	if not is_on_floor() and not is_wall_sticking and not is_ceiling_sticking:
		velocity.y += gravity * FALL_GRAVITY_MULTIPLIER * delta
	else:
		velocity.y += gravity * delta

func handle_jumps(delta):
	if is_on_floor():
		coyote_time_left = COYOTE_TIME
		has_jumped = false  # Reset jump status when on the floor
		current_jumps = 0  # Reset jump count when on the floor
	else:
		coyote_time_left -= delta

	if Input.is_action_just_pressed("go_jump"):
		if (coyote_time_left > 0 and not has_jumped) or is_wall_sticking or is_ceiling_sticking or current_jumps < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			simple_jump.play()
			landing.play("default")
			is_landing = false
			if not is_wall_sticking and not is_ceiling_sticking:
				has_jumped = true  # Mark that the character has jumped on the ground
				current_jumps += 1  # Increment jump count

	if Input.is_action_just_released("go_jump") and velocity.y < JUMP_VELOCITY / 3:
		velocity.y = JUMP_VELOCITY / 3

func check_landing():
	if is_on_floor() and not is_landing:
		is_landing = true
		take_damage(JUMP_DAMAGE)

func flip_character(direction):
	if direction > 0:
		flip.scale.x = 1
	elif direction < 0:
		flip.scale.x = -1

func apply_movement(direction, delta):
	if direction != 0:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

func update_animations_and_sounds(direction):
	if dashing:
		animations.play("mainRun")
	elif is_wall_sticking or is_ceiling_sticking:
		animations.play("WallSlide")  # Use the same animation for wall and ceiling stick for now
	elif not is_on_floor():
		animations.play("balljump")
	elif direction != 0:
		animations.play("mainRun")
		if footstep_timer.is_stopped():
			foot_steps.play()
			footstep_timer.start(0.35)
	else:
		animations.play("MainIdle1")

func handle_dash(delta):
	if Input.is_action_just_pressed("dash") and not dashing and dash_timer.is_stopped() and dash_power >= DASH_COST:
		dashing = true
		dash_power -= DASH_COST
		progress_bar.value = dash_power
		if is_wall_sticking and Input.is_action_pressed("go_jump"):
			velocity.y = UPWARD_DASH_SPEED
			velocity.x = 0
		elif is_ceiling_sticking and Input.is_action_pressed("go_jump"):
			velocity.y = UPWARD_DASH_SPEED
			velocity.x = 0
		elif is_wall_sticking or is_ceiling_sticking:
			velocity.y = UPWARD_DASH_SPEED
			velocity.x = 0
		else:
			dash_direction = 1 if flip.scale.x > 0 else -1
			velocity.x = SPEED * 8 * dash_direction
		dash_sound.play()
		dash_timer.start()
		ghosting_timer.start()
		trail.emitting = true
		trail.restart()

	if dashing:
		velocity.x = move_toward(velocity.x, SPEED * dash_direction, ACCELERATION * 2 * delta)
		if abs(velocity.x) <= SPEED:
			dashing = false
			trail.emitting = false
			ghosting_timer.stop()

func handle_wall_and_ceiling_stick(delta, _direction):
	is_wall_sticking = false
	is_ceiling_sticking = false
	if is_on_wall() and not is_on_floor() and velocity.y > 0:
		is_wall_sticking = true
		velocity.y = move_toward(velocity.y, WALL_SLIDE_SPEED, ACCELERATION * delta)
		if not wall_impact_played:
			wall_impact.emitting = true
			wall_impact.restart()
			wall_impact_played = true
	elif is_on_ceiling() and not is_on_floor():
		is_ceiling_sticking = true
		velocity.y = move_toward(velocity.y, CEILING_STICK_SPEED, ACCELERATION * delta)
		if not wall_impact_played:
			wall_impact.emitting = true
			wall_impact.restart()
			wall_impact_played = true
	else:
		wall_impact_played = false
		wall_impact.emitting = false

func recover_dash_power(delta):
	if dash_power < MAX_DASH_POWER:
		dash_power += (MAX_DASH_POWER / DASH_RECOVER_TIME) * delta
		dash_power = clamp(dash_power, 0, MAX_DASH_POWER)
		progress_bar.value = dash_power

func recover_health(delta):
	time_since_last_health_recover += delta
	if time_since_last_health_recover >= HEALTH_RECOVER_TIME:
		health += 5
		health = clamp(health, 0, MAX_HEALTH)
		health_bar.value = health
		time_since_last_health_recover = 0.0

func take_damage(amount):
	health -= amount
	health = clamp(health, 0, MAX_HEALTH)
	health_bar.value = health
	if health <= 0:
		die()

func die():
	if is_dead:
		return  # Prevent multiple death triggers

	is_dead = true
	death_impact.emitting = true
	death_timer.start(1.0)

func knockback(direction: Vector2, force: float):
	velocity += direction.normalized() * force

func _on_wait_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/pause_menu.tscn")

func _on_death_timer_timeout():
	get_tree().reload_current_scene()
