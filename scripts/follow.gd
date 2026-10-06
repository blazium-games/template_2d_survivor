extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

func _ready() -> void:
	$SheetLens.make_current()
	if rules.in_reach(12.0):
		rules.grant_xp(5)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary") and rules.may_pick():
		rules.try_upgrade()
		get_tree().change_scene_to_file("res://scenes/opener.tscn")
