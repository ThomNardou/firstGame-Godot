extends CanvasLayer

signal startGame

func show_message(txt):
	$Message.text = txt
	$Message.show()
	$MessageTimer.start()

func gameOver_message():
	show_message("Game Over !!")
	await  $MessageTimer.timeout
	
	$Message.text = "Welcome"
	$Message.show()
	
	await  get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	startGame.emit()

func _on_message_timer_timeout():
	$Message.hide()
