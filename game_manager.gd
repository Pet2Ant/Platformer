extends Node

@onready var points_label = %PointsLabel

var points = 0;

func add_point() :
	points += 1;
	print("Points: ", points);
	points_label.text = "Points: " +  str(points*5);
