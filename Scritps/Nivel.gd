extends CanvasLayer
onready var botonResolver=$Resolver
onready var retroalimentacion=$Retroalimentacion
var cuadricula

func _ready():
	cuadricula=get_tree().get_nodes_in_group("elementoCuadricula")

func ConfiguracionValida()->bool:
	var i=0
	var j
	var k
	var z
	var num
	var digitos=[]
	#Revision horizontal
	while i<=72:
		j=0
		digitos=[]
		while j<=8:
			num=cuadricula[i+j].ObtenerNumero() 
			if num in digitos and num!=0: return false
			else: digitos.append(num)
			j+=1
		i+=9
	i=0
	#Revision vertical
	while i<=8:
		j=0
		digitos=[]
		while j<=72:
			num=cuadricula[i+j].ObtenerNumero()
			if num in digitos and num!=0: return false
			else: digitos.append(num)
			j+=9
		i+=1
	i=0
	#Revision cuadricula 3*3
	while i<=54:
		j=0
		while j<=6:
			digitos=[]
			k=0
			while k<=18:
				z=0
				while z<=2:
					num=cuadricula[i+j+k+z].ObtenerNumero()
					if num in digitos and num!=0: return false
					else: digitos.append(num)
					z+=1
				k+=9
			j+=3
		i+=9*3
	return true;

func CeldaSinAsignar(i)->bool:
	if cuadricula[i].ObtenerNumero()==0: return true
	else: return false

func Resolver(i)->bool:
	if(i>=81): return true
	if CeldaSinAsignar(i):
		var posibleNum=1
		while posibleNum<=9:
			cuadricula[i].text=str(posibleNum)
			if (ConfiguracionValida()):
				if(Resolver(i+1)): return true
			posibleNum+=1
			cuadricula[i].text=str(0)
		return false
	else:
		return Resolver(i+1)
	

func _on_Resolver_button_up():
	if ConfiguracionValida():
		retroalimentacion.text="Configuracion valida"
		if Resolver(0): retroalimentacion.text="Resuelto correctamente"
		else: retroalimentacion.text="No existe solucion"
	else: retroalimentacion.text="Configuracion Invalida"
