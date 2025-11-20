extends Node2D
var x_for_waves = 0
var x_step = 0.025
var wave_made = false
var scale_slope = 0.144#0.072
var scale_intercept = 0.1
var pixel_slope = -103.6#-51.8
var pixel_intercept = 538#315
var score = 0
var score_array = []
var player_wave = [0]
var wave_anim = [0]
var wave_computed = false
var counter = 0
var wave_anim_index = [0]
var requested_wave = []
var test_amplitude = 5 #baseline test is 5; Max = 5, Min = 0.01
var decay = -0.5 #I think this will stay fixed at -0.3 for this game
var test_wavelength = 0.8 #baseline test is at 0.8, but that might be the min; Max = 5, Min = 0.8?
var x_resolution = 0.01 #pretty sure this will be fixed at 0.01 to get the appropriate speed/resolution
var time = 2
var test_gap = 5
var test_bars = 40
var player_amplitude = 5
var player_wavelength = 0.8
var requested_wave_to_score = []
var sc = 0
var active_swimmer = 1
var score_text = "Score = "


# Called when the node enters the scene tree for the first time.
func _ready():
	clear_line_2d()
	AudioPlayer.play_music_level()
	#set_line2d(Vector2(0,0))
	requested_wave = make_wave(test_amplitude,test_wavelength,decay,x_resolution,time)
	#print(requested_wave)
	requested_wave.reverse()
	requested_wave_display(requested_wave)
	$Requested_Wave_Node/Requested_Wave_Line.position = Vector2(295,314.884)
	$Requested_Wave_Node/Requested_Wave_25_upper.position = Vector2(295,302.05)
	$Requested_Wave_Node/Requested_Wave_25_lower.position = Vector2(295,327.95)
	$Requested_Wave_Node/Requested_Wave_50_upper.position = Vector2(295,289.1)
	$Requested_Wave_Node/Requested_Wave_50_lower.position = Vector2(295,340.9)
	$Requested_Wave_Node/Requested_Wave_100_upper.position = Vector2(295,263.2)
	$Requested_Wave_Node/Requested_Wave_100_lower.position = Vector2(295,366.8)
	$Requested_Wave_Node/Requested_Wave_150_upper.position = Vector2(295,237.3)
	$Requested_Wave_Node/Requested_Wave_150_lower.position = Vector2(295,392.7)
	$Requested_Wave_Node/Requested_Wave_200_upper.position = Vector2(295,211.4)
	$Requested_Wave_Node/Requested_Wave_200_lower.position = Vector2(295,418.6)
	#hide_score_bands(true)
	#requested_wave_display_reversed(requested_wave)
	#player_wave = make_wave(5,0.8,-0.3,0.01,2.5) #trying to output player wave to see if it matches???
	#print(player_wave)
	test_gap = 5
	time = 2
	Engine.max_fps = 30#slowed for testing, default 60 seems good
	score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	x_for_waves += x_step
	if wave_made == false:
		test_sine_wave(x_for_waves,0.1)
		#test_decay_wave(x_for_waves,5,1,-0.3)
		counter = 0
	elif wave_made == true:
		#print("wave_made")
		if wave_computed == false:
			print("Starting compute")
			wave_anim_index = player_wave_index_prep(0.4,x_resolution,40,5) # this is likely to always be fixed, and time should be fixed for the other functions as well
			#print(wave_anim_index)
			#print(wave_anim_index.size())
			x_for_waves = 0
			wave_computed = true
		elif counter < (wave_anim_index.size()-400):
			#player_wave = make_wave(5,0.8,-0.3,0.01,2.5) #trying to output player wave to see if it matches???
			#print(player_wave)
			play_made_wave2(wave_anim_index,counter,player_amplitude,player_wavelength,decay)
			#max amp is 5
			#max wavelength is 5
			counter += 1
			#print(counter)
			if active_swimmer == 1:
				if $Requested_Wave_Node/Requested_Wave_Line.position.x < -255:
					clear_line_2d()
			elif active_swimmer == 2:
				if $Requested_Wave_Node/Requested_Wave_Line.position.x < -110:
					clear_line_2d()
			elif active_swimmer == 3:
				if $Requested_Wave_Node/Requested_Wave_Line.position.x < 60:
					clear_line_2d()
		else:
			wave_made = false
			wave_computed = false
			disable_buttons(false)
			$Requested_Wave_Node/Requested_Wave_Line.position = Vector2(295,314.884)
			$Requested_Wave_Node/Requested_Wave_25_upper.position = Vector2(295,302.05)
			$Requested_Wave_Node/Requested_Wave_25_lower.position = Vector2(295,327.95)
			$Requested_Wave_Node/Requested_Wave_50_upper.position = Vector2(295,289.1)
			$Requested_Wave_Node/Requested_Wave_50_lower.position = Vector2(295,340.9)
			$Requested_Wave_Node/Requested_Wave_100_upper.position = Vector2(295,263.2)
			$Requested_Wave_Node/Requested_Wave_100_lower.position = Vector2(295,366.8)
			$Requested_Wave_Node/Requested_Wave_150_upper.position = Vector2(295,237.3)
			$Requested_Wave_Node/Requested_Wave_150_lower.position = Vector2(295,392.7)
			$Requested_Wave_Node/Requested_Wave_200_upper.position = Vector2(295,211.4)
			$Requested_Wave_Node/Requested_Wave_200_lower.position = Vector2(295,418.6)
			requested_wave_display(requested_wave)
			#active_swimmer = 2
			#hide_score_bands(true)
			#$Requested_Wave_Node/Requested_Wave_Line.position = Vector2(359,314.884)

func update_score():
	var score_line = ""
	score_line = score_text + str(score)
	$Score_Container/Score_Label.text = score_line

func hide_score_bands(condition: bool):
	if condition == true:
		$Requested_Wave_Node/Requested_Wave_25_upper.hide()
		$Requested_Wave_Node/Requested_Wave_25_lower.hide()
		$Requested_Wave_Node/Requested_Wave_50_upper.hide()
		$Requested_Wave_Node/Requested_Wave_50_lower.hide()
		$Requested_Wave_Node/Requested_Wave_100_upper.hide()
		$Requested_Wave_Node/Requested_Wave_100_lower.hide()
		$Requested_Wave_Node/Requested_Wave_150_upper.hide()
		$Requested_Wave_Node/Requested_Wave_150_lower.hide()
		$Requested_Wave_Node/Requested_Wave_200_upper.hide()
		$Requested_Wave_Node/Requested_Wave_200_lower.hide()
	elif condition == false:
		$Requested_Wave_Node/Requested_Wave_25_upper.show()
		$Requested_Wave_Node/Requested_Wave_25_lower.show()
		$Requested_Wave_Node/Requested_Wave_50_upper.show()
		$Requested_Wave_Node/Requested_Wave_50_lower.show()
		$Requested_Wave_Node/Requested_Wave_100_upper.show()
		$Requested_Wave_Node/Requested_Wave_100_lower.show()
		$Requested_Wave_Node/Requested_Wave_150_upper.show()
		$Requested_Wave_Node/Requested_Wave_150_lower.show()
		$Requested_Wave_Node/Requested_Wave_200_upper.show()
		$Requested_Wave_Node/Requested_Wave_200_lower.show()
		

func set_line2d(point):
	$Requested_Wave_Node/Requested_Wave_Line.add_point(point)
	$Requested_Wave_Node/Requested_Wave_25_upper.add_point(point)
	$Requested_Wave_Node/Requested_Wave_50_upper.add_point(point)
	$Requested_Wave_Node/Requested_Wave_100_upper.add_point(point)
	$Requested_Wave_Node/Requested_Wave_150_upper.add_point(point)
	$Requested_Wave_Node/Requested_Wave_200_upper.add_point(point)
	$Requested_Wave_Node/Requested_Wave_25_lower.add_point(point)
	$Requested_Wave_Node/Requested_Wave_50_lower.add_point(point)
	$Requested_Wave_Node/Requested_Wave_100_lower.add_point(point)
	$Requested_Wave_Node/Requested_Wave_150_lower.add_point(point)
	$Requested_Wave_Node/Requested_Wave_200_lower.add_point(point)

func clear_line_2d():
	$Requested_Wave_Node/Requested_Wave_Line.clear_points()
	$Requested_Wave_Node/Requested_Wave_25_upper.clear_points()
	$Requested_Wave_Node/Requested_Wave_50_upper.clear_points()
	$Requested_Wave_Node/Requested_Wave_100_upper.clear_points()
	$Requested_Wave_Node/Requested_Wave_150_upper.clear_points()
	$Requested_Wave_Node/Requested_Wave_200_upper.clear_points()
	$Requested_Wave_Node/Requested_Wave_25_lower.clear_points()
	$Requested_Wave_Node/Requested_Wave_50_lower.clear_points()
	$Requested_Wave_Node/Requested_Wave_100_lower.clear_points()
	$Requested_Wave_Node/Requested_Wave_150_lower.clear_points()
	$Requested_Wave_Node/Requested_Wave_200_lower.clear_points()

func player_wave_index_prep(time,resolution,bars,gap):
	var wave_index = []
	for j in range(0,(time/resolution)*gap):
		wave_index.append(j*resolution)
	for i in range(bars*gap):
		wave_index.push_front(0)
	var last_value = wave_index[-1]
	print(last_value)
	for k in range(bars*gap*2):
		wave_index.append(0)
#		if last_value == 0:
#			pass
#		else:
#			wave_index.append((last_value+resolution))
#			last_value = wave_index[-1]
	return(wave_index)
	
func play_made_wave2(wave_index,x_index,amplitude,wavelength,decay):
	var wave_y: float = 0.0
	var y_zero = 0
	wave_y = (amplitude*exp(decay*((wave_index[x_index+200])))*sin(2*PI*((wave_index[x_index+200]))/wavelength))
	#print(wave_y)
	var line_pos_x = $Requested_Wave_Node/Requested_Wave_Line.position.x
	var start_tracking = false
	$Wave_Elements/Wave_R1.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+195])))*sin(2*PI*((wave_index[x_index+195]))/wavelength))
	$Wave_Elements/Wave_R2.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+190])))*sin(2*PI*((wave_index[x_index+190]))/wavelength))
	$Wave_Elements/Wave_R3.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+185])))*sin(2*PI*((wave_index[x_index+185]))/wavelength))
	$Wave_Elements/Wave_R4.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+180])))*sin(2*PI*((wave_index[x_index+180]))/wavelength))
	$Wave_Elements/Wave_R5.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+175])))*sin(2*PI*((wave_index[x_index+175]))/wavelength))
	$Wave_Elements/Wave_R6.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+170])))*sin(2*PI*((wave_index[x_index+170]))/wavelength))
	$Wave_Elements/Wave_R7.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+165])))*sin(2*PI*((wave_index[x_index+165]))/wavelength))
	$Wave_Elements/Wave_R8.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+160])))*sin(2*PI*((wave_index[x_index+160]))/wavelength))
	$Wave_Elements/Wave_R9.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+155])))*sin(2*PI*((wave_index[x_index+155]))/wavelength))
	$Wave_Elements/Wave_R10.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+150])))*sin(2*PI*((wave_index[x_index+150]))/wavelength))
	$Wave_Elements/Wave_R11.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+145])))*sin(2*PI*((wave_index[x_index+145]))/wavelength))
	$Wave_Elements/Wave_R12.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+140])))*sin(2*PI*((wave_index[x_index+140]))/wavelength))
	if wave_y != 0 and active_swimmer == 1:
		if x_index > 1:
			start_tracking = true
	if start_tracking == true and active_swimmer == 1:
		$Requested_Wave_Node/Requested_Wave_Line.position.x = line_pos_x-4.0812# this value to be changed, also when these if functions start may need to be tweaked
		$Requested_Wave_Node/Requested_Wave_25_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_50_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_100_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_150_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_200_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_25_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_50_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_100_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_150_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_200_lower.position.x = line_pos_x-4.0812
		score += score_array[sc]
		print(score)
		update_score()
		sc += 1
	$Wave_Elements/Wave_R13.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+135])))*sin(2*PI*((wave_index[x_index+135]))/wavelength))
	$Wave_Elements/Wave_R14.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+130])))*sin(2*PI*((wave_index[x_index+130]))/wavelength))
	$Wave_Elements/Wave_R15.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+125])))*sin(2*PI*((wave_index[x_index+125]))/wavelength))
	$Wave_Elements/Wave_R16.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+120])))*sin(2*PI*((wave_index[x_index+120]))/wavelength))
	$Wave_Elements/Wave_R17.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+115])))*sin(2*PI*((wave_index[x_index+115]))/wavelength))
#	if wave_y != 0:
#		if x_index > 1:
#			start_tracking = true
#	if start_tracking == true:
#		$Requested_Wave_Node/Requested_Wave_Line.position.x = line_pos_x-4.0812
	$Wave_Elements/Wave_R18.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+110])))*sin(2*PI*((wave_index[x_index+110]))/wavelength))
	$Wave_Elements/Wave_R19.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+105])))*sin(2*PI*((wave_index[x_index+105]))/wavelength))
	if wave_y != 0 and active_swimmer == 2:
		if x_index > 1:
			start_tracking = true
	if start_tracking == true and active_swimmer == 2:
		$Requested_Wave_Node/Requested_Wave_Line.position.x = line_pos_x-4.0812# this value to be changed, also when these if functions start may need to be tweaked
		$Requested_Wave_Node/Requested_Wave_25_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_50_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_100_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_150_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_200_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_25_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_50_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_100_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_150_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_200_lower.position.x = line_pos_x-4.0812
		score += score_array[sc]
		print(score)
		update_score()
		sc += 1
	$Wave_Elements/Wave_R20.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+100])))*sin(2*PI*((wave_index[x_index+100]))/wavelength))
	$Wave_Elements/Wave_R21.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+95])))*sin(2*PI*((wave_index[x_index+95]))/wavelength))
	$Wave_Elements/Wave_R22.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+90])))*sin(2*PI*((wave_index[x_index+90]))/wavelength))
	$Wave_Elements/Wave_R23.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+85])))*sin(2*PI*((wave_index[x_index+85]))/wavelength))
	$Wave_Elements/Wave_R24.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+80])))*sin(2*PI*((wave_index[x_index+80]))/wavelength))
	$Wave_Elements/Wave_R25.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+75])))*sin(2*PI*((wave_index[x_index+75]))/wavelength))
	$Wave_Elements/Wave_R26.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+70])))*sin(2*PI*((wave_index[x_index+70]))/wavelength))
	$Wave_Elements/Wave_R27.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+65])))*sin(2*PI*((wave_index[x_index+65]))/wavelength))
	if wave_y != 0 and active_swimmer == 3:
		if x_index > 1:
			start_tracking = true
	if start_tracking == true and active_swimmer == 3:
		$Requested_Wave_Node/Requested_Wave_Line.position.x = line_pos_x-4.0812# this value to be changed, also when these if functions start may need to be tweaked
		$Requested_Wave_Node/Requested_Wave_25_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_50_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_100_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_150_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_200_upper.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_25_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_50_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_100_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_150_lower.position.x = line_pos_x-4.0812
		$Requested_Wave_Node/Requested_Wave_200_lower.position.x = line_pos_x-4.0812
		score += score_array[sc]
		print(score)
		update_score()
		sc += 1
	$Wave_Elements/Wave_R28.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+60])))*sin(2*PI*((wave_index[x_index+60]))/wavelength))
	$Wave_Elements/Wave_R29.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+55])))*sin(2*PI*((wave_index[x_index+55]))/wavelength))
	$Wave_Elements/Wave_R30.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+50])))*sin(2*PI*((wave_index[x_index+50]))/wavelength))
	$Wave_Elements/Wave_R31.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+45])))*sin(2*PI*((wave_index[x_index+45]))/wavelength))
	$Wave_Elements/Wave_R32.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+40])))*sin(2*PI*((wave_index[x_index+40]))/wavelength))
	$Wave_Elements/Wave_R33.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+35])))*sin(2*PI*((wave_index[x_index+35]))/wavelength))
	$Wave_Elements/Wave_R34.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+30])))*sin(2*PI*((wave_index[x_index+30]))/wavelength))
	$Wave_Elements/Wave_R35.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+25])))*sin(2*PI*((wave_index[x_index+25]))/wavelength))
	$Wave_Elements/Wave_R36.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+20])))*sin(2*PI*((wave_index[x_index+20]))/wavelength))
	$Wave_Elements/Wave_R37.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+15])))*sin(2*PI*((wave_index[x_index+15]))/wavelength))
	$Wave_Elements/Wave_R38.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+10])))*sin(2*PI*((wave_index[x_index+10]))/wavelength))
	$Wave_Elements/Wave_R39.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+5])))*sin(2*PI*((wave_index[x_index+5]))/wavelength))
	$Wave_Elements/Wave_R40.scale.y = ((wave_y*scale_slope)+scale_intercept)
	wave_y = (amplitude*exp(decay*((wave_index[x_index+140])))*sin(2*PI*((wave_index[x_index+140]))/wavelength))
	$Swimmer_1.position = Vector2(542.654,((wave_y*pixel_slope)+pixel_intercept))
	wave_y = (amplitude*exp(decay*((wave_index[x_index+105])))*sin(2*PI*((wave_index[x_index+105]))/wavelength))
	$Swimmer_2.position = Vector2(685.496,((wave_y*pixel_slope)+pixel_intercept))
	wave_y = (amplitude*exp(decay*((wave_index[x_index+70])))*sin(2*PI*((wave_index[x_index+70]))/wavelength))
	$Swimmer_3.position = Vector2(828.338,((wave_y*pixel_slope)+pixel_intercept))

func test_sine_wave(x,amp):
	var y_wave: float = 0.0
#	var scale_slope = 0.072
#	var scale_intercept = 0.411
#	var pixel_slope = -51.8
#	var pixel_intercept = 315
	x = x*2
	y_wave = sin(x)
	$Wave_Elements/Wave_R1.scale.y = (((amp*sin(x))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R2.scale.y = (((amp*sin(x+x_step*5))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R3.scale.y = (((amp*sin(x+x_step*10))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R4.scale.y = (((amp*sin(x+x_step*15))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R5.scale.y = (((amp*sin(x+x_step*20))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R6.scale.y = (((amp*sin(x+x_step*25))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R7.scale.y = (((amp*sin(x+x_step*30))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R8.scale.y = (((amp*sin(x+x_step*35))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R9.scale.y = (((amp*sin(x+x_step*40))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R10.scale.y = (((amp*sin(x+x_step*45))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R11.scale.y = (((amp*sin(x+x_step*50))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R12.scale.y = (((amp*sin(x+x_step*55))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R13.scale.y = (((amp*sin(x+x_step*60))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R14.scale.y = (((amp*sin(x+x_step*65))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R15.scale.y = (((amp*sin(x+x_step*70))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R16.scale.y = (((amp*sin(x+x_step*75))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R17.scale.y = (((amp*sin(x+x_step*80))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R18.scale.y = (((amp*sin(x+x_step*85))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R19.scale.y = (((amp*sin(x+x_step*90))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R20.scale.y = (((amp*sin(x+x_step*95))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R21.scale.y = (((amp*sin(x+x_step*100))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R22.scale.y = (((amp*sin(x+x_step*105))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R23.scale.y = (((amp*sin(x+x_step*110))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R24.scale.y = (((amp*sin(x+x_step*115))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R25.scale.y = (((amp*sin(x+x_step*120))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R26.scale.y = (((amp*sin(x+x_step*125))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R27.scale.y = (((amp*sin(x+x_step*130))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R28.scale.y = (((amp*sin(x+x_step*135))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R29.scale.y = (((amp*sin(x+x_step*140))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R30.scale.y = (((amp*sin(x+x_step*145))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R31.scale.y = (((amp*sin(x+x_step*150))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R32.scale.y = (((amp*sin(x+x_step*155))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R33.scale.y = (((amp*sin(x+x_step*160))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R34.scale.y = (((amp*sin(x+x_step*165))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R35.scale.y = (((amp*sin(x+x_step*170))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R36.scale.y = (((amp*sin(x+x_step*175))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R37.scale.y = (((amp*sin(x+x_step*180))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R38.scale.y = (((amp*sin(x+x_step*185))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R39.scale.y = (((amp*sin(x+x_step*190))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R40.scale.y = (((amp*sin(x+x_step*195))*scale_slope)+scale_intercept)
	$Swimmer_1.position = Vector2(542.654,(((amp*sin(x+x_step*55))*pixel_slope)+pixel_intercept))#45
	$Swimmer_2.position = Vector2(685.496,(((amp*sin(x+x_step*90))*pixel_slope)+pixel_intercept))#80
	$Swimmer_3.position = Vector2(828.338,(((amp*sin(x+x_step*125))*pixel_slope)+pixel_intercept))#115
	
func test_decay_wave(x,amp,wavelength,decay):
	var y_wave: float = 0.0
#	var scale_slope = 0.072
#	var scale_intercept = 0.411
#	var pixel_slope = -51.8
#	var pixel_intercept = 315
	y_wave = (amp*exp(decay*(x))*sin(2*PI*(x)/wavelength))
	$Wave_Elements/Wave_R1.scale.y = ((y_wave*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R2.scale.y = (((amp*sin(x+x_step*5))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R3.scale.y = (((amp*sin(x+x_step*10))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R4.scale.y = (((amp*sin(x+x_step*15))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R5.scale.y = (((amp*sin(x+x_step*20))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R6.scale.y = (((amp*sin(x+x_step*25))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R7.scale.y = (((amp*sin(x+x_step*30))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R8.scale.y = (((amp*sin(x+x_step*35))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R9.scale.y = (((amp*sin(x+x_step*40))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R10.scale.y = (((amp*sin(x+x_step*45))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R11.scale.y = (((amp*sin(x+x_step*50))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R12.scale.y = (((amp*sin(x+x_step*55))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R13.scale.y = (((amp*sin(x+x_step*60))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R14.scale.y = (((amp*sin(x+x_step*65))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R15.scale.y = (((amp*sin(x+x_step*70))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R16.scale.y = (((amp*sin(x+x_step*75))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R17.scale.y = (((amp*sin(x+x_step*80))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R18.scale.y = (((amp*sin(x+x_step*85))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R19.scale.y = (((amp*sin(x+x_step*90))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R20.scale.y = (((amp*sin(x+x_step*95))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R21.scale.y = (((amp*sin(x+x_step*100))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R22.scale.y = (((amp*sin(x+x_step*105))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R23.scale.y = (((amp*sin(x+x_step*110))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R24.scale.y = (((amp*sin(x+x_step*115))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R25.scale.y = (((amp*sin(x+x_step*120))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R26.scale.y = (((amp*sin(x+x_step*125))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R27.scale.y = (((amp*sin(x+x_step*130))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R28.scale.y = (((amp*sin(x+x_step*135))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R29.scale.y = (((amp*sin(x+x_step*140))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R30.scale.y = (((amp*sin(x+x_step*145))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R31.scale.y = (((amp*sin(x+x_step*150))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R32.scale.y = (((amp*sin(x+x_step*155))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R33.scale.y = (((amp*sin(x+x_step*160))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R34.scale.y = (((amp*sin(x+x_step*165))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R35.scale.y = (((amp*sin(x+x_step*170))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R36.scale.y = (((amp*sin(x+x_step*175))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R37.scale.y = (((amp*sin(x+x_step*180))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R38.scale.y = (((amp*sin(x+x_step*185))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R39.scale.y = (((amp*sin(x+x_step*190))*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R40.scale.y = (((amp*sin(x+x_step*195))*scale_slope)+scale_intercept)
	$Swimmer_1.position = Vector2(848.744,(((amp*sin(x+x_step*180))*pixel_slope)+pixel_intercept))
	
func requested_wave_display(wave):
	var baseline_x = 359#$Requested_Wave_Node/Swimmer_Request_1.position.x
	var baseline_y = 314.884#$Requested_Wave_Node/Swimmer_Request_1.position.y
	$Requested_Wave_Node/Swimmer_Request_1.position.y = ((wave[0]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_1.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_1.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_2.position.y = ((wave[5]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_2.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_2.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_3.position.y = ((wave[10]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_3.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_3.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_4.position.y = ((wave[15]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_4.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_4.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_5.position.y = ((wave[20]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_5.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_5.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_6.position.y = ((wave[25]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_6.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_6.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_7.position.y = ((wave[30]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_7.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_7.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_8.position.y = ((wave[35]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_8.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_8.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_9.position.y = ((wave[40]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_9.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_9.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_10.position.y = ((wave[45]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_10.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_10.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_11.position.y = ((wave[50]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_11.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_11.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_12.position.y = ((wave[55]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_12.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_12.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_13.position.y = ((wave[60]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_13.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_13.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_14.position.y = ((wave[65]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_14.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_14.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_15.position.y = ((wave[70]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_15.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_15.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_16.position.y = ((wave[75]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_16.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_16.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_17.position.y = ((wave[80]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_17.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_17.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_18.position.y = ((wave[85]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_18.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_18.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_19.position.y = ((wave[90]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_19.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_19.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_20.position.y = ((wave[95]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_20.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_20.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_21.position.y = ((wave[100]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_21.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_21.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_22.position.y = ((wave[105]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_22.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_22.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_23.position.y = ((wave[110]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_23.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_23.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_24.position.y = ((wave[115]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_24.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_24.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_25.position.y = ((wave[120]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_25.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_25.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_26.position.y = ((wave[125]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_26.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_26.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_27.position.y = ((wave[130]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_27.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_27.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_28.position.y = ((wave[135]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_28.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_28.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_29.position.y = ((wave[140]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_29.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_29.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_30.position.y = ((wave[145]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_30.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_30.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_31.position.y = ((wave[150]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_31.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_31.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_32.position.y = ((wave[155]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_32.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_32.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_33.position.y = ((wave[160]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_33.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_33.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_34.position.y = ((wave[165]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_34.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_34.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_35.position.y = ((wave[170]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_35.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_35.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_36.position.y = ((wave[175]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_36.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_36.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_37.position.y = ((wave[180]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_37.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_37.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_38.position.y = ((wave[185]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_38.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_38.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_39.position.y = ((wave[190]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_39.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_39.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_40.position.y = ((wave[195]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_40.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_40.position.y-baseline_y))
	
func requested_wave_display_reversed(wave):
	var baseline_x = 359#$Requested_Wave_Node/Swimmer_Request_1.position.x
	var baseline_y = 314.884#$Requested_Wave_Node/Swimmer_Request_1.position.y
	#set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_1.position.x-baseline_x-10.203,$Requested_Wave_Node/Swimmer_Request_1.position.y-baseline_y))
	set_line2d(Vector2(359-baseline_x-10.203,314.884-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_1.position.y = ((wave[195]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_1.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_1.position.y-302.05))
	$Requested_Wave_Node/Swimmer_Request_2.position.y = ((wave[190]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_2.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_2.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_3.position.y = ((wave[185]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_3.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_3.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_4.position.y = ((wave[180]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_4.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_4.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_5.position.y = ((wave[175]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_5.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_5.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_6.position.y = ((wave[170]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_6.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_6.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_7.position.y = ((wave[165]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_7.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_7.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_8.position.y = ((wave[160]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_8.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_8.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_9.position.y = ((wave[155]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_9.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_9.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_10.position.y = ((wave[150]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_10.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_10.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_11.position.y = ((wave[145]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_11.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_11.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_12.position.y = ((wave[140]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_12.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_12.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_13.position.y = ((wave[135]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_13.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_13.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_14.position.y = ((wave[130]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_14.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_14.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_15.position.y = ((wave[125]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_15.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_15.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_16.position.y = ((wave[120]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_16.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_16.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_17.position.y = ((wave[115]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_17.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_17.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_18.position.y = ((wave[110]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_18.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_18.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_19.position.y = ((wave[105]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_19.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_19.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_20.position.y = ((wave[100]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_20.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_20.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_21.position.y = ((wave[95]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_21.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_21.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_22.position.y = ((wave[90]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_22.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_22.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_23.position.y = ((wave[85]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_23.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_23.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_24.position.y = ((wave[80]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_24.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_24.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_25.position.y = ((wave[75]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_25.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_25.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_26.position.y = ((wave[70]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_26.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_26.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_27.position.y = ((wave[65]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_27.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_27.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_28.position.y = ((wave[60]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_28.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_28.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_29.position.y = ((wave[55]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_29.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_29.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_30.position.y = ((wave[50]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_30.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_30.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_31.position.y = ((wave[45]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_31.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_31.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_32.position.y = ((wave[40]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_32.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_32.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_33.position.y = ((wave[35]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_33.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_33.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_34.position.y = ((wave[30]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_34.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_34.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_35.position.y = ((wave[25]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_35.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_35.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_36.position.y = ((wave[20]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_36.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_36.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_37.position.y = ((wave[15]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_37.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_37.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_38.position.y = ((wave[10]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_38.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_38.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_39.position.y = ((wave[5]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_39.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_39.position.y-baseline_y))
	$Requested_Wave_Node/Swimmer_Request_40.position.y = ((wave[0]*pixel_slope)+pixel_intercept)
	set_line2d(Vector2($Requested_Wave_Node/Swimmer_Request_40.position.x-baseline_x,$Requested_Wave_Node/Swimmer_Request_40.position.y-baseline_y))


func wave_check(wave): # use this to display the requested wave? Or something similar
	$Wave_Elements/Wave_R1.scale.y = ((wave[0]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R2.scale.y = ((wave[1]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R3.scale.y = ((wave[2]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R4.scale.y = ((wave[3]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R5.scale.y = ((wave[4]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R6.scale.y = ((wave[5]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R7.scale.y = ((wave[6]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R8.scale.y = ((wave[7]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R9.scale.y = ((wave[8]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R10.scale.y = ((wave[9]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R11.scale.y = ((wave[10]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R12.scale.y = ((wave[11]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R13.scale.y = ((wave[12]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R14.scale.y = ((wave[13]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R15.scale.y = ((wave[14]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R16.scale.y = ((wave[15]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R17.scale.y = ((wave[16]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R18.scale.y = ((wave[17]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R19.scale.y = ((wave[18]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R20.scale.y = ((wave[19]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R21.scale.y = ((wave[20]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R22.scale.y = ((wave[21]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R23.scale.y = ((wave[22]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R24.scale.y = ((wave[23]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R25.scale.y = ((wave[24]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R26.scale.y = ((wave[25]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R27.scale.y = ((wave[26]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R28.scale.y = ((wave[27]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R29.scale.y = ((wave[28]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R30.scale.y = ((wave[29]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R31.scale.y = ((wave[30]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R32.scale.y = ((wave[31]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R33.scale.y = ((wave[32]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R34.scale.y = ((wave[33]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R35.scale.y = ((wave[34]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R36.scale.y = ((wave[35]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R37.scale.y = ((wave[36]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R38.scale.y = ((wave[37]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R39.scale.y = ((wave[38]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R40.scale.y = ((wave[39]*scale_slope)+scale_intercept)
	#$Swimmer_1.position = Vector2(1035,((wave[36]*pixel_slope)+pixel_intercept))

func wave_check_reversed(wave): # not sure if needed
	$Wave_Elements/Wave_R1.scale.y = ((wave[39]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R2.scale.y = ((wave[38]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R3.scale.y = ((wave[37]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R4.scale.y = ((wave[36]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R5.scale.y = ((wave[35]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R6.scale.y = ((wave[34]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R7.scale.y = ((wave[33]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R8.scale.y = ((wave[32]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R9.scale.y = ((wave[31]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R10.scale.y = ((wave[30]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R11.scale.y = ((wave[29]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R12.scale.y = ((wave[28]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R13.scale.y = ((wave[27]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R14.scale.y = ((wave[26]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R15.scale.y = ((wave[25]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R16.scale.y = ((wave[24]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R17.scale.y = ((wave[23]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R18.scale.y = ((wave[22]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R19.scale.y = ((wave[21]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R20.scale.y = ((wave[20]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R21.scale.y = ((wave[19]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R22.scale.y = ((wave[18]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R23.scale.y = ((wave[17]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R24.scale.y = ((wave[16]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R25.scale.y = ((wave[15]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R26.scale.y = ((wave[14]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R27.scale.y = ((wave[13]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R28.scale.y = ((wave[12]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R29.scale.y = ((wave[11]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R30.scale.y = ((wave[10]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R31.scale.y = ((wave[9]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R32.scale.y = ((wave[8]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R33.scale.y = ((wave[7]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R34.scale.y = ((wave[6]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R35.scale.y = ((wave[5]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R36.scale.y = ((wave[4]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R37.scale.y = ((wave[3]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R38.scale.y = ((wave[2]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R39.scale.y = ((wave[1]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R40.scale.y = ((wave[0]*scale_slope)+scale_intercept)
	
func make_wave(amplitude,wavelength,decay,resolution,time):
	var wave = []
	var y: float = 0.0
	for x in range(0, time/resolution):
		y = (amplitude*exp(decay*(x*resolution))*sin(2*PI*(x*resolution)/wavelength))
		wave.append(y)
	return(wave)
	
func wave_compare_score(player_wave,requested_wave,score_array):
	var pw = player_wave
	var rw = requested_wave
	var diff: float = 0.0
	var size = player_wave.size()
	for i in range(0,size):
		diff = (roundf(((abs(pw[i]-rw[i]))*100)))/100
		#print(diff)
		if diff < 0.25:
			score_array.append(5)
		elif diff <= 0.5:
			score_array.append(4)
		elif diff <= 1:
			score_array.append(3)
		elif diff <= 1.5:
			score_array.append(2)
		elif diff <= 2:
			score_array.append(1)
		else:
			score_array.append(0)
	return(score_array)
	
func player_wave_anim_prep(player_wave,bars,gap):
	var player_wave_anim = player_wave
	for i in range(bars*gap):
		player_wave_anim.push_front(0)
		player_wave_anim.append(0)
	return(player_wave_anim)

func play_made_wave(player_wave_anim,index): #obsolete
	var wave = player_wave_anim
	$Wave_Elements/Wave_R1.scale.y = ((wave[index+39]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R2.scale.y = ((wave[index+38]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R3.scale.y = ((wave[index+37]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R4.scale.y = ((wave[index+36]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R5.scale.y = ((wave[index+35]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R6.scale.y = ((wave[index+34]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R7.scale.y = ((wave[index+33]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R8.scale.y = ((wave[index+32]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R9.scale.y = ((wave[index+31]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R10.scale.y = ((wave[index+30]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R11.scale.y = ((wave[index+29]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R12.scale.y = ((wave[index+28]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R13.scale.y = ((wave[index+27]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R14.scale.y = ((wave[index+26]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R15.scale.y = ((wave[index+25]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R16.scale.y = ((wave[index+24]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R17.scale.y = ((wave[index+23]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R18.scale.y = ((wave[index+22]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R19.scale.y = ((wave[index+22]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R20.scale.y = ((wave[index+20]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R21.scale.y = ((wave[index+19]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R22.scale.y = ((wave[index+18]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R23.scale.y = ((wave[index+17]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R24.scale.y = ((wave[index+16]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R25.scale.y = ((wave[index+15]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R26.scale.y = ((wave[index+14]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R27.scale.y = ((wave[index+13]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R28.scale.y = ((wave[index+12]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R29.scale.y = ((wave[index+11]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R30.scale.y = ((wave[index+10]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R31.scale.y = ((wave[index+9]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R32.scale.y = ((wave[index+8]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R33.scale.y = ((wave[index+7]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R34.scale.y = ((wave[index+6]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R35.scale.y = ((wave[index+5]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R36.scale.y = ((wave[index+4]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R37.scale.y = ((wave[index+3]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R38.scale.y = ((wave[index+2]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R39.scale.y = ((wave[index+1]*scale_slope)+scale_intercept)
	$Wave_Elements/Wave_R40.scale.y = ((wave[index]*scale_slope)+scale_intercept)
	$Swimmer_1.position = Vector2(1035,((wave[index+3]*pixel_slope)+pixel_intercept))

func disable_buttons(condition: bool):
	if condition == true:
		$Button_Container/Go_Button.disabled = true
		$P_Amp_SB_Container/P_Amp_SpinBox.editable = false
		$P_Wavelength_SB_Container/P_Wavelength_SpinBox.editable = false
		$R_Amp_SB_Container/R_Amp_SpinBox.editable = false
		$R_Wavelength_SB_Container/R_Wavelength_SpinBox.editable = false
		$Decay_SB_Container/Decay_SpinBox.editable = false
		$Active_Swimmer_SB_Container/Active_Swimmer_SpinBox.editable = false
	elif condition == false:
		$Button_Container/Go_Button.disabled = false
		$P_Amp_SB_Container/P_Amp_SpinBox.editable = true
		$P_Wavelength_SB_Container/P_Wavelength_SpinBox.editable = true
		$R_Amp_SB_Container/R_Amp_SpinBox.editable = true
		$R_Wavelength_SB_Container/R_Wavelength_SpinBox.editable = true
		$Decay_SB_Container/Decay_SpinBox.editable = true
		$Active_Swimmer_SB_Container/Active_Swimmer_SpinBox.editable = true

func _on_button_pressed():
	var wave = []
	var wave_anim = []
	disable_buttons(true)
	$Requested_Wave_Node/Requested_Wave_Line.position = Vector2(359,314.884)
	clear_line_2d()
	#hide_score_bands(false)
	requested_wave_display_reversed(requested_wave)
	sc = 0
	score = 0
	if active_swimmer == 1:
		$Requested_Wave_Node/Requested_Wave_Line.position = Vector2(542.654+10.203,315)#Vector2($Swimmer_2.position.x,$Swimmer_2.position.y)
		$Requested_Wave_Node/Requested_Wave_25_upper.position = Vector2($Swimmer_1.position.x+14.203,302.05)
		$Requested_Wave_Node/Requested_Wave_50_upper.position = Vector2($Swimmer_1.position.x+14.203,289.1)
		$Requested_Wave_Node/Requested_Wave_100_upper.position = Vector2($Swimmer_1.position.x+14.203,263.2)
		$Requested_Wave_Node/Requested_Wave_150_upper.position = Vector2($Swimmer_1.position.x+14.203,237.3)
		$Requested_Wave_Node/Requested_Wave_200_upper.position = Vector2($Swimmer_1.position.x+14.203,211.4)
		$Requested_Wave_Node/Requested_Wave_25_lower.position = Vector2($Swimmer_1.position.x+14.203,327.95)
		$Requested_Wave_Node/Requested_Wave_50_lower.position = Vector2($Swimmer_1.position.x+14.203,340.9)
		$Requested_Wave_Node/Requested_Wave_100_lower.position = Vector2($Swimmer_1.position.x+14.203,366.8)
		$Requested_Wave_Node/Requested_Wave_150_lower.position = Vector2($Swimmer_1.position.x+14.203,392.7)
		$Requested_Wave_Node/Requested_Wave_200_lower.position = Vector2($Swimmer_1.position.x+14.203,418.6)
	elif active_swimmer == 2:
		$Requested_Wave_Node/Requested_Wave_Line.position = Vector2($Swimmer_2.position.x+14.203,314.884)#Vector2($Swimmer_2.position.x,$Swimmer_2.position.y)
		$Requested_Wave_Node/Requested_Wave_25_upper.position = Vector2($Swimmer_2.position.x+14.203,302.05)
		$Requested_Wave_Node/Requested_Wave_50_upper.position = Vector2($Swimmer_2.position.x+14.203,289.1)
		$Requested_Wave_Node/Requested_Wave_100_upper.position = Vector2($Swimmer_2.position.x+14.203,263.2)
		$Requested_Wave_Node/Requested_Wave_150_upper.position = Vector2($Swimmer_2.position.x+14.203,237.3)
		$Requested_Wave_Node/Requested_Wave_200_upper.position = Vector2($Swimmer_2.position.x+14.203,211.4)
		$Requested_Wave_Node/Requested_Wave_25_lower.position = Vector2($Swimmer_2.position.x+14.203,327.95)
		$Requested_Wave_Node/Requested_Wave_50_lower.position = Vector2($Swimmer_2.position.x+14.203,340.9)
		$Requested_Wave_Node/Requested_Wave_100_lower.position = Vector2($Swimmer_2.position.x+14.203,366.8)
		$Requested_Wave_Node/Requested_Wave_150_lower.position = Vector2($Swimmer_2.position.x+14.203,392.7)
		$Requested_Wave_Node/Requested_Wave_200_lower.position = Vector2($Swimmer_2.position.x+14.203,418.6)
	elif active_swimmer == 3:
		$Requested_Wave_Node/Requested_Wave_Line.position = Vector2($Swimmer_3.position.x+14.203,314.884)#Vector2($Swimmer_2.position.x,$Swimmer_2.position.y)
		$Requested_Wave_Node/Requested_Wave_25_upper.position = Vector2($Swimmer_3.position.x+14.203,302.05)
		$Requested_Wave_Node/Requested_Wave_50_upper.position = Vector2($Swimmer_3.position.x+14.203,289.1)
		$Requested_Wave_Node/Requested_Wave_100_upper.position = Vector2($Swimmer_3.position.x+14.203,263.2)
		$Requested_Wave_Node/Requested_Wave_150_upper.position = Vector2($Swimmer_3.position.x+14.203,237.3)
		$Requested_Wave_Node/Requested_Wave_200_upper.position = Vector2($Swimmer_3.position.x+14.203,211.4)
		$Requested_Wave_Node/Requested_Wave_25_lower.position = Vector2($Swimmer_3.position.x+14.203,327.95)
		$Requested_Wave_Node/Requested_Wave_50_lower.position = Vector2($Swimmer_3.position.x+14.203,340.9)
		$Requested_Wave_Node/Requested_Wave_100_lower.position = Vector2($Swimmer_3.position.x+14.203,366.8)
		$Requested_Wave_Node/Requested_Wave_150_lower.position = Vector2($Swimmer_3.position.x+14.203,392.7)
		$Requested_Wave_Node/Requested_Wave_200_lower.position = Vector2($Swimmer_3.position.x+14.203,418.6)
	requested_wave_to_score = make_wave(test_amplitude,test_wavelength,decay,x_resolution,time)
	player_wave = make_wave(player_amplitude,player_wavelength,decay,x_resolution,time)
	#print(player_wave)
	#print(requested_wave_to_score)
	score_array = wave_compare_score(player_wave,requested_wave_to_score,score_array)
	print("score array")
	print(score_array)
#	var y: float = 0.0
#	for x in range(0, (5/0.01)):
#		#y = sin(x)
#		y = (5*exp(-0.3*(x*0.05))*sin(2*PI*(x*0.05)/1))
#		wave.append(y)
	#wave_check(wave)
	wave_anim = player_wave_anim_prep(wave,40,1)
	#print(wave_anim)
	wave_made = true
	return(wave_anim)
#	wave_check(wave_anim)
#	await get_tree().create_timer(2).timeout
#	wave_made = false
#	x_for_waves = 0



func _on_p_amp_spin_box_value_changed(value):
	player_amplitude = get_node("P_Amp_SB_Container/P_Amp_SpinBox").get_value()
	print("Player Amplitude Changed to: " + str(player_amplitude))
	



func _on_p_wavelength_spin_box_value_changed(value):
	player_wavelength = get_node("P_Wavelength_SB_Container/P_Wavelength_SpinBox").get_value()
	print("Player Wavelength Changed to: " + str(player_wavelength))


func _on_r_amp_spin_box_value_changed(value):
	test_amplitude = get_node("R_Amp_SB_Container/R_Amp_SpinBox").get_value()
	print("Requested Amplitude Changed to: " + str(test_amplitude))
	clear_line_2d()
	requested_wave = make_wave(test_amplitude,test_wavelength,decay,x_resolution,time)
	#print(requested_wave)
	requested_wave.reverse()
	requested_wave_display(requested_wave)



func _on_r_wavelength_spin_box_value_changed(value):
	test_wavelength = get_node("R_Wavelength_SB_Container/R_Wavelength_SpinBox").get_value()
	print("Requested Wavelength Changed to: " + str(test_wavelength))
	clear_line_2d()
	requested_wave = make_wave(test_amplitude,test_wavelength,decay,x_resolution,time)
	#print(requested_wave)
	requested_wave.reverse()
	requested_wave_display(requested_wave)


func _on_decay_spin_box_value_changed(value):
	decay = get_node("Decay_SB_Container/Decay_SpinBox").get_value()
	print("Decay Changed to: " + str(decay))


func _on_active_swimmer_spin_box_value_changed(value):
	active_swimmer = get_node("Active_Swimmer_SB_Container/Active_Swimmer_SpinBox").get_value()
	print("Decay Changed to: " + str(active_swimmer))


func _on_score_band_toggle_toggled(button_pressed):
	if button_pressed == true:
		hide_score_bands(false)
		$Score_Band_Toggle_Container/Score_Band_Toggle.text = "Score Bands: On"
	else:
		hide_score_bands(true)
		$Score_Band_Toggle_Container/Score_Band_Toggle.text = "Score Bands: Off"
		



func _on_stop_button_pressed():
	wave_made = false
	wave_computed = false
	clear_line_2d()
	score = 0
	disable_buttons(false)
	$Requested_Wave_Node/Requested_Wave_Line.position = Vector2(295,314.884)
	$Requested_Wave_Node/Requested_Wave_25_upper.position = Vector2(295,302.05)
	$Requested_Wave_Node/Requested_Wave_25_lower.position = Vector2(295,327.95)
	$Requested_Wave_Node/Requested_Wave_50_upper.position = Vector2(295,289.1)
	$Requested_Wave_Node/Requested_Wave_50_lower.position = Vector2(295,340.9)
	$Requested_Wave_Node/Requested_Wave_100_upper.position = Vector2(295,263.2)
	$Requested_Wave_Node/Requested_Wave_100_lower.position = Vector2(295,366.8)
	$Requested_Wave_Node/Requested_Wave_150_upper.position = Vector2(295,237.3)
	$Requested_Wave_Node/Requested_Wave_150_lower.position = Vector2(295,392.7)
	$Requested_Wave_Node/Requested_Wave_200_upper.position = Vector2(295,211.4)
	$Requested_Wave_Node/Requested_Wave_200_lower.position = Vector2(295,418.6)
	requested_wave_display(requested_wave)


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/wavemaker_easy_mode.tscn")


func _on_sim_button_pressed():
	get_tree().change_scene_to_file("res://scenes/wave_simulation.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
