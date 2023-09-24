extends PanelContainer

@onready var  entry = $MarginContainer/VBoxContainer/ConnectionString

const PORT = 9999
@export var scene_player = preload("res://Scenes/Player.tscn")
var enet_peer = ENetMultiplayerPeer.new()

#makes ure to select public
func _on_button_host_pressed():
	hide()
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	
	add_player(multiplayer.get_unique_id())


func _on_button_connect_pressed():
	hide()
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer
	



func add_player(peer_id):
	var player = scene_player.instantiate()
	player.position = Vector3(0,0,0)
	player.name = str(peer_id)
	get_parent().get_parent().add_child(player)
	
