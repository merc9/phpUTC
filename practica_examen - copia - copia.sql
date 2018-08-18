CREATE DATABASE PracticaExamen
GO

USE PracticaExamen
GO

CREATE TABLE Estudiante (
Carnet INT NOT NULL PRIMARY KEY,
Nombre VARCHAR(50),
Carrera VARCHAR(15)
)

CREATE TABLE Materia (
CodMateria CHAR(3) NOT NULL PRIMARY KEY,
Nombre VARCHAR(15),
Creditos INT
)

CREATE TABLE Profesor (
Cedula INT NOT NULL PRIMARY KEY,
Nombre VARCHAR(50),
Telefono VARCHAR(20)
)

CREATE TABLE Grupo (
CodMateria CHAR(3) NOT NULL,
grupo INT NOT NULL,
prof INT NOT NULL,
PRIMARY KEY(CodMateria,grupo)
)

CREATE TABLE Matricula (
Carnet INT NOT NULL,
CodMateria CHAR(3) NOT NULL,
grupo INT NOT NULL,
Nota INT
PRIMARY KEY(Carnet, CodMateria, grupo)
)


ALTER TABLE Grupo
ADD CONSTRAINT fk_Grupo_Materia FOREIGN KEY(CodMateria) REFERENCES Materia(CodMateria)

ALTER TABLE Matricula
ADD CONSTRAINT fk_Matricula_Carnet FOREIGN KEY(Carnet) REFERENCES Estudiante(Carnet),
CONSTRAINT fk_Matricula_Grupo FOREIGN KEY(CodMateria, grupo) REFERENCES Grupo(CodMateria,grupo)

ALTER TABLE Grupo
ADD CONSTRAINT fk_Grupo_prof FOREIGN KEY(prof) REFERENCES Profesor(Cedula)


INSERT INTO Estudiante(Carnet, Nombre, Carrera)
VALUES ( 600000, 'Rojas', 'Quimica' ),
( 700000, 'Mendez', 'Historia' ),
( 800000, 'Castro', 'Matematica' ),
( 900000, 'Murillo', 'Quimica' )


INSERT INTO Profesor(Cedula, Nombre, Telefono)
VALUES ( 1111, 'Perez', '4410926' ),
( 2222, 'Arce', '4426578' ),
( 3333, 'Alvarez', '2467865' )


INSERT INTO Materia(CodMateria, Nombre, Creditos)
VALUES ( 'A20', 'Ciencias', 4 ),
( 'A21', 'Biologia',3 ),
( 'B20', 'Matematica', 5),
( 'C20', 'Espanol', 4),
( 'D20', 'Ingles', 2)

INSERT INTO Grupo(CodMateria, grupo, prof)
VALUES
( 'A20', 1,2222),
( 'A20', 2,1111),
( 'A21', 1,3333),
( 'B20', 1,1111),
( 'C20', 1,2222),
( 'C20', 2,2222),
( 'D20', 2,3333)

INSERT INTO Matricula (Carnet,CodMateria,grupo, Nota)
VALUES
(600000,'A20',1,100),
(600000,'A21',1,95),
(700000,'B20',1,80),
(800000,'B20',1,70),
(800000,'D20',2,50)




--QUERIES
SELECT * FROM Profesor WHERE Cedula = 3333

SELECT Carnet FROM Matricula ORDER BY Carnet, CodMateria

SELECT CodMateria, Nombre FROM Materia WHERE Creditos IN (2,4)

SELECT Cedula, Nombre FROM Profesor WHERE Nombre LIKE 'A%'

SELECT Cedula, Nombre, Telefono FROM Profesor WHERE Nombre LIKE 'Rojas'  --No hay profesores con ese apellido

SELECT COUNT(Carnet) FROM Estudiante WHERE Carnet IN (SELECT Carnet FROM Matricula)

SELECT SUM(Nota) FROM Matricula WHERE CodMateria = (SELECT CodMateria FROM Materia WHERE Nombre = 'Ciencias')

SELECT COUNT(CodMateria) FROM Materia WHERE Creditos > 3




--JOINS

--1
SELECT Profesor.Nombre, Materia.Nombre,  Grupo.grupo AS 'Grupo', Materia.Creditos FROM ((Grupo INNER JOIN Profesor ON Profesor.Cedula = Grupo.prof) INNER JOIN Materia ON Materia.CodMateria = Grupo.CodMateria)
GO
--2
SELECT Materia.Nombre, Matricula.grupo AS 'Grupo', Estudiante.Nombre, Matricula.Nota FROM Matricula 
INNER JOIN Materia ON Materia.CodMateria = Matricula.CodMateria
INNER JOIN Estudiante ON Estudiante.Carnet = Matricula.Carnet
WHERE Matricula.Nota > 90
GO
--3
SELECT Estudiante.Nombre FROM Matricula INNER JOIN Estudiante ON Estudiante.Carnet = Matricula.Carnet WHERE Matricula.CodMateria
IN(
SELECT Grupo.CodMateria FROM Grupo INNER JOIN Profesor ON Profesor.Cedula = Grupo.prof WHERE Profesor.Nombre LIKE 'Alvarez'
)
AND Matricula.Nota < 70
GO
--4
SELECT Materia.CodMateria, Materia.Nombre, COUNT(Matricula.Carnet) AS 'Alumnos Matriculados'  FROM Matricula INNER JOIN Materia ON Materia.CodMateria = Matricula.CodMateria
GROUP BY Materia.CodMateria, Materia.Nombre
GO
--5
SELECT Materia.Nombre, COUNT(Matricula.Carnet) FROM Matricula INNER JOIN Materia ON Materia.CodMateria = Matricula.CodMateria WHERE Matricula.CodMateria
IN(
SELECT Grupo.CodMateria FROM Grupo INNER JOIN Profesor ON Profesor.Cedula = Grupo.prof WHERE Profesor.Nombre LIKE 'Alvarez' AND Grupo.CodMateria LIKE 'A%'
)
GROUP BY Materia.Nombre
GO
--6
SELECT Estudiante.Nombre, Estudiante.Carrera FROM Matricula
INNER JOIN Estudiante ON Estudiante.Carnet = Matricula.Carnet 
WHERE Matricula.CodMateria =
(
SELECT Materia.CodMateria FROM Matricula INNER JOIN Materia ON Materia.CodMateria = Matricula.CodMateria WHERE Materia.Nombre LIKE 'Ingles'
)
GO



--SUB-QUERY

--1
SELECT Materia.Nombre, Materia.Creditos FROM Materia WHERE Materia.CodMateria IN
(
SELECT Grupo.CodMateria FROM Grupo WHERE Grupo.prof = 1111
)
GO
--2
SELECT Matricula.Carnet FROM Matricula WHERE Matricula.CodMateria IN
(
SELECT Materia.CodMateria FROM Materia WHERE Materia.CodMateria IN (
SELECT Grupo.CodMateria FROM Grupo WHERE Grupo.prof LIKE (SELECT Profesor.Cedula FROM Profesor WHERE Profesor.Nombre LIKE 'Perez')
)
AND Materia.Creditos > 3
)
GO
--3
SELECT Matricula.Carnet FROM Matricula WHERE Matricula.Nota > (SELECT AVG(Matricula.Nota) FROM Matricula) GROUP BY Matricula.Carnet
GO
--4
SELECT Estudiante.Carnet, Estudiante.Nombre FROM Estudiante WHERE Estudiante.Carnet IN 
(
 SELECT Matricula.Carnet FROM Matricula WHERE Matricula.Nota = 
 (SELECT MIN(Matricula.Nota) FROM Matricula) 
)
GROUP BY Estudiante.Carnet, Estudiante.Nombre
GO
--5
SELECT Estudiante.Carnet, Estudiante.Nombre FROM Estudiante WHERE Estudiante.Carnet IN (
	SELECT Matricula.Carnet FROM Matricula WHERE Matricula.CodMateria IN('A20','A21')
)
GO
--6
SELECT Estudiante.Nombre FROM Estudiante WHERE Estudiante.Carrera = 'Matematica' AND Estudiante.Carnet IN 
(
	SELECT Matricula.Carnet FROM Matricula WHERE Matricula.CodMateria = 
	
	(SELECT Materia.CodMateria FROM Materia WHERE Materia.Nombre = 'Ingles')
)
GO




--FUNCTIONS

--1
CREATE FUNCTION fn_NotaPromedio
(
	@CodMateria CHAR(3)
)
RETURNS FLOAT
AS
BEGIN
	RETURN (SELECT AVG(Matricula.Nota) FROM Matricula WHERE Matricula.CodMateria = @CodMateria)
END

GO

--2
CREATE FUNCTION fn_Matriculados
(
	@CodMateria CHAR(3)
)
RETURNS INT
AS
BEGIN

	RETURN (SELECT COUNT(Matricula.Carnet) FROM Matricula WHERE Matricula.CodMateria = @CodMateria)

END
GO

--3
CREATE FUNCTION fn_NotaMinima
()
RETURNS @table TABLE
(
Carnet INT PRIMARY KEY NOT NULL,
Nota INT
)
AS
BEGIN 
	INSERT INTO @table SELECT Matricula.Carnet, MIN(Matricula.Nota) AS 'Nota Minima' 
	FROM Matricula WHERE Matricula.Carnet IN 
	(SELECT Matricula.Carnet FROM Matricula) GROUP BY Matricula.Carnet 
	RETURN
END
GO

--4
CREATE FUNCTION fn_CreditosPorProfesor()
RETURNS @table TABLE
(
	Cedula INT NOT NULL,
	CodMateria CHAR(3) NOT NULL,
	Creditos INT,
	PRIMARY KEY(Cedula, CodMateria)
)
AS
BEGIN

INSERT INTO @table SELECT Profesor.Cedula, Materia.CodMateria, Materia.Creditos FROM Grupo 
INNER JOIN Materia ON Materia.CodMateria = Grupo.CodMateria
INNER JOIN Profesor ON Profesor.Cedula = Grupo.prof
GROUP BY Profesor.Cedula, Materia.CodMateria, Materia.Creditos


RETURN
END
GO

--5
CREATE FUNCTION fn_NotaPromedioCursoMayor10Matriculados
(
	@CodMateria CHAR(3)
)
RETURNS FLOAT
AS
BEGIN
	DECLARE @promedio FLOAT = 0
	DECLARE @matriculados INT = (SELECT dbo.fn_Matriculados(@CodMateria))
	IF @matriculados < 10
	BEGIN
		SET @promedio = NULL
	END
	ELSE
	BEGIN
		SET @promedio = (SELECT dbo.fn_NotaPromedio(@CodMateria))
	END 
	RETURN @promedio
END
GO

--6
CREATE FUNCTION fn_CantidadCursosPorCarnet()
RETURNS @table TABLE
(
	Carnet INT NOT NULL PRIMARY KEY,
	CantidadCursos INT
)
AS
BEGIN

INSERT INTO @table SELECT Matricula.Carnet, COUNT(Matricula.CodMateria) FROM Matricula WHERE Matricula.Carnet IN (SELECT Matricula.Carnet FROM Matricula) GROUP BY Matricula.Carnet

RETURN
END
GO

--7   Este enunciado estaba dificil de entender
CREATE FUNCTION fn_PromedioMenor70()
RETURNS @table TABLE
(
Carnet INT NOT NULL PRIMARY KEY,
Promedio FLOAT
)
AS
BEGIN

INSERT INTO @table SELECT Matricula.Carnet, AVG(Matricula.Nota) FROM Matricula WHERE Matricula.Nota < 70
AND Matricula.Carnet IN (SELECT Matricula.Carnet FROM Matricula)
GROUP BY Matricula.Carnet

RETURN
END
GO


--ACTIONS ON DB 
--1		
UPDATE Matricula SET CodMateria = 'C20', grupo = 2 WHERE Carnet = 600000 AND CodMateria = 'A20' AND grupo = 1
DELETE FROM Grupo WHERE CodMateria = 'A20' AND grupo = 1
GO

--2
UPDATE Matricula SET Nota = Nota + 10 WHERE Nota = 70 AND CodMateria = (SELECT Materia.CodMateria FROM Materia WHERE Materia.Nombre = 'Biologia')
GO

--3
INSERT INTO Profesor(Nombre,Cedula, Telefono)VALUES('Jiménez',4444,'4435478') 
GO

--4
UPDATE Profesor SET Telefono = '2356255' WHERE Nombre = 'Perez'
GO

--5
ALTER TABLE Estudiante
ADD Telefono INT
GO

--6
UPDATE Estudiante SET Carrera = 'Biologia' WHERE Nombre LIKE '%s'
GO

--7
SELECT Matricula.CodMateria, Matricula.grupo, AVG(Matricula.Nota) AS 'Promedio'
FROM Matricula WHERE Matricula.Nota < 70
GROUP BY Matricula.CodMateria, Matricula.grupo
GO

--8
IF (SELECT COUNT(Matricula.Carnet) FROM Matricula WHERE Matricula.CodMateria IN (SELECT Matricula.CodMateria FROM Matricula)) BETWEEN 20 AND 30
BEGIN
	SELECT Matricula.CodMateria, Matricula.grupo, COUNT(Matricula.Carnet) AS 'Count' 
	FROM Matricula WHERE Matricula.CodMateria IN (SELECT Matricula.CodMateria FROM Matricula)
	GROUP BY Matricula.CodMateria, Matricula.grupo
END
ELSE
BEGIN
	SELECT 'No Hay' AS 'Resultado'
END


--9
ALTER TABLE Profesor
ADD Direccion VARCHAR(30)

--10
INSERT INTO Grupo VALUES ( 'D20', 3,3333)