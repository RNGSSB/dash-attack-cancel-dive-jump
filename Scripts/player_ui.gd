extends CanvasLayer

@onready var timer = $Timer

var lol = 0.0
var loltext = "0"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	owner.minuteCounter += 1.0 
	if owner.minuteCounter < 600.0:
		loltext = "0"
	else:
		loltext = ""
	if owner.minuteCounter > 3600.0:
		owner.minuteCounter = 0.0
	
	if owner.frameCounter < 36000.0:
		timer.text = "Coins: " + str(owner.coins)  + " Time: " + "0" + str(snapped((owner.frameCounter / 60) / 60, 00)) + ":" + loltext + str(snapped(owner.minuteCounter / 60, 00.01))
	else:
		timer.text = "TOO DAMN FUCKING LONG"
