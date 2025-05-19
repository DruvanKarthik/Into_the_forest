extends CharacterBody2D

var enemy_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var attack_ip = false
const SPEED = 200.0
const JUMP_VELOCITY = -500.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	enemy_attack()
	attack()
	update_health_bar()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if health <=0:
		player_alive = false
		health = 0
		self.queue_free()
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

	if direction>0:
		animated_sprite.flip_h= false
	elif direction<0:
		animated_sprite.flip_h = true
	if is_on_floor():
		if direction == 0:
			if attack_ip == false:
				animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_attack_range=true
		

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_attack_range = false
func enemy_attack():
	if enemy_attack_range and enemy_attack_cooldown==true:
		health = health - 5
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
func _on_attack_colldown_timeout() -> void:
	enemy_attack_cooldown = true

func attack():
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		$AnimatedSprite2D.play("attack")
		$deal_attack_timer.start()
		
func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
   
func update_health_bar():
	var health_bar = $HealthBar
	health_bar.value = health
	if health_bar.value == 100:
		health_bar.visible = false
	else:
		health_bar.visible = true
func _on_region_timer_timeout() -> void:
	if health<100:
		health = health + 20
		if (health>100):
			health = 100
	if health==0:
		health = 0
