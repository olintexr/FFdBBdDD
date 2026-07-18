# 05 - Normalizacion de Bases de Datos  
De tabla caótica a Tercera Forma Normal

-------------------------------------------------------------------------------

## 1. Tabla desnormalizada que viola 1FN

Partimos de una tabla que mezcla datos de alumno, curso, profesor y ademas varios cursos dentro de una sola fila. Esta tabla viola directamente la Primera Forma Normal porque contiene listas dentro de las celdas.

Nombre de la tabla: **InscripcionesRaw**

### 1.1. Datos (CSV para copiar y pegar en Excel)

| AlumnoID | AlumnoNombre | AlumnoApellido | CursosIDs     | CursosNombres                     | ProfesoresIDs | ProfesoresNombres           | FechasInscripcion         | NotasFinales |
|----------|--------------|----------------|---------------|-----------------------------------|---------------|-----------------------------|----------------------------|--------------|
| A001     | Carlos       | Perez          | C101,C102     | Matematicas I,Fisica I            | P10,P11       | Ana Gomez,Juan Rojas        | 2024-03-01,2024-03-01     | 85,78        |
| A002     | Maria        | Lopez          | C101          | Matematicas I                     | P10           | Ana Gomez                   | 2024-03-02                | 92           |
| A003     | Pedro        | Ramirez        | C103,C101     | Programacion I,Matematicas I      | P12,P10       | Luis Martinez,Ana Gomez     | 2024-03-05,2024-03-05     | 88,74        |
| A004     | Lucia        | Fernandez      | C104,C102     | Historia Universal,Fisica I       | P13,P11       | Carmen Salas,Juan Rojas     | 2024-03-06,2024-03-06     | 81,79        |
| A005     | Diego        | Molina         | C103,C104     | Programacion I,Historia Universal | P12,P13       | Luis Martinez,Carmen Salas  | 2024-03-07,2024-03-07     | 90,84        |
| A006     | Elena        | Soto           | C101          | Matematicas I                     | P10           | Ana Gomez                   | 2024-03-08                | 88           |


-------------------------------------------------------------------------------

## 2. Problemas de esta tabla

### 2.1. Violacion de 1FN

La Primera Forma Normal exige:

- valores atómicos en cada celda  
- sin listas  
- sin grupos repetitivos  

Esta tabla contiene listas en:

- CursosIDs  
- CursosNombres  
- ProfesoresIDs  
- ProfesoresNombres  
- FechasInscripcion  
- NotasFinales  

Por lo tanto **no cumple 1FN**.

### 2.2. Dificultad para consultar

- Contar cursos por alumno requiere partir cadenas.  
- Buscar notas mayores a 80 en un curso específico requiere combinar texto y posición en listas.

### 2.3. Anomalias de actualización

- Cambiar el nombre de un curso implica modificar todas las listas donde aparezca.  
- Cambiar el nombre de un profesor implica recorrer cadenas en varias filas.

-------------------------------------------------------------------------------

## 3. Dependencias funcionales del dominio

Aunque la tabla este mal construida, el dominio sí tiene dependencias claras:

```
DF1: AlumnoID            --> AlumnoNombre, AlumnoApellido
DF2: CursoID             --> CursoNombre
DF3: ProfesorID          --> ProfesorNombre
DF4: (AlumnoID, CursoID) --> FechaInscripcion, NotaFinal

```

Estas dependencias guiaran la normalización.

-------------------------------------------------------------------------------

## 4. Paso 1: Llevar la tabla a Primera Forma Normal (1FN)

### 4.1. Definición de 1FN

Una tabla esta en 1FN si:

- cada celda contiene un solo valor  
- no hay listas  
- no hay grupos repetitivos  

### 4.2. Transformacion

Debemos "explotar" las listas en filas individuales:  
una fila por **(AlumnoID, CursoID)**.

Resultado: **Inscripciones1FN**

| AlumnoID | AlumnoNombre | AlumnoApellido | CursoID | CursoNombre        | ProfesorID | ProfesorNombre | FechaInscripcion | NotaFinal |
|----------|--------------|----------------|---------|---------------------|------------|-----------------|-------------------|-----------|
| A001     | Carlos       | Perez          | C101    | Matematicas I       | P10        | Ana Gomez       | 2024-03-01        | 85        |
| A001     | Carlos       | Perez          | C102    | Fisica I            | P11        | Juan Rojas      | 2024-03-01        | 78        |
| A002     | Maria        | Lopez          | C101    | Matematicas I       | P10        | Ana Gomez       | 2024-03-02        | 92        |
| A003     | Pedro        | Ramirez        | C103    | Programacion I      | P12        | Luis Martinez   | 2024-03-05        | 88        |
| A003     | Pedro        | Ramirez        | C101    | Matematicas I       | P10        | Ana Gomez       | 2024-03-05        | 74        |
| A004     | Lucia        | Fernandez      | C104    | Historia Universal  | P13        | Carmen Salas    | 2024-03-06        | 81        |
| A004     | Lucia        | Fernandez      | C102    | Fisica I            | P11        | Juan Rojas      | 2024-03-06        | 79        |
| A005     | Diego        | Molina         | C103    | Programacion I      | P12        | Luis Martinez   | 2024-03-07        | 90        |
| A005     | Diego        | Molina         | C104    | Historia Universal  | P13        | Carmen Salas    | 2024-03-07        | 84        |
| A006     | Elena        | Soto           | C101    | Matematicas I       | P10        | Ana Gomez       | 2024-03-08        | 88        |


Ahora la tabla **cumple 1FN**.

-------------------------------------------------------------------------------

## 5. Paso 2: Segunda Forma Normal (2FN)

### 5.1. Definición de 2FN

Una tabla esta en 2FN si:

- está en 1FN  
- todos los atributos no clave dependen completamente de la clave primaria  
- no hay dependencias parciales  

### 5.2. Clave primaria actual

```
(AlumnoID, CursoID)
```

### 5.3. Dependencias parciales

```
DF1: AlumnoID            --> AlumnoNombre, AlumnoApellido
DF2: CursoID             --> CursoNombre, ProfesorID
DF3: ProfesorID          --> ProfesorNombre

```

Esto viola 2FN.

### 5.4. Transformacion a 2FN

Separar entidades:

#### Tabla Alumno

| AlumnoID | AlumnoNombre | AlumnoApellido |
|----------|--------------|----------------|
| A001     | Carlos       | Perez          |
| A002     | Maria        | Lopez          |
| A003     | Pedro        | Ramirez        |
| A004     | Lucia        | Fernandez      |
| A005     | Diego        | Molina         |
| A006     | Elena        | Soto           |


#### Tabla Profesor

| ProfesorID | ProfesorNombre |
|------------|----------------|
| P10        | Ana Gomez      |
| P11        | Juan Rojas     |
| P12        | Luis Martinez  |
| P13        | Carmen Salas   |


#### Tabla Curso

| CursoID | CursoNombre        | ProfesorID |
|---------|---------------------|------------|
| C101    | Matematicas I       | P10        |
| C102    | Fisica I            | P11        |
| C103    | Programacion I      | P12        |
| C104    | Historia Universal  | P13        |


#### Tabla Inscripcion

| AlumnoID | CursoID | FechaInscripcion | NotaFinal |
|----------|---------|-------------------|-----------|
| A001     | C101    | 2024-03-01        | 85        |
| A001     | C102    | 2024-03-01        | 78        |
| A002     | C101    | 2024-03-02        | 92        |
| A003     | C103    | 2024-03-05        | 88        |
| A003     | C101    | 2024-03-05        | 74        |
| A004     | C104    | 2024-03-06        | 81        |
| A004     | C102    | 2024-03-06        | 79        |
| A005     | C103    | 2024-03-07        | 90        |
| A005     | C104    | 2024-03-07        | 84        |
| A006     | C101    | 2024-03-08        | 88        |


Ahora estamos en **2FN**.

-------------------------------------------------------------------------------

## 6. Paso 3: Tercera Forma Normal (3FN)

### 6.1. Definicion de 3FN

Una tabla esta en 3FN si:

- esta en 2FN  
- no existen dependencias transitivas  

### 6.2. Dependencia transitiva detectada

```
DF: CursoID --> ProfesorID --> ProfesorNombre

```

La solucion ya se aplicó: separar Profesor.

### 6.3. Esquema final en 3FN

#### Alumno

```
AlumnoID (PK)
AlumnoNombre
AlumnoApellido
```

#### Profesor

```
ProfesorID (PK)
ProfesorNombre
```

#### Curso

```
CursoID (PK)
CursoNombre
ProfesorID (FK)
```

#### Inscripcion

```
AlumnoID (FK)
CursoID (FK)
FechaInscripcion
NotaFinal
PK = (AlumnoID, CursoID)
```

-------------------------------------------------------------------------------

## 7. Bibliografía para formas normales avanzadas

### BCNF
- Codd - A Relational Model of Data for Large Shared Data Banks  
- Date - An Introduction to Database Systems  

### 4FN
- Fagin - Multivalued Dependencies and a New Normal Form for Relational Databases  

### 5FN
- Fagin - Normal Forms and Relational Database Operators  

### Libros recomendados
- Connolly y Begg - Database Systems
- Date - Database Design and Relational Theory  
- Elmasri y Navathe - Fundamentals of Database Systems
- Rodríguez Olinto - Trabajo de ascenso de 2004 (material entregado en clases)

-------------------------------------------------------------------------------

