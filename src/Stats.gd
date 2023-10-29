extends Node

var plantsWatered : int
var plantsPlanted : int
var daysPlayed : int
var waterStreak : int

func toJSON():
	var data_to_save = {
		"plantsWatered": plantsWatered,
		"plantsPlanted": plantsPlanted,
		"daysPlayed": daysPlayed,
		"waterStreak": waterStreak,
	}
	return data_to_save
