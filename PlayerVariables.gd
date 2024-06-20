extends Node

var hud = null
var anxiety = 50
var zones = []
	
func set_hud(hud_param):
	hud = hud_param
	
func update_anxiety():
	if zones.size() > 0:
		anxiety = anxiety + zones[0].drain
		if hud != null:
			hud.update()
		
func add_zone(id, priority, drain):
	var found = false
	for zone in zones:
		if zone.id == id:
			found = true

	if !found:
		zones.push_back({
			"id": id,
			"priority": priority,
			"drain": drain
		})
		zones.sort_custom(func(a, b): return a["priority"] < b["priority"])
	
func remove_zone(id):
	for index in range(zones.size()):
		if(zones[index]["id"] == id):
			zones.remove_at(index)
			break
