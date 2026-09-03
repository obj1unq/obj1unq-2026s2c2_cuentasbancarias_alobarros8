object casa {
    var viveres = 0
    var cuenta = cuentaCorriente
    var totalGastadoEnElMes = 0
    var reparaciones = 0
    var estrategiaDeMantenimiento = minimoIndispensable
   
    method estrategiaDeMantenimiento(_estrategiaDeMantenimiento) {
      estrategiaDeMantenimiento = _estrategiaDeMantenimiento
    }
    method verificarSiSePuedeReparar() {
      if(self.reparaciones() > cuenta.saldo()){
        self.error("No se puede reparar no hay plata")
      }
    }
    method reparar() {
      
      self.gastar(reparaciones)
      self.reparaciones(0)
    }

    method romperAlgoDeValor_(monto) {
      reparaciones += monto
    }

    method comprarViveres_DeCalidad_(_viveres , calidad) {
      self.validarCompraDeViveres(_viveres )
      viveres = viveres + _viveres 
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
      estrategiaDeMantenimiento.ejecutarTareas(self)
    }
}

object minimoIndispensable {
  var calidadViveres = 1
  method calidadViveres(_caldiadViveres) {
    calidadViveres = _caldiadViveres
  }
  method calidadViveres() = calidadViveres
  method ejecutarTareas(_casa) {
    if( not _casa.hayViveresSuficientes()){
        _casa.comprarViveres_DeCalidad_(40 -_casa.viveres(), self.calidadViveres())
    }
  }
}

object full {
  const calidadViveres = 5

  method calidadViveres() = calidadViveres
  method ejecutarTareas(_casa) {
    if(_casa.estaEnOrden()){
      _casa.comprarViveres_DeCalidad_(100 - calidadViveres, self.calidadViveres())
    }else{
      self.comprarSiHayMenosDe40DeViveres(_casa)
      self.repararSiLoRequiere(_casa)
    }


    }
  method comprarSiHayMenosDe40DeViveres(_casa) {
    if (_casa.viveres() < 40){
      _casa.comprarViveres_DeCalidad_(40 -_casa.viveres(), self.calidadViveres())
    }
  }
  method repararSiLoRequiere(_casa) {
    if (_casa.hayQueHacerReparaciones() and _casa.verificarSiSePuedeReparar()){
      _casa.reparar()

    }
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