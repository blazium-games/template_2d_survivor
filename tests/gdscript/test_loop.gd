extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_cap_and_threshold() -> void:
	var rules = Rules.new()
	for _i in 8:
		assert_true(rules.admit(), "under cap")
	assert_false(rules.admit(), "cap")
	rules.grant_xp(5)
	assert_true(rules.try_upgrade(), "threshold met")

func test_early_upgrade() -> void:
	var rules = Rules.new()
	rules.grant_xp(2)
	assert_false(rules.try_upgrade(), "short xp")

func test_pick_gate() -> void:
	var rules = Rules.new()
	rules.grant_xp(2)
	assert_false(rules.may_pick(), "short")
	rules.grant_xp(3)
	assert_true(rules.may_pick(), "ready")
	assert_true(rules.try_upgrade(), "first")
	assert_false(rules.may_pick(), "already upgraded")
	assert_true(load("res://scenes/pick.tscn") != null, "pick loads")

func test_in_reach() -> void:
	var rules = Rules.new()
	assert_false(rules.in_reach(90.0), "too far")
	assert_true(rules.in_reach(12.0), "in reach")
