extends KinematicBody2D

class_name Player

func _ready():
	get_tree().call_group("Enemies", "set_player", self)

var current_direction = "right"

func change_direction(new_direction: String) -> void:
	if current_direction == new_direction:
		return
	
	if current_direction == "right":
		get_node("AnimatedSprite").offset.x = -40.0
	
	else:
		get_node("AnimatedSprite").offset.x = 40.0
	
	get_node("AnimatedSprite").flip_h = !get_node("AnimatedSprite").flip_h
	
	current_direction = new_direction

func change_animation(new_animation: String) -> void:
	var current_animation: String = get_node("AnimatedSprite").animation
	
	if current_animation == new_animation:
		return
	
	get_node("AnimatedSprite").animation = new_animation

func get_move_vec() -> Vector2:
	var move_vec := Vector2(0.0, 0.0)
	
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1.0
	
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1.0
	
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1.0
	
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1.0
	
	move_vec = move_vec.normalized()
	return move_vec

var dx := 0.0
var dy := 0.0

const GRIND = 0.01
const JUMP_LIMIT = 30.0
const FALL_LIMIT = 30.0
const GRAVITY = 0.01
const JUMP_BOOST = 2.0
const FALL_BOOST = 1.0

var head_bodies := 0
var toe_bodies := 0

func head_colliding() -> bool:
	return head_bodies != 0

func toes_colliding() -> bool:
	return toe_bodies != 0

func _process(delta):
	var move_vec = get_move_vec()
	if move_vec.x > 0.0:
		dx += 0.2
	elif move_vec.x < 0.0:
		dx -= 0.2
	
	dx = clamp(dx, -1.0, 1.0)
	
	if dx >= GRIND:
		dx -= GRIND
	elif dx <= -GRIND:
		dx += GRIND
	else:
		dx = 0.0
	
	var is_head_colliding: bool = head_colliding()
	var is_toes_colliding: bool = toes_colliding()
	
	if is_head_colliding:
		dy = FALL_BOOST
		change_animation("falling")
	
	elif is_toes_colliding:
		dy = 0.0
		if move_vec.y < 0.0:
			dy = -JUMP_BOOST
			change_animation("jumping")
		elif dx == 0.0:
			change_animation("idle")
		else:
			change_animation("moving")
	
	else:
		dy += GRAVITY
		if dy >= 0.0:
			change_animation("falling")
		else:
			change_animation("jumping")
	
	dy = clamp(dy, -JUMP_LIMIT, FALL_LIMIT)
	
	if dx < 0.0:
		change_direction("left")
	elif dx > 0.0:
		change_direction("right")
	
	move_and_collide(Vector2(dx, dy))


func _on_Head_body_entered(body):
	if typeof(body) == 17 or not body is KinematicBody2D:
		head_bodies += 1


func _on_Head_body_exited(body):
	if typeof(body) == 17 or  not body is KinematicBody2D:
		head_bodies -= 1


func _on_Toes_body_entered(body):
	if typeof(body) != 17 or not body is KinematicBody2D:
		toe_bodies += 1


func _on_Toes_body_exited(body):
	if typeof(body) != 17 or not body is KinematicBody2D:
		toe_bodies -= 1
