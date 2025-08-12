#
# © 2024-present https://github.com/cengiz-pz
#

class_name DeeplinkUrl extends RefCounted

const SCHEME_PROPERTY: String = "scheme"
const USER_PROPERTY: String = "user"
const PASSWORD_PROPERTY: String = "password"
const HOST_PROPERTY: String = "host"
const PORT_PROPERTY: String = "port"
const PATH_PROPERTY: String = "path"
const PATH_EXTENSION_PROPERTY: String = "pathExtension"
const PATH_COMPONENTS_PROPERTY: String = "pathComponents"
const PARAMETER_STRING_PROPERTY: String = "parameterString"
const QUERY_PROPERTY: String = "query"
const FRAGMENT_PROPERTY: String = "fragment"

var _data: Dictionary


func _init(a_data: Dictionary = {}):
	_data = {
		SCHEME_PROPERTY: a_data[SCHEME_PROPERTY] if a_data.has(SCHEME_PROPERTY) else "",
		USER_PROPERTY: a_data[USER_PROPERTY] if a_data.has(USER_PROPERTY) else "",
		PASSWORD_PROPERTY: a_data[PASSWORD_PROPERTY] if a_data.has(PASSWORD_PROPERTY) else "",
		HOST_PROPERTY: a_data[HOST_PROPERTY] if a_data.has(HOST_PROPERTY) else "",
		PORT_PROPERTY: a_data[PORT_PROPERTY] if a_data.has(PORT_PROPERTY) else -1,
		PATH_PROPERTY: a_data[PATH_PROPERTY] if a_data.has(PATH_PROPERTY) else "",
		PATH_EXTENSION_PROPERTY: a_data[PATH_EXTENSION_PROPERTY] if a_data.has(PATH_EXTENSION_PROPERTY) else "",
		PATH_COMPONENTS_PROPERTY: a_data[PATH_COMPONENTS_PROPERTY] if a_data.has(PATH_COMPONENTS_PROPERTY) else [],
		PARAMETER_STRING_PROPERTY: a_data[PARAMETER_STRING_PROPERTY] if a_data.has(PARAMETER_STRING_PROPERTY) else "",
		QUERY_PROPERTY: a_data[QUERY_PROPERTY] if a_data.has(QUERY_PROPERTY) else "",
		FRAGMENT_PROPERTY: a_data[FRAGMENT_PROPERTY] if a_data.has(FRAGMENT_PROPERTY) else ""
	}


func get_data() -> Dictionary:
	return _data


func get_scheme() -> String:
	return _data[SCHEME_PROPERTY]


func get_user() -> String:
	return _data[USER_PROPERTY]


func get_password() -> String:
	return _data[PASSWORD_PROPERTY]


func get_host() -> String:
	return _data[HOST_PROPERTY]


func get_port() -> int:
	return _data[PORT_PROPERTY]


func get_path() -> String:
	return _data[PATH_PROPERTY]


func get_path_extension() -> String:
	return _data[PATH_EXTENSION_PROPERTY]


func get_path_components() -> Array:
	return _data[PATH_COMPONENTS_PROPERTY]


func get_parameter_string() -> String:
	return _data[PARAMETER_STRING_PROPERTY]


func get_query() -> String:
	return _data[QUERY_PROPERTY]


func get_fragment() -> String:
	return _data[FRAGMENT_PROPERTY]


func set_scheme(a_value: String) -> void:
	_data[SCHEME_PROPERTY] = a_value


func set_user(a_value: String) -> void:
	_data[USER_PROPERTY] = a_value


func set_password(a_value: String) -> void:
	_data[PASSWORD_PROPERTY] = a_value


func set_host(a_value: String) -> void:
	_data[HOST_PROPERTY] = a_value


func set_port(a_value: int) -> void:
	_data[PORT_PROPERTY] = a_value


func set_path(a_value: String) -> void:
	_data[PATH_PROPERTY] = a_value


func set_path_extension(a_value: String) -> void:
	_data[PATH_EXTENSION_PROPERTY] = a_value


func set_path_components(a_value: Array) -> void:
	_data[PATH_COMPONENTS_PROPERTY] = a_value


func set_parameter_string(a_value: String) -> void:
	_data[PARAMETER_STRING_PROPERTY] = a_value


func set_query(a_value: String) -> void:
	_data[QUERY_PROPERTY] = a_value


func set_fragment(a_value: String) -> void:
	_data[FRAGMENT_PROPERTY] = a_value
