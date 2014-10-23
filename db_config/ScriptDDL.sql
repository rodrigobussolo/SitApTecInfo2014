-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sitap
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sitap
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sitap` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `sitap` ;

-- -----------------------------------------------------
-- Table `sitap`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitap`.`Usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(70) NOT NULL,
  `senha` INT NOT NULL,
  `dtNascimento` DATE NOT NULL,
  `foto` VARCHAR(45) NULL,
  `telefone` INT NULL,
  `cep` INT NULL,
  `endereco` VARCHAR(100) NULL,
  `dtCadastro` DATETIME NOT NULL DEFAULT Now(),
  `dtAtualizacao` DATETIME NULL DEFAULT Now(),
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitap`.`Noticia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitap`.`Noticia` (
  `idnoticia` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `texto` MEDIUMTEXT NOT NULL,
  `dtCriacao` DATETIME NULL DEFAULT Now(),
  `dtAtualizacao` DATETIME NULL DEFAULT Now(),
  `idusuario` INT NOT NULL,
  `positivo` INT NULL,
  `negativo` INT NULL,
  PRIMARY KEY (`idnoticia`),
  INDEX `fk_Noticia_Usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_Noticia_Usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `sitap`.`Usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitap`.`Comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitap`.`Comentario` (
  `idcomentario` INT NOT NULL AUTO_INCREMENT,
  `comentario` TEXT NULL,
  `dtCriacao` DATETIME NULL,
  `dtAtualizacao` DATETIME NULL,
  `idusuario` INT NOT NULL,
  `idnoticia` INT NOT NULL,
  `positivo` INT NULL,
  `negativo` INT NULL,
  PRIMARY KEY (`idcomentario`),
  INDEX `fk_Comentario_Usuario1_idx` (`idusuario` ASC),
  INDEX `fk_Comentario_Noticia1_idx` (`idnoticia` ASC),
  CONSTRAINT `fk_Comentario_Usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `sitap`.`Usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentario_Noticia1`
    FOREIGN KEY (`idnoticia`)
    REFERENCES `sitap`.`Noticia` (`idnoticia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitap`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitap`.`Categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitap`.`Foto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitap`.`Foto` (
  `idfoto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `url` VARCHAR(45) NULL,
  `idnoticia` INT NOT NULL,
  PRIMARY KEY (`idfoto`),
  INDEX `fk_Foto_Noticia1_idx` (`idnoticia` ASC),
  CONSTRAINT `fk_Foto_Noticia1`
    FOREIGN KEY (`idnoticia`)
    REFERENCES `sitap`.`Noticia` (`idnoticia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitap`.`categoria_tem_noticia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitap`.`categoria_tem_noticia` (
  `idcategoria` INT NOT NULL,
  `idnoticia` INT NOT NULL,
  PRIMARY KEY (`idcategoria`, `idnoticia`),
  INDEX `fk_Noticia_has_Categoria_Categoria1_idx` (`idcategoria` ASC),
  INDEX `fk_Noticia_has_Categoria_Noticia1_idx` (`idnoticia` ASC),
  CONSTRAINT `fk_Noticia_has_Categoria_Noticia1`
    FOREIGN KEY (`idnoticia`)
    REFERENCES `sitap`.`Noticia` (`idnoticia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Noticia_has_Categoria_Categoria1`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `sitap`.`Categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
