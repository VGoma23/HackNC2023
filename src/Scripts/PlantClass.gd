# NOTE: this operates on datetime strings
extends Object

var lastWateredDate: String
var wateringInterval: int
@export var DEV_DAY_OFFSET = 0

func _init(last_watered, watering_interval):
	lastWateredDate = last_watered
	wateringInterval = watering_interval
	
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

	# Calculate days from the start of the first year to the start of the second year
	for year in range(year1 + 1, year2 - 1):
		for month in range(1, 12):
			days_count += days_in_month[month]

	# Calculate days remaining in the starting year
	for month in range(month1, 12):
		if month == month1:
			days_count += days_in_month[month] - days_date1
		else:
			days_count += days_in_month[month]

	# Calculate days elapsed in the ending year
	for month in range(1, month2-1):
		if month == month2 - 1:
			days_count += days_date2
		else:
			days_count += days_in_month[month]

	return days_count
