extends PanelContainer
class_name RoomMetrics

@onready var state: Label = $VBoxContainer/Info/State
@onready var duration: Label = $VBoxContainer/Info/Duration
@onready var action: Label = $VBoxContainer/Info/Action

@export var service_timer: Timer

const STATE_PREFIX: String = "State: "
const DURATION_PREFIX: String = "Duration: "

var test_overlay: TestOverlay


func _ready() -> void:
	state.text = STATE_PREFIX + "Idle"
	duration.text = DURATION_PREFIX + "N/A"
	action.text = "<No Action>"
	
	test_overlay = Global.main.get_current_debug_scene()
	service_timer.timeout.connect(_on_service_timer_timeout)


func _process(_delta: float) -> void:
	if not service_timer.is_stopped():
		update_duration(str(snappedf(service_timer.time_left, 0.1)))


func update_room_metrics(state_text: String, duration_text: String, action_text: String) -> void:
	state.text = STATE_PREFIX + state_text
	action.text = action_text

	var seconds: float = float(duration_text)
	service_timer.start(seconds)


func update_duration(duration_text: String) -> void:
	duration.text = DURATION_PREFIX + duration_text + "s"


func _on_service_timer_timeout() -> void:
	update_duration("0.0")
	test_overlay.service_finished.emit()
