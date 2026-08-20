object casa {
    var cuenta = cuentaCorriente
    var totalGastadoEnElMes = 0
    method cuenta(_cuenta) {
        cuenta = _cuenta
    }
    method cuenta() = cuenta
    method totalGastadoEnElMes() = totalGastadoEnElMes
    method gastar(monto){
        cuenta.saldo(cuenta.saldo() - monto )
        totalGastadoEnElMes += monto
    }
    method cambiarMes() {
      totalGastadoEnElMes = 0
    }
}

object cuentaCorriente{
    var saldo = 10000

    method saldo(_saldo) {
        saldo = _saldo
    }

    method saldo() = saldo

    method depositar(monto) {
      saldo += monto
    }

    method extraer(monto) {
      saldo -= monto
    }
}

object cuentaConGastosDeMantenimiento {
    var saldo = 10000
    var costoPorOperacion = 20
    method saldo(_saldo) {
        saldo = _saldo
    }

    method saldo() = saldo

    method depositar(monto) {
        self.validarDeposito(monto)
      saldo += monto - costoPorOperacion
    }
    method validarDeposito(monto) {
      if (monto < costoPorOperacion){
        self.error("No se puede realizar el deposito, el monto que queire ingresar es menor al costo por la operacion")
      }
    }
    method extraer(monto) {
      saldo -= monto
    }

    method costoPorOperacion() = costoPorOperacion

    method costoPorOperacion(_costoPorOperacion) {
      costoPorOperacion = _costoPorOperacion
    } 
}