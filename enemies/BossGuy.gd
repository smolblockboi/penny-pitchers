extends "res://enemies/BaseEnemy.gd" 

func _ready():
	speed = (rand_range(90, 200) * 0.5) # 0.50 speed
	anims_player.playback_speed = speed / base_speed
	print("%s / %s = %s" % [speed, base_speed, anims_player.playback_speed])

func death():
	for i in range(0, max_health + 1): # +1 for extra boss drop
		var dropped_loot = coin_drop.instance()
		dropped_loot.position = get_global_position() + drop_offset()
		get_tree().get_root().get_node("World/Items").call_deferred("add_child", dropped_loot)
		i += 1
