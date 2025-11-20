extends CharacterBody2D


const SPEED = 75#150.0
const JUMP_VELOCITY =-512 #-725 at regular grav

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 980/2#(ProjectSettings.get_setting("physics/2d/default_gravity"))/2
var amplitude_out: float = 0
var wavelength_out: float = 0
var y_to_amp: float = 0.0
var x_to_wl: float = 0.0 
var can_move = true
var ground_pound = false
var wave_triggered = false
var ready_to_process = true
signal wave_is_triggered(condition: bool)

func _physics_process(delta):
	if ready_to_process == false:
		pass
	elif ready_to_process == true:
		if y_to_amp < 0:
			y_to_amp = 0
		if wave_triggered == true:
				emit_signal("wave_is_triggered",true)
				wave_triggered = false
				wave_trigger_pause()
				#await get_tree().create_timer(14).timeout
		if ground_pound == false:
			wave_triggered = false# this somewhat helped, but not triggering again?
			#gravity = (ProjectSettings.get_setting("physics/2d/default_gravity"))/2
			y_to_amp = (roundf(((position.y)*-0.0277+6.918)*10))/10
			if y_to_amp < 0:
				y_to_amp = 0
			x_to_wl = (roundf(((position.x)*0.0222-0.5221)*10))/10
			if not is_on_floor():
				velocity.y += gravity * delta
				if Input.is_action_just_pressed("ui_accept"):
					ground_pound = true
					velocity.y = 0
					velocity.y += (gravity*50) * delta
					if wave_triggered == false:
						amplitude_out = (roundf(((position.y)*-0.0277+6.918)*10))/10
						wavelength_out = (roundf(((position.x)*0.0222-0.5221)*10))/10
					print(amplitude_out)
		#			print(wavelength_out)
		#			print(gravity)
		elif ground_pound == true:
			if is_on_floor():
				wave_triggered = true
				print("wave triggered")
				print(wave_triggered)
				#emit_signal("wave_is_triggered",true)
				#await get_tree().create_timer(2).timeout
				ground_pound = false
			else:
				wave_triggered = false
			#wave_triggered = false
				

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if ready_to_process == true:
			velocity.y = JUMP_VELOCITY
		elif ready_to_process == false:
			print("no jumping")
		#print(velocity.y)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if ground_pound == false:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	elif ground_pound == true:
		pass
		
	

	move_and_slide()

func wave_trigger_pause():
	ready_to_process = false #test making a function that is called in the process line after wave_trigger changes state, this starts a timer that changes a bool variable after a set amount of time. Then, have the process flow include a check for that bool, superceeding all other functions until the timer is done
	await get_tree().create_timer(14).timeout
	ready_to_process = true
