extends Node3D

var inventory_is_open = false
var options_is_open = false
@onready var journal = $HUDCanvas/Journal


func _input(_event: InputEvent) -> void:
	# Journal
	if Input.is_action_just_pressed("journal"):
		if not inventory_is_open:
			print("Open Journal")
			journal.visible = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			print("Close Journal")
			journal.visible = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
		inventory_is_open = !inventory_is_open
		
	# Options
	#if Input.is_key_pressed(KEY_ESCAPE):
		#if not options_is_open:
			#print("Open Options")
		#else:
			#print("Close Options")
			#
		#options_is_open = !options_is_open
		
	

	
