extends Button

@export var label = ""
@export var to_quit = false
@export var target_scene : PackedScene

func _on_pressed() -> void:
	
	# Load new scene
	if target_scene and target_scene.resource_path.contains("scenes"):
		print("Loading Target: " + target_scene.resource_path)
		get_tree().change_scene_to_packed(target_scene)
		
	# TODO: Overlap menu
	
	if to_quit:
		get_tree().quit()


func _on_ready() -> void:
	text = label


func _on_mouse_entered() -> void:
	#icon = load("res://assets/images/arrow.png")
	pass


func _on_mouse_exited() -> void:
	icon = null
