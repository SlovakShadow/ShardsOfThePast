extends Node
var files = []
onready var global_vars = get_node("/root/global_variables")

func list_files_in_directory(path):
	files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.ends_with(".pck"):
			files.append(file)

	dir.list_dir_end()

	return files

#func _ready():
#	_save()
#	_load()

func _save(Level, HP):
	# Create an empty string to hold the information
	var data = ""
	# Strings can be added to each other
	# Convert the numbers to strings with str()
	data += "HP: " + str(HP)
		# Save different variables on different lines by adding a linebreak (\n)
	data += "\n"
	data += "MaxHP: " + str(global_vars.maxHP)
	data += "\n"
	data += "Level: " + str(Level)
	data += "\n"
	if Level >= global_vars.maxBeatenLevel:
		data += "hBl: " + str(Level)
		data += "\n"
	else:
		data += "hBl: " + str(global_vars.maxBeatenLevel)
		data += "\n"
	data += "Shader1: " + str(global_vars.tv_overlay)
	data += "\n"
	if global_vars.tumblebladeBeaten == true:
		data += "tbBeaten: " + str(global_vars.tumblebladeBeaten)
		data += "\n"
	else:
		data += "tbBeaten: "
		data += "\n"
	if global_vars.fieryGoliathBeaten == true:
		data += "fgBeaten: " + str(global_vars.blightmotherBeaten)
		data += "\n"
	else:
		data += "fgBeaten: "
		data += "\n"
	if global_vars.blightmotherBeaten == true:
		data += "bmBeaten: " + str(global_vars.blightmotherBeaten)
		data += "\n"
	else:
		data += "bmBeaten: "
		data += "\n"
	if global_vars.leviathanBeaten == true:
		data += "levBeaten: " + str(global_vars.blightmotherBeaten)
		data += "\n"
	else:
		data += "levBeaten: "
		data += "\n"
	if global_vars.steppedOnMine == true:
		data += "mine: " + str(global_vars.steppedOnMine)
		data += "\n"
	else:
		data += "mine: "
		data += "\n"
	if global_vars.srlBeaten == true:
		data += "srlBeaten: " + str(global_vars.srlBeaten)
		data += "\n"
	else:
		data += "srlBeaten: "
		data += "\n"
	data += "srlAmount: " + str(global_vars.srlAmount)
	data += "\n"
	if global_vars.hp0taken == true:
		data += "hp0taken: " + str(global_vars.hp0taken)
		data += "\n"
	else:
		data += "hp0taken: "
		data += "\n"
	if global_vars.hp1taken == true:
		data += "hp1taken: " + str(global_vars.hp1taken)
		data += "\n"
	else:
		data += "hp1taken: "
		data += "\n"
	if global_vars.hp2taken == true:
		data += "hp2taken: " + str(global_vars.hp2taken)
		data += "\n"
	else:
		data += "hp2taken: "
		data += "\n"
	if global_vars.hp3taken == true:
		data += "hp3taken: " + str(global_vars.hp3taken)
		data += "\n"
	else:
		data += "hp3taken: "
		data += "\n"
	if global_vars.hp4taken == true:
		data += "hp4taken: " + str(global_vars.hp4taken)
		data += "\n"
	else:
		data += "hp4taken: "
		data += "\n"
	# Declare a variable of the "File" class and open the savegame file
	var new_file = File.new()
	new_file.open("res://savegame.txt", File.WRITE)
	# Store the data and close the file
	new_file.store_line(data)
	new_file.close()

func _load():
	list_files_in_directory("res://")
	for i in len(files):
		print("Loading ", files[i], "...")
		ProjectSettings.load_resource_pack(files[i])
		print("Loaded ", files[i], "!")
	#Hardcoded loading of a test mod
#	ProjectSettings.load_resource_pack("res://WatermonPack.pck")
	# Declare a variable of the "File" class
	var new_file = File.new()
	# See if there is a savegame to load, else stop
	if not new_file.file_exists("res://savegame.txt"):
		return
	# Read the contents of the savegame
	new_file.open("res://savegame.txt", File.READ)
	# Assign a variable to the contents of the file
	# get_as_text() means it's in the form of a string
	var data = new_file.get_as_text()
	# Close the File, as we don't need it anymore
	new_file.close()
	# Separate the lines of the savegame by splitting them
	# "data" is now no longer a string, but a list of strings
	data = data.split("\n")
	# Go through the lines one by one
	for line in data:
		# If the line begins with "HP" we know it contains the players HP
		if line.begins_with("HP:"):
			# Create a list with split() out of the line, the number 1 of that list    is now the players HP
			# It is given as a string, so int() converts it to a number, bool() to a true/false, etc.
			global_vars.currentHP = int(line.split(" ")[1])
		elif line.begins_with("MaxHP:"):
			global_vars.maxHP = int(line.split(" ")[1])
		elif line.begins_with("Level:"):
			global_vars.currentLevel = int(line.split(" ")[1])
		elif line.begins_with("hBl:"):
			global_vars.maxBeatenLevel = int(line.split(" ")[1])
		elif line.begins_with("Shader1:"):
			global_vars.tv_overlay = int(line.split(" ")[1])
		elif line.begins_with("tbBeaten:"):
			global_vars.tumblebladeBeaten = bool(line.split(" ")[1])
		elif line.begins_with("fgBeaten:"):
			global_vars.fieryGoliathBeaten = bool(line.split(" ")[1])
		elif line.begins_with("bmBeaten:"):
			global_vars.blightmotherBeaten = bool(line.split(" ")[1])
		elif line.begins_with("mine:"):
			global_vars.steppedOnMine = bool(line.split(" ")[1])
		elif line.begins_with("srlBeaten:"):
			global_vars.srlBeaten = bool(line.split(" ")[1])
		elif line.begins_with("srlAmount:"):
			global_vars.srlAmount = int(line.split(" ")[1])
		elif line.begins_with("hp1taken:"):
			global_vars.hp1taken = bool(line.split(" ")[1])
		elif line.begins_with("hp2taken:"):
			global_vars.hp2taken = bool(line.split(" ")[1])
		elif line.begins_with("hp3taken:"):
			global_vars.hp3taken = bool(line.split(" ")[1])
		elif line.begins_with("hp4taken:"):
			global_vars.hp4taken = bool(line.split(" ")[1])
		#global_vars.maxBeatenLevel = 6
