object biclope {

	const property maxstamina = 10
	const property precision = 2

}

object ciclope {

	const property maxstamina = 9999
	const property precision = 1

}

class Soldado {

	var property dano = 0

	method usarArma() {
		dano += 2
	}

	method cambiarRol() {
		dano = 0
	}

	method herramientas() {
	}

}

class Obrero {

	var property herramientas = []

	method usarArma() {
	}

}

object mucama {

	method usarArma() {
	}

	method herramientas() {
	}

}

class Empleado {

	var stamina
	const property raza
	var property rol

	method stamina(nuevaStamina) {
		nuevaStamina.max(raza.maxstamina())
	}

	method stamina() {
		return stamina.max(raza.maxstamina())
	}

	method herramientas() {
		return rol.herramientas()
	}

	method fuerza() {
		return (stamina / 2) + 2 + rol.dano() / raza.precision()
	}

	method hacerTarea(tarea) {
		tarea.realizarTarea()
	}

}

object arreglarMaquina {

	var property complejidad
	var property herramientasNecesarias = []

	method dificultad() = complejidad * 2

	method cumpleRequerimientos(empleado) {
		return empleado.stamina() >= complejidad && empleado.herramientas().contains(self.herramientasNecesarias())
	}

	method realizarTarea(empleado) {
		if (self.cumpleRequerimientos(empleado)) {
			empleado.stamina(empleado.stamina() - self.complejidad())
		} else {
			self.error("No puede realizar la tarea")
		}
	}

}

object defenderSector {

	var property amenaza

	method cumpleRequerimientos(empleado) {
		return empleado.rol() != mucama && empleado.fuerza() >= self.amenaza()
	}

	method dificultad(empleado) {
		if (empleado.raza() == biclope) {
			return self.amenaza()
		} else {
			return self.amenaza() * 2
		}
	}

	method realizarTarea(empleado) {
		if (self.cumpleRequerimientos(empleado) ) {
			empleado.stamina(empleado.stamina() / 2)
		}
	}

}

object limpiarSector {

	var property dificultad = 10
	var tamano

	method staminaRequerida() {
		if (tamano == "grande") {
			return 4
		} else return 1
	}

	method cumpleRequerimientos(empleado) {
		if (empleado.stamina() > self.staminaRequerida() || empleado.rol() == mucama) {
			return true
		} else {
			return false
		}
	}

}
