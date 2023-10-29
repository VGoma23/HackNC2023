# NOTE: this operates on datetime strings
extends Object

var lastWateredDate: String
var wateringInterval: int
var plantName: String
var numTimesWatered: int
var cuteName: String
var positionX: int
var positionY: int

var sunCoverage: String
var daysToMaturity: int
var plantImagePath: String

@export var DEV_DAY_OFFSET = 0

func _init(plant_name="tomatoes", last_watered=Time.get_datetime_string_from_system(), position_x=0, position_y=0, num_times_watered = 0, cute_name = null,):
	var dict = {}
	var json_as_text = FileAccess.get_file_as_string("res://Data/HackNC_2023_crop_data.json")
	var json_as_dict = JSON.parse_string(json_as_text)
	
	plantName = plant_name
	lastWateredDate = last_watered
	for object in json_as_dict:
		if object["crop"] == plantName:
			wateringInterval = object["water_every_n_days"]
			print(wateringInterval)
			sunCoverage = object["sun_coverage"]
			daysToMaturity = object["days_to_maturity"]
			plantImagePath = object["image_link"]
			break
		
	
	numTimesWatered = num_times_watered
	positionX = position_x
	positionY = position_y
	if cute_name == null:
		cuteName= plantName
	else:
		cuteName = cute_name
		

func toJSON():
	var data_to_save = {
		"cuteName": cuteName,
		"lastWateredDate": lastWateredDate,
		"wateringInterval": wateringInterval,
		"numTimesWatered": numTimesWatered,
		"plantName": plantName,
		"positionX": positionX,
		"positionY": positionY,
		"DEV_DAY_OFFSET": DEV_DAY_OFFSET
	}
	return data_to_save
	
	
func createFromJSON():
	pass

	
func isThirsty():
	var lastWateredDict = Time.get_datetime_dict_from_datetime_string(lastWateredDate, false)
	var todayDict = Time.get_datetime_dict_from_system()
	todayDict["day"] += DEV_DAY_OFFSET
	return days_between(lastWateredDict, todayDict) >= wateringInterval

func getDaysSinceLastWater():
	var lastWateredDict = Time.get_datetime_dict_from_datetime_string(lastWateredDate, false)
	var todayDict = Time.get_datetime_dict_from_system()
	todayDict["day"] += DEV_DAY_OFFSET
	return days_between(lastWateredDict, todayDict)

func isStreakBroken():
	var lastWateredDict = Time.get_datetime_dict_from_datetime_string(lastWateredDate, false)
	var todayDict = Time.get_datetime_dict_from_system()
	todayDict["day"] += DEV_DAY_OFFSET
	return days_between(lastWateredDict, todayDict) - wateringInterval > 0

var days_in_month = {
	1: 31,  # January
	2: 28,  # February
	3: 31,  # March
	4: 30,  # April
	5: 31,  # May
	6: 30,  # June
	7: 31,  # July
	8: 31,  # August
	9: 30,  # September
	10: 31, # October
	11: 30, # November
	12: 31  # December
}


func days_between(date1: Dictionary, date2: Dictionary) -> int:

	var days_date1 = date1["day"]
	var month1 = date1["month"]
	var year1 = date1["year"]

	var days_date2 = date2["day"]
	var month2 = date2["month"]
	var year2 = date2["year"]

	var days_count = 0

	# Calculate days for the starting year
	var month = month1
	while month <= 12:
		if month == month1:
			days_count += days_in_month[month] - days_date1
		else:
			days_count += days_in_month[month]
		month += 1

	# If the dates are in the same year, return the calculated days
	if year1 == year2:
		if month1 == month2:
			return days_date2 - days_date1
		return days_count

	# Add days for the remaining months of the starting year
	var remaining_days = days_date2
	var remaining_months = month2 - 1
	while remaining_months > 0:
		remaining_days += days_in_month[remaining_months]
		remaining_months -= 1

	# Days left in the first year + days in the last year + days for full years in between
	return abs(days_count + remaining_days)
