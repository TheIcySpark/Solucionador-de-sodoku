extends LineEdit
onready var pos=$"."

func ObtenerNumero()->int:
	return int(pos.text)