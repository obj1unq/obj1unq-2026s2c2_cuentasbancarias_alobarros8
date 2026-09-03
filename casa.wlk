object casa {
    var viveres = 0
    var cuenta = cuentaCorriente
    var totalGastadoEnElMes = 0
    var reparaciones = 0

    method reparar() {
      self.gastar(reparaciones)
      self.reparaciones(0)
    }

    method romperAlgoDeValor_(monto) {
      reparaciones += monto
    }

    method comprarViveres_DeCalidad_(_viveres , calidad) {
      self.validarCompraDeViveres(_viveres )
      viveres += _viveres 
      self.gastar(_viveres * calidad)
    }

    method validarCompraDeViveres(monto) {
      if(monto + self.viveres() > 100){
        self.error("La compra de los viveres supera la capacidad maxima")
      }
    }
    method hayViveresSuficientes() {
     return self.viveres() > 40
    }
    method hayQueHacerReparaciones() {
      return self.reparaciones() > 0
    } 
    method estaEnOrden() {
     return not self.hayQueHacerReparaciones() and self.hayViveresSuficientes() 
    }

    method reparaciones() = reparaciones
    method reparaciones(_reparaciones) {
      reparaciones = _reparaciones
    }
    method viveres() = viveres
    method viveres(_viveres) { //uso para el test unicamente 
      viveres = _viveres   
       }

    method cuenta(_cuenta) {
        cuenta = _cuenta
    }
    method cuenta() = cuenta
    method totalGastadoEnElMes() = totalGastadoEnElMes
    method gastar(monto){
        cuenta.extraer(monto)
        totalGastadoEnElMes += monto
    }
    method cambiarMes() {
      totalGastadoEnElMes = 0
    }
}

object cuentaCombinada {
  
  var cuentaPrimaria = cuentaCorriente
  var cuentaSecundaria = cuentaConGastosDeMantenimiento

  method cuentaPrimaria(_cuentaPrimaria) {
    cuentaPrimaria = _cuentaPrimaria
  }

  method cuentaSecundaria(_cuentaSecundaria) {
    cuentaSecundaria = _cuentaSecundaria
  }
  method saldo() {
   return 0.max(cuentaPrimaria.saldo()) + 0.max(cuentaSecundaria.saldo())
  }

  method depositar(monto) {
    cuentaPrimaria.depositar(monto)
  }

  method validarExtraer(monto) {
    if (monto > self.saldo()){
        self.error("No es posible extraer el dinero")
    }
  }  
  method extraer(monto) {
    self.validarExtraer(monto)
    if(monto < cuentaPrimaria.saldo() ){
        cuentaPrimaria.extraer(monto)

    } else {
        cuentaSecundaria.extraer(monto - cuentaPrimaria.saldo())
        cuentaPrimaria.extraer(cuentaPrimaria.saldo())
        
    }
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