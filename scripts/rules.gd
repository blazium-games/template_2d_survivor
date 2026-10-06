extends RefCounted

const CAP := 8
const NEED := 5
const REACH := 64.0
var alive := 0
var xp := 0
var upgraded := false

func admit() -> bool:
	if alive >= CAP:
		return false
	alive += 1
	return true

func in_reach(distance: float) -> bool:
	return distance >= 0.0 and distance <= REACH

func grant_xp(amount: int) -> void:
	xp += maxi(amount, 0)

func try_upgrade() -> bool:
	if upgraded or xp < NEED:
		return false
	upgraded = true
	return true

func reset_run() -> void:
	alive = 0
	xp = 0
	upgraded = false

func may_pick() -> bool:
	return xp >= NEED and not upgraded
