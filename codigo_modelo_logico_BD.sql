CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`cadena_restaurantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cadena_restaurantes` (
  `codigo` INT NOT NULL,
  `telefono` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`personas` (
  `DNI` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `codigo` INT NOT NULL,
  `numero_personas` INT NOT NULL,
  `personas_DNI` INT NOT NULL,
  PRIMARY KEY (`codigo`, `personas_DNI`),
  INDEX `fk_cliente_personas1_idx` (`personas_DNI` ASC),
  CONSTRAINT `fk_cliente_personas1`
    FOREIGN KEY (`personas_DNI`)
    REFERENCES `mydb`.`personas` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente_TO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente_TO` (
  `tarjeta_pago` INT NOT NULL,
  `tiempo_entrega` DATETIME NOT NULL,
  `cliente_codigo` INT NOT NULL,
  PRIMARY KEY (`cliente_codigo`),
  CONSTRAINT `fk_cliente_TO_cliente1`
    FOREIGN KEY (`cliente_codigo`)
    REFERENCES `mydb`.`cliente` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sucursales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sucursales` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `ruc` INT NOT NULL,
  `cadena_restaurantes_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`, `cadena_restaurantes_codigo`),
  INDEX `fk_sucursales_cadena_restaurantes_idx` (`cadena_restaurantes_codigo` ASC),
  CONSTRAINT `fk_sucursales_cadena_restaurantes`
    FOREIGN KEY (`cadena_restaurantes_codigo`)
    REFERENCES `mydb`.`cadena_restaurantes` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mesas` (
  `numero` INT NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`numero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reservaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reservaciones` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` INT NOT NULL,
  `sucursales_codigo` INT NOT NULL,
  `mesas_numero` INT NOT NULL,
  PRIMARY KEY (`codigo`, `sucursales_codigo`, `mesas_numero`),
  INDEX `fk_reservaciones_sucursales1_idx` (`sucursales_codigo` ASC),
  INDEX `fk_reservaciones_mesas1_idx` (`mesas_numero` ASC),
  CONSTRAINT `fk_reservaciones_sucursales1`
    FOREIGN KEY (`sucursales_codigo`)
    REFERENCES `mydb`.`sucursales` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservaciones_mesas1`
    FOREIGN KEY (`mesas_numero`)
    REFERENCES `mydb`.`mesas` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`proveedor` (
  `codigo` INT NOT NULL,
  `pago` INT NOT NULL,
  `telefono` INT NOT NULL,
  `personas_DNI` INT NOT NULL,
  PRIMARY KEY (`codigo`, `personas_DNI`),
  INDEX `fk_proveedor_personas1_idx` (`personas_DNI` ASC),
  CONSTRAINT `fk_proveedor_personas1`
    FOREIGN KEY (`personas_DNI`)
    REFERENCES `mydb`.`personas` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`p_carnes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`p_carnes` (
  `proveedor_codigo` INT NOT NULL,
  PRIMARY KEY (`proveedor_codigo`),
  CONSTRAINT `fk_p_carnes_proveedor1`
    FOREIGN KEY (`proveedor_codigo`)
    REFERENCES `mydb`.`proveedor` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`envios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`envios` (
  `codigo` INT NOT NULL,
  `horario` DATETIME NOT NULL,
  `sucursales_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`, `sucursales_codigo`),
  INDEX `fk_envios_sucursales1_idx` (`sucursales_codigo` ASC),
  CONSTRAINT `fk_envios_sucursales1`
    FOREIGN KEY (`sucursales_codigo`)
    REFERENCES `mydb`.`sucursales` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`personal` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `horario` DATETIME NOT NULL,
  `sueldo` INT NOT NULL,
  `personas_DNI` INT NOT NULL,
  `sucursales_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`, `personas_DNI`, `sucursales_codigo`),
  INDEX `fk_personal_personas1_idx` (`personas_DNI` ASC),
  INDEX `fk_personal_sucursales1_idx` (`sucursales_codigo` ASC),
  CONSTRAINT `fk_personal_personas1`
    FOREIGN KEY (`personas_DNI`)
    REFERENCES `mydb`.`personas` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_sucursales1`
    FOREIGN KEY (`sucursales_codigo`)
    REFERENCES `mydb`.`sucursales` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`repartidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`repartidor` (
  `codigo` INT NOT NULL,
  `tiempo_entrega` DATETIME NOT NULL,
  `envios_codigo` INT NOT NULL,
  `personal_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`, `envios_codigo`, `personal_codigo`),
  INDEX `fk_repartidor_envios1_idx` (`envios_codigo` ASC),
  INDEX `fk_repartidor_personal1_idx` (`personal_codigo` ASC),
  CONSTRAINT `fk_repartidor_envios1`
    FOREIGN KEY (`envios_codigo`)
    REFERENCES `mydb`.`envios` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_repartidor_personal1`
    FOREIGN KEY (`personal_codigo`)
    REFERENCES `mydb`.`personal` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`compra` (
  `codigo` INT NOT NULL,
  `precio` INT NOT NULL,
  `cliente_TO_cliente_codigo` INT NOT NULL,
  `envios_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`, `cliente_TO_cliente_codigo`, `envios_codigo`),
  INDEX `fk_compra_cliente_TO1_idx` (`cliente_TO_cliente_codigo` ASC),
  INDEX `fk_compra_envios1_idx` (`envios_codigo` ASC),
  CONSTRAINT `fk_compra_cliente_TO1`
    FOREIGN KEY (`cliente_TO_cliente_codigo`)
    REFERENCES `mydb`.`cliente_TO` (`cliente_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_envios1`
    FOREIGN KEY (`envios_codigo`)
    REFERENCES `mydb`.`envios` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vehiculo` (
  `placa_vehiculo` INT NOT NULL,
  `repartidor_codigo` INT NOT NULL,
  PRIMARY KEY (`placa_vehiculo`, `repartidor_codigo`),
  INDEX `fk_vehiculo_repartidor1_idx` (`repartidor_codigo` ASC),
  CONSTRAINT `fk_vehiculo_repartidor1`
    FOREIGN KEY (`repartidor_codigo`)
    REFERENCES `mydb`.`repartidor` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`gerente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`gerente` (
  `personal_codigo` INT NOT NULL,
  PRIMARY KEY (`personal_codigo`),
  CONSTRAINT `fk_gerente_personal1`
    FOREIGN KEY (`personal_codigo`)
    REFERENCES `mydb`.`personal` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`p_limpiaeza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`p_limpiaeza` (
  `personal_codigo` INT NOT NULL,
  PRIMARY KEY (`personal_codigo`),
  CONSTRAINT `fk_p_limpiaeza_personal1`
    FOREIGN KEY (`personal_codigo`)
    REFERENCES `mydb`.`personal` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`chef`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`chef` (
  `personal_codigo` INT NOT NULL,
  PRIMARY KEY (`personal_codigo`),
  CONSTRAINT `fk_chef_personal1`
    FOREIGN KEY (`personal_codigo`)
    REFERENCES `mydb`.`personal` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estacionamiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estacionamiento` (
  `codigo` INT NOT NULL,
  `pisos` INT NOT NULL,
  `sucursales_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`, `sucursales_codigo`),
  INDEX `fk_estacionamiento_sucursales1_idx` (`sucursales_codigo` ASC),
  CONSTRAINT `fk_estacionamiento_sucursales1`
    FOREIGN KEY (`sucursales_codigo`)
    REFERENCES `mydb`.`sucursales` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`realiza_reserv`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`realiza_reserv` (
  `reservaciones_codigo` INT NOT NULL,
  `cliente_codigo` INT NOT NULL,
  PRIMARY KEY (`reservaciones_codigo`, `cliente_codigo`),
  INDEX `fk_realiza_reserv_cliente1_idx` (`cliente_codigo` ASC),
  CONSTRAINT `fk_realiza_reserv_reservaciones1`
    FOREIGN KEY (`reservaciones_codigo`)
    REFERENCES `mydb`.`reservaciones` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_realiza_reserv_cliente1`
    FOREIGN KEY (`cliente_codigo`)
    REFERENCES `mydb`.`cliente` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comida` (
  `precio` INT NOT NULL,
  `codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bebida` (
  `codigo` INT NOT NULL,
  `precio` INT NOT NULL,
  `fech_venc` DATETIME NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`carta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carta` (
  `codigo` INT NOT NULL,
  `menus` VARCHAR(45) NOT NULL,
  `precio` INT NOT NULL,
  `sucursales_codigo` INT NOT NULL,
  `comida_codigo` INT NOT NULL,
  `bebida_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`, `sucursales_codigo`, `comida_codigo`, `bebida_codigo`),
  INDEX `fk_carta_sucursales1_idx` (`sucursales_codigo` ASC),
  INDEX `fk_carta_comida1_idx` (`comida_codigo` ASC),
  INDEX `fk_carta_bebida1_idx` (`bebida_codigo` ASC),
  CONSTRAINT `fk_carta_sucursales1`
    FOREIGN KEY (`sucursales_codigo`)
    REFERENCES `mydb`.`sucursales` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carta_comida1`
    FOREIGN KEY (`comida_codigo`)
    REFERENCES `mydb`.`comida` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carta_bebida1`
    FOREIGN KEY (`bebida_codigo`)
    REFERENCES `mydb`.`bebida` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`boleta_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`boleta_venta` (
  `codigo` INT NOT NULL,
  `cant_dinero` INT NOT NULL,
  `nomb_cliente` VARCHAR(45) NOT NULL,
  `sucursales_codigo` INT NOT NULL,
  `carta_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`, `sucursales_codigo`, `carta_codigo`),
  INDEX `fk_boleta_venta_sucursales1_idx` (`sucursales_codigo` ASC),
  INDEX `fk_boleta_venta_carta1_idx` (`carta_codigo` ASC),
  CONSTRAINT `fk_boleta_venta_sucursales1`
    FOREIGN KEY (`sucursales_codigo`)
    REFERENCES `mydb`.`sucursales` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_boleta_venta_carta1`
    FOREIGN KEY (`carta_codigo`)
    REFERENCES `mydb`.`carta` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`administrador` (
  `personal_codigo` INT NOT NULL,
  PRIMARY KEY (`personal_codigo`),
  CONSTRAINT `fk_administrador_personal1`
    FOREIGN KEY (`personal_codigo`)
    REFERENCES `mydb`.`personal` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mozo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mozo` (
  `personal_codigo` INT NOT NULL,
  PRIMARY KEY (`personal_codigo`),
  CONSTRAINT `fk_mozo_personal1`
    FOREIGN KEY (`personal_codigo`)
    REFERENCES `mydb`.`personal` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente_normal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente_normal` (
  `tipo_pago` INT NOT NULL,
  `numero_mesa` VARCHAR(45) NOT NULL,
  `cliente_codigo` INT NOT NULL,
  PRIMARY KEY (`cliente_codigo`),
  CONSTRAINT `fk_cliente_normal_cliente1`
    FOREIGN KEY (`cliente_codigo`)
    REFERENCES `mydb`.`cliente` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paga_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paga_cliente` (
  `cliente_normal_cliente_codigo` INT NOT NULL,
  `boleta_venta_codigo` INT NOT NULL,
  PRIMARY KEY (`cliente_normal_cliente_codigo`, `boleta_venta_codigo`),
  INDEX `fk_paga_cliente_boleta_venta1_idx` (`boleta_venta_codigo` ASC),
  CONSTRAINT `fk_paga_cliente_cliente_normal1`
    FOREIGN KEY (`cliente_normal_cliente_codigo`)
    REFERENCES `mydb`.`cliente_normal` (`cliente_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paga_cliente_boleta_venta1`
    FOREIGN KEY (`boleta_venta_codigo`)
    REFERENCES `mydb`.`boleta_venta` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`p_vigilancia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`p_vigilancia` (
  `personal_codigo` INT NOT NULL,
  PRIMARY KEY (`personal_codigo`),
  CONSTRAINT `fk_p_vigilancia_personal1`
    FOREIGN KEY (`personal_codigo`)
    REFERENCES `mydb`.`personal` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`espacio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`espacio` (
  `codigo` INT NOT NULL,
  `costo` INT NOT NULL,
  `piso` INT NOT NULL,
  `estacionamiento_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`, `estacionamiento_codigo`),
  INDEX `fk_espacio_estacionamiento1_idx` (`estacionamiento_codigo` ASC),
  CONSTRAINT `fk_espacio_estacionamiento1`
    FOREIGN KEY (`estacionamiento_codigo`)
    REFERENCES `mydb`.`estacionamiento` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`p_bebidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`p_bebidas` (
  `proveedor_codigo` INT NOT NULL,
  PRIMARY KEY (`proveedor_codigo`),
  CONSTRAINT `fk_p_bebidas_proveedor1`
    FOREIGN KEY (`proveedor_codigo`)
    REFERENCES `mydb`.`proveedor` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`utilizan_personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`utilizan_personas` (
  `espacio_codigo` INT NOT NULL,
  `personas_DNI` INT NOT NULL,
  PRIMARY KEY (`espacio_codigo`, `personas_DNI`),
  INDEX `fk_utilizan_personas_personas1_idx` (`personas_DNI` ASC),
  CONSTRAINT `fk_utilizan_personas_espacio1`
    FOREIGN KEY (`espacio_codigo`)
    REFERENCES `mydb`.`espacio` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_utilizan_personas_personas1`
    FOREIGN KEY (`personas_DNI`)
    REFERENCES `mydb`.`personas` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`p_vegetales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`p_vegetales` (
  `proveedor_codigo` INT NOT NULL,
  PRIMARY KEY (`proveedor_codigo`),
  CONSTRAINT `fk_p_vegetales_proveedor1`
    FOREIGN KEY (`proveedor_codigo`)
    REFERENCES `mydb`.`proveedor` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `codigo` INT NOT NULL,
  `precio` INT NOT NULL,
  `compra_codigo` INT NOT NULL,
  `sucursales_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`, `compra_codigo`, `sucursales_codigo`),
  INDEX `fk_pedido_compra1_idx` (`compra_codigo` ASC),
  INDEX `fk_pedido_sucursales1_idx` (`sucursales_codigo` ASC),
  CONSTRAINT `fk_pedido_compra1`
    FOREIGN KEY (`compra_codigo`)
    REFERENCES `mydb`.`compra` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_sucursales1`
    FOREIGN KEY (`sucursales_codigo`)
    REFERENCES `mydb`.`sucursales` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;