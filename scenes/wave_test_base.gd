extends Node2D
var x_for_waves = 0
var x_step = 0.025
var wave_made = false
var scale_slope = 0.072
var scale_intercept = 0.411
var pixel_slope = -51.8
var pixel_intercept = 315

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	x_for_waves += x_step
	if wave_made == false:
		test_sine_wave(x_for_waves,0.1)


func test_sine_wave(x,amp):
	var y_wave: float = 0.0
#	var scale_slope = 0.072
#	var scale_intercept = 0.411
#	var pixel_slope = -51.8
#	var pixel_intercept = 315
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
	$Swimmer_1.position = Vector2(1035,(((amp*sin(x+x_step*180))*pixel_slope)+pixel_intercept))
	
func wave_check(wave):
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
	$Swimmer_1.position = Vector2(1035,((wave[36]*pixel_slope)+pixel_intercept))

	
func make_wave(amplitude,wavelength,decay,resolution,time):
	var wave = []
	var y: float = 0.0
	for x in range(0, 5, 0.1):
		y = (amplitude*exp((0-decay)*x)*sin(2*PI*x/wavelength))
		wave.append(y)
	return(wave)

func _on_button_pressed():
	wave_made = true
	var wave = []
	#wave = make_wave(5,1,-0.3,0.1,6)
	var y: float = 0.0
	for x in range(0, (5/0.01)):
		#y = sin(x)
		y = (5*exp(-0.3*(x*0.05))*sin(2*PI*(x*0.05)/1))
		wave.append(y)
	print(wave)
	wave_check(wave)
	await get_tree().create_timer(2).timeout
	wave_made = false
	x_for_waves = 0
