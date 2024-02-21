extends Node2D

@onready var inv : Array = get_parent().get_parent().inv
var savedInv : Array = [0,0,0,0]

func _process(delta):
	inv = get_parent().get_parent().inv
	
	for i in 3:
		if inv[i] != savedInv[i]:
			checkInv(inv[i], i)

#	Inventory IDs
#	0 = Empty
#	1 = Key (126, 18)
#
#	(324, 126) is a failsafe.

func checkInv(newInv : int, invSlot : int):
	if newInv == 0:
		newInv = savedInv[invSlot]
		toggleVisibility(invSlot, false)
		return
	elif newInv == 1:
		changeInv(invSlot, 126, 18)
	else:
		changeInv(invSlot, 324, 126)

func changeInv(invSlot : int, x : int, y : int):
	if invSlot == 0 : 
		print($Inv0.get_region())
		#$Inv0.Texture2D.set_region(x)
		#$Inv0.set_region.y(y)
	if invSlot == 1 : 
		$Inv1.setregion.x = x 
		$Inv1.setregion.y = y
	if invSlot == 2 : 
		$Inv2.setregion.x = x 
		$Inv2.setregion.y = y
	if invSlot == 3 : 
		$Inv3.setregion.x = x 
		$Inv3.setregion.y = y

func toggleVisibility(invSlot : int, state : bool):

	if invSlot == 0 : $Inv0.set_visibile(state)
	if invSlot == 1 : $Inv1.set_visibile(state)
	if invSlot == 2 : $Inv2.set_visibile(state)
	if invSlot == 3 : $Inv3.set_visibile(state)
