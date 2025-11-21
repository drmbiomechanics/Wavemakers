extends Node2D
var current_slide = 0
var page_text_base = "/10"
var page = current_slide+1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Page_Container/Page_Label.text = str(page) + page_text_base


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_previous_button_pressed():
	if current_slide == 0:
		current_slide = 9
		page = current_slide+1
		$Tutorial_Sprites.frame = current_slide
		$Page_Container/Page_Label.text = str(page) + page_text_base
	else:
		current_slide -= 1
		page = current_slide+1
		$Tutorial_Sprites.frame = current_slide
		$Page_Container/Page_Label.text = str(page) + page_text_base

func _on_next_button_pressed():
	if current_slide == 9:
		current_slide = 0
		page = current_slide+1
		$Tutorial_Sprites.frame = current_slide
		$Page_Container/Page_Label.text = str(page) + page_text_base
	else:
		current_slide += 1
		page = current_slide+1
		$Tutorial_Sprites.frame = current_slide
		$Page_Container/Page_Label.text = str(page) + page_text_base


func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://scenes/animated_title.tscn")
