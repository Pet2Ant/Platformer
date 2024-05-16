extends Label

var example_text = "In a world where circuits and gears define one’s worth, one robot dares to dream beyond the assembly line. \n Driven by an insatiable thirst for knowledge, our hero embarks on a quest for the ultimate recognition - a degree. \n But this is no ordinary degree. \n It’s a testament of skill, courage, and perseverance, only awarded to those who can conquer a series of formidable challenges. \n Join our robot protagonist as he adventures onwards, outwittting cunning adversaries, and defies all odds to prove that he’s more than just a machine. \n Will he succeed and earn his place among the intellectual elite?"

func _ready() -> void:
	scroll_text(example_text)
	
func scroll_text(input_text:String) -> void:
	visible_characters = 0
	text = input_text
	
	for i in text.length():
		visible_characters += 1
		await get_tree().create_timer(0.1).timeout
