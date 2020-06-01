extends Node

func _ready():
	$Admob.load_banner()
	$Admob.banner_resize()
	$Admob.show_banner()


func _on_Ads_tree_exited():
	$Admob.hide_banner()
