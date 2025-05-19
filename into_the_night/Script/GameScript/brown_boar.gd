extends CharacterBody2D
var speed = 25
var player_chase = false
var player = null

var health = 100
var player_in_attack_zone = false
var can_take_damage = true

func _physics_process(delta: float) -> void:
	deal_with_damage() 
	update_health_bar()
	if player_chase:
		position += (player.position-position)/speed 
		$AnimatedSprite2D.play("run")
		if (player.position.x-position.x)<0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("idle")
func enemy():
	pass
func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	player_chase =  true
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false


func _on_brown_boar_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_zone =  true

func _on_brown_boar_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_zone = false
func deal_with_damage():
	if player_in_attack_zone and global.player_current_attack==true:
		if can_take_damage:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print(health)
			if health<=0:
				self.queue_free()

func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true
func update_health_bar():
	var health_bar = $HealthBar
	health_bar.value = health
	if (health_bar.value>=100):
		health_bar.visible = false
	else:
		health_bar.visible = true
