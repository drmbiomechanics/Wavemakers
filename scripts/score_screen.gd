extends Node2D
var score = 0
var r = 244.0/255.0
var g = 181.0/255.0
var b = 228.0/255.0
var score_text = "Score: "
# Called when the node enters the scene tree for the first time.
func _ready():
	score = GlobalVariables.game_score
	update_score()
	
	if score < 600:
		$Requested_Wave_Node/Swimmer_Rank_1_Left.show()
		$Requested_Wave_Node/Swimmer_Rank_1_Right.show()
		$Rank_Container/Rank_Container6/Rank_6_Label.add_theme_color_override("font_color",Color(r,g,b,1))
	elif score < 1500:
		$Requested_Wave_Node/Swimmer_Rank_2_Left.show()
		$Requested_Wave_Node/Swimmer_Rank_2_Right.show()
		$Rank_Container/Rank_Container5/Rank_5_Label.add_theme_color_override("font_color",Color(r,g,b,1))
	elif score < 3500:
		$Requested_Wave_Node/Swimmer_Rank_3_Left.show()
		$Requested_Wave_Node/Swimmer_Rank_3_Right.show()
		$Rank_Container/Rank_Container4/Rank_4_Label.add_theme_color_override("font_color",Color(r,g,b,1))
	elif score < 5000:
		$Requested_Wave_Node/Swimmer_Rank_4_Left.show()
		$Requested_Wave_Node/Swimmer_Rank_4_Right.show()
		$Rank_Container/Rank_Container3/Rank_3_Label.add_theme_color_override("font_color",Color(r,g,b,1))
	elif score < 5900:
		$Requested_Wave_Node/Swimmer_Rank_5_Left.show()
		$Requested_Wave_Node/Swimmer_Rank_5_Right.show()
		$Rank_Container/Rank_Container2/Rank_2_Label.add_theme_color_override("font_color",Color(r,g,b,1))
	elif score >= 5900:
		$Requested_Wave_Node/Swimmer_Rank_6_Left.show()
		$Requested_Wave_Node/Swimmer_Rank_6_Right.show()
		$Rank_Container/Rank_Container1/Rank_1_Label.add_theme_color_override("font_color",Color(r,g,b,1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_score():
	var score_line = ""
	score_line = score_text + str(score)
	$Score_Container/Score_Label.text = score_line


func _on_play_again_button_pressed():
	GlobalVariables.game_score = 0
	GlobalVariables.round = 1
	get_tree().change_scene_to_file("res://scenes/wavemaker_easy_mode.tscn")
	



func _on_quit_button_pressed():
	get_tree().quit()
