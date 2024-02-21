extends Node2D

@onready var inv : Array = get_parent().get_parent().inv
var savedInv : Array = [0,0,0,0]

func _ready():
	inv = get_parent().get_parent().inv

func _process(delta):
	for i in 4:
		if inv[i] != savedInv[i]:
			checkInv(inv[i], i)

#	Inventory IDs
#	0 = Empty
#	1 = Key (126, 18)
#
#	(324, 126) is a failsafe.

func checkInv(newInv : int, invSlot : int):
	if newInv == 0:
		savedInv[invSlot] = newInv
		toggleVisibility(invSlot, false)
		return
	elif newInv == 1:
		changeInv(invSlot, 126, 18)
		toggleVisibility(invSlot, true)
		savedInv[invSlot] = newInv
	else:
		changeInv(invSlot, 324, 126)
		toggleVisibility(invSlot, true)
		savedInv[invSlot] = newInv

func changeInv(invSlot : int, x : int, y : int):
	if invSlot == 0 : $Inv0.set_region_rect(Rect2(x, y, 18, 18))
	if invSlot == 1 : $Inv1.set_region_rect(Rect2(x, y, 18, 18))
	if invSlot == 2 : $Inv2.set_region_rect(Rect2(x, y, 18, 18))
	if invSlot == 3 : $Inv3.set_region_rect(Rect2(x, y, 18, 18))

func toggleVisibility(invSlot : int, state : bool):

	if invSlot == 0 : $Inv0.set_visible(state)
	if invSlot == 1 : $Inv1.set_visible(state)
	if invSlot == 2 : $Inv2.set_visible(state)
	if invSlot == 3 : $Inv3.set_visible(state)
