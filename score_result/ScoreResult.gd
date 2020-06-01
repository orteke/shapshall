extends Control

var score = {
			"last":0,
			"best":0
		}

func _ready():
	# load score
	var score_file = File.new()

	# Return 'empty' if file doesn't exist
	if not score_file.file_exists("user://score.json"):
		score = {
			"last":0,
			"best":0
		}
		
		score_file.open("user://score.json", File.WRITE)
		score_file.store_line(to_json(score))
	else:
		# Open your file
		score_file.open("user://score.json", File.READ)
		score = parse_json(score_file.get_as_text())

		if score == null:
			score = {
				"last":0,
				"best":0
			}
			score_file.open("user://score.json", File.WRITE)
			score_file.store_line(to_json(score))
			
	$Display.text = "Last: " + str(score.last) + "\nBest: " + str(score.best)

	# Close file 
	score_file.close()
