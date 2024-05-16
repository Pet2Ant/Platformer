extends RichTextLabel

var inputText = "In a world where circuits and gears define one’s worth, one robot dares to dream beyond the assembly line. \n Driven by an insatiable thirst for knowledge, our hero embarks on a quest for the ultimate recognition - a degree. \n But this is no ordinary degree. \n It’s a testament of skill, courage, and perseverance, only awarded to those who can conquer a series of formidable challenges. \n Join our robot protagonist as he adventures onwards, outwittting cunning adversaries, and defies all odds to prove that he’s more than just a machine. \n Will he succeed and earn his place among the intellectual elite?"
var count = 0
var skip = false;
func _ready() -> void:
	scroll_text(inputText)

func scroll_text(input_text:String) -> void:
	visible_characters = 0
	text = input_text
	
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	
	text_direction = Control.TEXT_DIRECTION_LTR
	
	custom_minimum_size = Vector2(600,200)
	for i in get_parsed_text():
		visible_characters += 3
		if  Input.get_axis("Left", "Right"):
			skip = true
		await get_tree().create_timer(0.1).timeout
		count += 1 
		print(count)
		transition(count)
	 
#
func transition(count):
	if skip == false:
		if count == 606/3:
			GameManager.load_world()
	else:
			GameManager.load_world()
