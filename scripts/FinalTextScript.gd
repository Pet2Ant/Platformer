extends RichTextLabel

var inputText = "By the end of his journey, having submitted his dissertation successfully, Co-Pi was reminded of a specific segment on the syllabus that he hadn't bothered to read... 
'Please note that all work submitted for this course must be your own. The use of generative AI or similar technologies to complete assignments is not permitted and will result in a failing grade for the assignment, probation, suspension, or expulsion from the institution'
This little oversight resulted in Co-Pi being placed on academic probation. Halting his studies, for now at least..."
var count = 0
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
	#for i in inputText:
		#count += 1
		#print(count)
	#print(LevelManager.loaded_level)
	for i in get_parsed_text():
		visible_characters += 6
		await get_tree().create_timer(0.1).timeout
		count += 1 
		#print(count)
		transition(count)

func transition(count):
	if count == 558/6:
		LevelManager.unload_level()
		get_tree().current_scene.find_child("UI Main").find_child("Control").reactivate()
		load("res://scenes/main_menu.tscn")
