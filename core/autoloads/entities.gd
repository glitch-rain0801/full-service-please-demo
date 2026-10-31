extends Node

const SPRITE_DIMENSIONS: Vector2 = Vector2(256.0, 416.0)

var masseurs: Dictionary = {
	"kovit": preload("res://entities/masseurs/kovit/kovit_stats.tres"),
	"rald": preload("res://entities/masseurs/rald/rald_stats.tres"),
	"remi": preload("res://entities/masseurs/remi/remi_stats.tres"),
	"sota": preload("res://entities/masseurs/sota/sota_stats.tres"),
	"lenga": preload("res://entities/masseurs/lenga/lenga_stats.tres"),
	"okan": preload("res://entities/masseurs/okan/okan_stats.tres"),
	"oki": preload("res://entities/masseurs/oki/oki_stats.tres"),
}

var clients: Dictionary = {
	"bara_black": preload("res://entities/clients/black/bara_black.tres"),
	"bara_white": preload("res://entities/clients/white/bara_white.tres"),
	"bear_black": null,
	"bear_white": null,
	#"shota_black": null,
	#"shota_white": null,
	"twink_black": null,
	"twink_white": null,
	"tomoki": null,
	"burton": null,
	"evan": null,
	"haruo": null,
	"hunter": null,
	"jacob": null,
	"john": null,
	"ken": null,
	"keoni": null,
	"rudolph": null,
	"xavier": null
}
