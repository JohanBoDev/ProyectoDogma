-- MySQL Script generated by MySQL Workbench
-- Mon Jul 29 11:40:32 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `Codigo` VARCHAR(50) NOT NULL COMMENT 'Código único del producto',
  `Lote` VARCHAR(50) NOT NULL COMMENT 'Número de lote del producto',
  `Fecha de vencimiento` DATE NULL COMMENT 'Fecha de vencimiento del producto',
  `Inventario` INT NULL COMMENT 'Cantidad de productos en inventario',
  `Embalaje` VARCHAR(50) NULL COMMENT 'Tipo de embalaje del producto',
  PRIMARY KEY (`Codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Viaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Viaje` (
  `IDConductor` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del conductor',
  `CodigoProducto` VARCHAR(45) NOT NULL COMMENT 'Código del producto transportado',
  `Placa` VARCHAR(45) NOT NULL COMMENT 'Placa del vehículo',
  `Hora` DATETIME NULL COMMENT 'Hora del viaje',
  `Precinto` VARCHAR(45) NULL COMMENT 'Precinto del viaje',
  PRIMARY KEY (`IDConductor`),
  INDEX `fk_Viaje_Producto_idx` (`CodigoProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Viaje_Producto`
    FOREIGN KEY (`CodigoProducto`)
    REFERENCES `mydb`.`Producto` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Colaborador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Colaborador` (
  `IDColaborador` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del colaborador',
  `Nombre` VARCHAR(100) NOT NULL COMMENT 'Nombre del colaborador',
  `Clave` VARCHAR(45) NOT NULL COMMENT 'Clave del colaborador\n',
  PRIMARY KEY (`IDColaborador`),
  CONSTRAINT ``
    FOREIGN KEY ()
    REFERENCES `mydb`.`Viaje` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supervisor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supervisor` (
  `IDSupervisor` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador unico del supervisor',
  `Permisos` VARCHAR(150) NOT NULL COMMENT 'Permisos del supervisor',
  `Nombre` VARCHAR(100) NOT NULL COMMENT 'Nombre del supervisor',
  `Clave` VARCHAR(45) NOT NULL COMMENT 'Clave del supervisor\n',
  PRIMARY KEY (`IDSupervisor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Lider` (
  `IDLider` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del líder',
  `Permisos` VARCHAR(150) NOT NULL COMMENT 'Permisos del lider',
  `Nombre` VARCHAR(100) NOT NULL COMMENT 'Nombre del lider',
  `Clave` VARCHAR(45) NOT NULL COMMENT 'Clave del lider',
  PRIMARY KEY (`IDLider`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ConsolidadoSeparacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ConsolidadoSeparacion` (
  `IDConductor` INT NOT NULL COMMENT 'Identificador del conductor',
  `IDColaborador` INT NOT NULL COMMENT 'Identificador del colaborador',
  `ProductoDespachar` VARCHAR(45) NOT NULL COMMENT 'Producto a despachar',
  `ProductoDiscrepancia` VARCHAR(45) NULL COMMENT ' Producto con Discrepancia',
  `UbicacionProducto` VARCHAR(100) NOT NULL COMMENT 'Ubicacion del Producto',
  INDEX `fk_Consolidado_Separacion_Conductor_idx` (`IDConductor` ASC) VISIBLE,
  INDEX `fk_Consolidado_Separacion_Colaborador_idx` (`IDColaborador` ASC) VISIBLE,
  CONSTRAINT `fk_Consolidado_Separacion_Conductor`
    FOREIGN KEY (`IDConductor`)
    REFERENCES `mydb`.`Viaje` (`IDConductor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consolidado_Separacion_Colaborador`
    FOREIGN KEY (`IDColaborador`)
    REFERENCES `mydb`.`Colaborador` (`IDColaborador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ConsolidadoZona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ConsolidadoZona` (
  `IDConductor` INT NOT NULL COMMENT 'Identificador del conductor\n',
  `ProductoDespachado` VARCHAR(45) NOT NULL COMMENT 'Producto Despachado',
  `PlacaTransporte` VARCHAR(45) NOT NULL COMMENT 'Placa del transporte',
  `ProductoDiscrepancia` VARCHAR(45) NULL COMMENT 'Producto con Discrepancia',
  INDEX `fk_consolidado_zona_conductor_idx` (`IDConductor` ASC) VISIBLE,
  CONSTRAINT `fk_consolidado_zona_conductor`
    FOREIGN KEY (`IDConductor`)
    REFERENCES `mydb`.`Viaje` (`IDConductor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CerrarTransporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CerrarTransporte` (
  `IDConductor` INT NOT NULL COMMENT 'Identificador del conductor',
  `PlacaTransporte` VARCHAR(45) NOT NULL COMMENT 'Placa del Transporte',
  `ConsolidadoZona` VARCHAR(45) NOT NULL COMMENT 'Consolidado de Zona',
  INDEX `fk_cerrar_transporte_conductor_idx` (`IDConductor` ASC) VISIBLE,
  CONSTRAINT `fk_cerrar_transporte_conductor`
    FOREIGN KEY (`IDConductor`)
    REFERENCES `mydb`.`Viaje` (`IDConductor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProductoRetorno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductoRetorno` (
  `IDConductor` INT NOT NULL COMMENT 'Identificador del conductor\n',
  `ProductoRetornado` VARCHAR(45) NOT NULL COMMENT 'Producto Retornado',
  `LineaSeparacion` VARCHAR(45) NOT NULL COMMENT 'Linea de Separacion',
  INDEX `fk_producto_retorno_conductor_idx` (`IDConductor` ASC) VISIBLE,
  CONSTRAINT `fk_producto_retorno_conductor`
    FOREIGN KEY (`IDConductor`)
    REFERENCES `mydb`.`Viaje` (`IDConductor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProductoNoConforme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductoNoConforme` (
  `Codigo` INT NOT NULL AUTO_INCREMENT COMMENT 'Código del producto no conforme',
  `Operacion` VARCHAR(100) NOT NULL COMMENT 'Operación de donde proviene el producto no conforme\n',
  PRIMARY KEY (`Codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`InventarioTotalProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`InventarioTotalProducto` (
  `Producto` VARCHAR(50) NOT NULL COMMENT 'Producto total en inventario',
  `Codigo` VARCHAR(45) NOT NULL COMMENT 'Codigo del producto',
  `Lote` VARCHAR(45) NOT NULL COMMENT 'Lote del producto',
  `FechaDeVencimiento` DATE NULL COMMENT 'Fecha de vencimiento del producto',
  INDEX `fk_inventario_total_producto_codigoProducto_idx` (`Producto` ASC) VISIBLE,
  CONSTRAINT `fk_inventario_total_producto_codigoProducto`
    FOREIGN KEY (`Producto`)
    REFERENCES `mydb`.`Producto` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ConteoFisico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ConteoFisico` (
  `Producto` VARCHAR(50) NOT NULL COMMENT 'Código del producto',
  `Ubicacion` VARCHAR(100) NOT NULL COMMENT 'Ubicación del producto',
  `Cantidad` INT NOT NULL COMMENT 'Cantidad del producto',
  `Conteo1` INT NULL COMMENT 'Primer conteo',
  `Conteo2` INT NULL COMMENT 'Segundo conteo',
  INDEX `fk_conte_fisico_producto_idx` (`Producto` ASC) VISIBLE,
  CONSTRAINT `fk_conte_fisico_producto`
    FOREIGN KEY (`Producto`)
    REFERENCES `mydb`.`Producto` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
