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

select*from `mydb`.`sucursales`;
INSERT INTO `mydb`.`sucursales` (`codigo`, `nombre`, `ruc`, `cadena_restaurantes_codigo`) VALUES ('111', 'RP1', '2333224', '001');
INSERT INTO `mydb`.`sucursales` (`codigo`, `nombre`, `ruc`, `cadena_restaurantes_codigo`) VALUES ('222', 'RP2', '1224442', '001');
INSERT INTO `mydb`.`sucursales` (`codigo`, `nombre`, `ruc`, `cadena_restaurantes_codigo`) VALUES ('333', 'RP3', '3626712', '002');
INSERT INTO `mydb`.`sucursales` (`codigo`, `nombre`, `ruc`, `cadena_restaurantes_codigo`) VALUES ('444', 'RP4', '1839382', '002');
INSERT INTO `mydb`.`sucursales` (`codigo`, `nombre`, `ruc`, `cadena_restaurantes_codigo`) VALUES ('555', 'RP5', '1247362', '002');


select*from `mydb`.`cadena_restaurantes`;
INSERT INTO `mydb`.`cadena_restaurantes` (`codigo`, `telefono`, `direccion`, `nombre`) VALUES ('001', '923321', '3 de octubre', 'RicoPollorestaurante');
INSERT INTO `mydb`.`cadena_restaurantes` (`codigo`, `telefono`, `direccion`, `nombre`) VALUES ('002', '232221', 'Av.los rosales', 'RicoPollo_Polleria');

select*from `mydb`.`personas`;
INSERT INTO `mydb`.`personas` (`DNI`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES ('73041777', 'edgar', 'camino', '922331233', '3 de octubre');
INSERT INTO `mydb`.`personas` (`DNI`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES ('72051334', 'cesar', 'cari', '923332421', 'Av_independencia');
INSERT INTO `mydb`.`personas` (`DNI`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES ('73422546', 'maria', 'apaza', '923341412', 'av_paucarpata');
INSERT INTO `mydb`.`personas` (`DNI`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES ('92334817', 'carlos', 'quispe', '939272713', 'av_carmona');
INSERT INTO `mydb`.`personas` (`DNI`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES ('27164625', 'victor', 'mamani', '909002322', 'Av_paucarpata');
INSERT INTO `mydb`.`personas` (`DNI`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES ('73564611', 'raul', 'bellido', '902333213', 'Av_independencia');
INSERT INTO `mydb`.`personas` (`DNI`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES ('22381714', 'juan', 'gonzales', '993321232', 'Av_atahualpa');
INSERT INTO `mydb`.`personas` (`DNI`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES ('23314151', 'pedro', 'mendoza', '999000372', 'av_carmona');
INSERT INTO `mydb`.`personas` (`DNI`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES ('73352412', 'camila', 'apaza', '891273612', 'Av_rosales');

select*from `mydb`.`cliente`;
INSERT INTO `mydb`.`cliente` (`codigo`, `numero_personas`, `personas_DNI`) VALUES ('988', '1', '73041777');
INSERT INTO `mydb`.`cliente` (`codigo`, `numero_personas`, `personas_DNI`) VALUES ('928', '1', '72051334');
INSERT INTO `mydb`.`cliente` (`codigo`, `numero_personas`, `personas_DNI`) VALUES ('233', '1', '73422546');
INSERT INTO `mydb`.`cliente` (`codigo`, `numero_personas`, `personas_DNI`) VALUES ('256', '4', '92334817');
INSERT INTO `mydb`.`cliente` (`codigo`, `numero_personas`, `personas_DNI`) VALUES ('709', '1', '27164625');
INSERT INTO `mydb`.`cliente` (`codigo`, `numero_personas`, `personas_DNI`) VALUES ('356', '2', '73564611');
INSERT INTO `mydb`.`cliente` (`codigo`, `numero_personas`, `personas_DNI`) VALUES ('809', '2', '22381714');
INSERT INTO `mydb`.`cliente` (`codigo`, `numero_personas`, `personas_DNI`) VALUES ('187', '2', '23314151');
INSERT INTO `mydb`.`cliente` (`codigo`, `numero_personas`, `personas_DNI`) VALUES ('158', '3', '73352412');

select*from`mydb`.`cliente_TO`;
INSERT INTO `mydb`.`cliente_TO` (`tarjeta_pago`, `tiempo_entrega`, `cliente_codigo`) VALUES ('323233223', '00:30', '988');
INSERT INTO `mydb`.`cliente_TO` (`tarjeta_pago`, `tiempo_entrega`, `cliente_codigo`) VALUES ('212323321', '00:25', '928');
INSERT INTO `mydb`.`cliente_TO` (`tarjeta_pago`, `tiempo_entrega`, `cliente_codigo`) VALUES ('123122312', '00:23', '233');
INSERT INTO `mydb`.`cliente_TO` (`tarjeta_pago`, `tiempo_entrega`, `cliente_codigo`) VALUES ('123412343', '00:24', '256');
INSERT INTO `mydb`.`cliente_TO` (`tarjeta_pago`, `tiempo_entrega`, `cliente_codigo`) VALUES ('453512111', '00:34', '709');
INSERT INTO `mydb`.`cliente_TO` (`tarjeta_pago`, `tiempo_entrega`, `cliente_codigo`) VALUES ('231231212', '00:45', '356');
INSERT INTO `mydb`.`cliente_TO` (`tarjeta_pago`, `tiempo_entrega`, `cliente_codigo`) VALUES ('123121232', '00:13', '809');

select*from`mydb`.`mesas`;
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('1', 'ocupado');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('2', 'libre');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('3', 'libre');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('4', 'libre');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('5', 'libre');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('6', 'ocupado');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('7', 'ocupado');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('8', 'libre');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('9', 'libre');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('10', 'ocupado');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('11', 'ocupado');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('12', 'ocupado');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('13', 'libre');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('14', 'ocupado');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('15', 'ocupado');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('16', 'libre');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('17', 'ocupado');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('18', 'ocupado');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('19', 'libre');
INSERT INTO `mydb`.`mesas` (`numero`, `estado`) VALUES ('20', 'libre');

select*from `mydb`.`reservaciones`;
INSERT INTO `mydb`.`reservaciones` (`codigo`, `nombre`, `precio`, `sucursales_codigo`, `mesas_numero`) VALUES ('1233', 'cesar', '45', '111', '1');
INSERT INTO `mydb`.`reservaciones` (`codigo`, `nombre`, `precio`, `sucursales_codigo`, `mesas_numero`) VALUES ('1412', 'juan', '65', '111', '6');
INSERT INTO `mydb`.`reservaciones` (`codigo`, `nombre`, `precio`, `sucursales_codigo`, `mesas_numero`) VALUES ('1320', 'gonzalo', '45', '222', '7');
INSERT INTO `mydb`.`reservaciones` (`codigo`, `nombre`, `precio`, `sucursales_codigo`, `mesas_numero`) VALUES ('2819', 'juan', '45', '222', '11');
INSERT INTO `mydb`.`reservaciones` (`codigo`, `nombre`, `precio`, `sucursales_codigo`, `mesas_numero`) VALUES ('4390', 'sebastian', '65', '333', '12');
INSERT INTO `mydb`.`reservaciones` (`codigo`, `nombre`, `precio`, `sucursales_codigo`, `mesas_numero`) VALUES ('8712', 'lucas', '56', '222', '10');
INSERT INTO `mydb`.`reservaciones` (`codigo`, `nombre`, `precio`, `sucursales_codigo`, `mesas_numero`) VALUES ('6271', 'victor', '56', '111', '17');
INSERT INTO `mydb`.`reservaciones` (`codigo`, `nombre`, `precio`, `sucursales_codigo`, `mesas_numero`) VALUES ('7812', 'pedro', '45', '333', '18');
INSERT INTO `mydb`.`reservaciones` (`codigo`, `nombre`, `precio`, `sucursales_codigo`, `mesas_numero`) VALUES ('1289', 'sonia', '45', '333', '20');

 select*from`mydb`.`proveedor`;
 INSERT INTO `mydb`.`proveedor` (`codigo`, `pago`, `telefono`, `personas_DNI`) VALUES ('21', '150', '877766', '74484732');
INSERT INTO `mydb`.`proveedor` (`codigo`, `pago`, `telefono`, `personas_DNI`) VALUES ('31', '200', '433322', '82836563');
INSERT INTO `mydb`.`proveedor` (`codigo`, `pago`, `telefono`, `personas_DNI`) VALUES ('41', '320', '443221', '29283736');
INSERT INTO `mydb`.`proveedor` (`codigo`, `pago`, `telefono`, `personas_DNI`) VALUES ('51', '240', '522211', '23213212');
INSERT INTO `mydb`.`proveedor` (`codigo`, `pago`, `telefono`, `personas_DNI`) VALUES ('61', '360', '233141', '43534535');
INSERT INTO `mydb`.`proveedor` (`codigo`, `pago`, `telefono`, `personas_DNI`) VALUES ('71', '250', '153411', '12312123');


