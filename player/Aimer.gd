extends Position2D

onready var player_ref = get_parent()

export(Array, PackedScene) var projectiles
var projectile_speed = 1000
var fire_rate = 0.25
var can_fire = true

var deadly_speed_min = Vector2(-500, -500)

func _process(delta):
	look_at(get_global_mouse_position())
	$Sprite.set_global_rotation(0)
	
	if Input.is_action_pressed("shoot") and can_fire:
		if player_ref.current_coins > 0:
			player_ref.add_coin(-1)
			var new_projectile = projectiles[0].instance()
			new_projectile.position = $Sprite.get_global_position()
			new_projectile.apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
			get_tree().get_root().get_node("World").add_child(new_projectile)
			can_fire = false
			yield(get_tree().create_timer(fire_rate),"timeout")
			can_fire = true
		else:
			print("out of $")
			can_fire = false
			yield(get_tree().create_timer(fire_rate),"timeout")
			can_fire = true
	if Input.is_action_just_released("unload_stack"):
		pass
