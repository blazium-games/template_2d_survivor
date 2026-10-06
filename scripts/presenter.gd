extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

@onready var mover: ColorRect = $Mover
@onready var foe: ColorRect = $Foe

func _ready() -> void:
	$SheetLens.make_current()

func _process(_delta: float) -> void:
	var wish := Vector2(
		Input.get_action_strength("stride_east") - Input.get_action_strength("stride_west"),
		Input.get_action_strength("stride_south") - Input.get_action_strength("stride_north")
	)
	mover.position += wish * 160.0 * _delta
	foe.position = foe.position.move_toward(mover.position, 40.0 * _delta)
	if Input.is_action_just_pressed("primary"):
		var gap := mover.position.distance_to(foe.position)
		if rules.in_reach(gap) and rules.admit():
			rules.grant_xp(1)
		if rules.may_pick():
			_go("res://scenes/pick.tscn")

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
