extends Node2D

@export var endPortal : Node2D
@onready var sprite = $Sprite2D
@onready var collision = $Area2D/CollisionShape2D
@onready var area = $Area2D
@export var portalType = 0
@export var portal2Sprite : CompressedTexture2D
var frames = 0 
var disableFrames = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if portalType != 0:
		sprite.texture = portal2Sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	frames += 1
	
	if collision.disabled == true and frames > disableFrames + 20:
		collision.disabled = false
		area.set_collision_mask_value(2, true)


func disableForABit():
	disableFrames = frames
	area.set_collision_mask_value(2, false)
	collision.disabled = true
	

func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		if area.owner.CURRSTATE != "Death":
			AudioManager.portal.play()
			endPortal.disableForABit()
			if portalType != 0:
				area.owner.velocity.y *= -1.5
			else:
				area.owner.velocity.y *= 1.5
			area.owner.velocity.x *= 1.5
			area.owner.position = endPortal.position
