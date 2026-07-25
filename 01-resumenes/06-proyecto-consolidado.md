# Proyecto de Bases de Datos  
Tópicos Avanzados de Bases de Datos  
Septiembre 2026  
Python + SQL (PostgreSQL, SQL Server o MySQL)

Este proyecto evalúa los contenidos fundamentales del curso:  
- Modelo relacional  
- Normalización  
- Dependencias funcionales  
- Diseño de esquemas  
- Construcción de tablas  
- Carga de datos  
- Consultas SQL  
- Integridad  
- Documentación técnica

El proyecto debe realizarse exclusivamente con:
- Python
- SQL (PostgreSQL, SQL Server o MySQL)

No se permiten triggers, procedimientos almacenados ni funciones.  
El enfoque es bases de datos puras.

---

## 1. Objetivo general

Diseñar, normalizar, implementar y poblar una base de datos completa en un dominio libre, aplicando todos los conceptos vistos en el curso y demostrando dominio del modelo relacional y SQL.

---

## 2. Requisitos técnicos obligatorios

### 2.1 Dominio libre
El estudiante puede elegir cualquier dominio, siempre que cumpla los requisitos técnicos:

- Ventas  
- Alquileres  
- Remates  
- Censo  
- Inventario  
- Hospitales  
- Bibliotecas  
- Universidades  
- Transporte  
- Logística  
- Agricultura  
- Comercio electrónico  
- Juegos  
- Deportes  
- Turismo  
- Restaurantes  
- Laboratorios  
- Producción industrial  
- Cualquier otro dominio con datos estructurables

---

## 3. Diseño conceptual

El estudiante debe entregar:

1. Lista de entidades del dominio.  
2. Atributos de cada entidad.  
3. Dependencias funcionales.  
4. Claves candidatas.  
5. Proceso de normalización completo:  
   - 1FN  
   - 2FN  
   - 3FN  
6. Modelo entidad–relación en ASCII.  
7. Modelo relacional final.

Todo debe estar documentado en un archivo `.md`.

---

## 4. Diseño lógico

El estudiante debe entregar:

1. Esquema relacional final.  
2. Justificación de claves primarias.  
3. Justificación de claves foráneas.  
4. Justificación de restricciones NOT NULL y UNIQUE.  
5. Justificación de dominios de atributos.

---

## 5. Implementación SQL

El estudiante debe entregar scripts `.sql` con:

1. Creación de la base de datos.  
2. Creación de **al menos cuatro tablas**.  
3. Inserción de datos base (dimensiones).  
4. Inserción de datos masivos (tabla principal).  
5. Consultas SQL obligatorias:  
   - Selección simple  
   - Selección con filtros  
   - **JOINS (obligatorio)**  
   - **GROUP BY (obligatorio)**  
   - Agregaciones  
   - Agrupaciones  
   - Ordenamientos  
   - Subconsultas  
   - Consultas con condiciones compuestas  
   - Consultas que demuestren el uso correcto del modelo normalizado

No se permiten triggers, procedimientos ni funciones.

---

## 6. Generación de datos masivos

El estudiante debe generar al menos:

- **300 registros** para la tabla principal del dominio

Los datos pueden generarse con:

- Python  
- SQL (PostgreSQL, SQL Server o MySQL)

El estudiante puede elegir cualquiera de los dos métodos.

El script debe:

1. Generar los datos.  
2. Guardarlos en un archivo `.csv` o `.txt` si se usa Python.  
3. Cargarlos en la base de datos usando Python o SQL.

---

## 7. Consultas obligatorias

El estudiante debe entregar un archivo `.sql` con:

1. Consultas de selección  
2. Consultas con filtros  
3. **Consultas con JOINS (obligatorio)**  
4. **Consultas con GROUP BY (obligatorio)**  
5. Consultas con agregaciones  
6. Consultas con agrupaciones  
7. Consultas con subconsultas  
8. Consultas con condiciones compuestas  
9. Consultas que demuestren el uso correcto del modelo normalizado

---

## 8. Documento de Justificación de Normalización (MD)

El archivo **.md** debe contener:

### 8.1 Introducción al dominio  
Descripción breve del dominio y por qué requiere normalización.

### 8.2 Dependencias funcionales  
Listado completo y justificación de cada dependencia funcional.

### 8.3 Claves candidatas  
Identificación y explicación de por qué son claves.  
Justificación de la clave primaria elegida.

### 8.4 Proceso de normalización  
Debe incluir:

#### 1FN  
- Eliminación de grupos repetitivos  
- Atributos atómicos  
- Justificación técnica

#### 2FN  
- Identificación de dependencias parciales  
- Separación de tablas cuando la clave es compuesta  
- Justificación técnica

#### 3FN  
- Identificación de dependencias transitivas  
- Separación de atributos dependientes de atributos no clave  
- Justificación técnica

### 8.5 Modelo final en 3FN  
Diagrama ASCII del modelo final.  
Explicación de por qué está correctamente normalizado.

### 8.6 Comparación entre modelo inicial y final  
- Problemas del diseño inicial  
- Cómo la normalización los resolvió  
- Ventajas del modelo final

### 8.7 Conclusiones  
Impacto de la normalización en:  
- Integridad  
- Reducción de redundancia  
- Facilidad de consultas SQL  
- Mantenimiento futuro

El archivo debe llamarse:  
**PROYECTO SEPTIEMBRE 2026 - APELLIDOS, NOMBRES.md**


Ejemplo:  
**PROYECTO SEPTIEMBRE 2026 - PÉREZ BONALDE, JUAN ANTONIO.md**

---

## 9. Entregables

El correo debe incluir un archivo `.zip` con:

- Todos los `.sql`  
- Todos los `.py`  
- Archivo `base.txt` con:  
  - Versión de Python utilizada  
  - Fabricante del manejador SQL (PostgreSQL, SQL Server o MySQL)  
- Documento **MD**:  
  - PROYECTO SEPTIEMBRE 2026 - APELLIDOS, NOMBRES.md
- Ejemplo documento **MD**:  
  - PROYECTO SEPTIEMBRE 2026 - PÉREZ BONALDE, JUAN ANTONIO.md
---

## 10. Condiciones de entrega

Enviar un correo a la cuenta ya conocida.

### Subject del correo
Formato:

PROYECTO SEPTIEMBRE 2026 - APELLIDOS, NOMBRES

Ejemplo:

PROYECTO SEPTIEMBRE 2026 - PÉREZ BONALDE, JUAN ANTONIO

### Nombre del archivo .zip
Formato:

PROYECTO SEPTIEMBRE 2026 - APELLIDOS, NOMBRES.zip

Ejemplo:

PROYECTO SEPTIEMBRE 2026 - PÉREZ BONALDE, JUAN ANTONIO.zip

### Fecha de entrega
4 de septiembre de 2026  
Hora de Venezuela (GMT-4)

Entregas posteriores se consideran fuera de lapso.

---

## 11. Criterios de evaluación

- Calidad del diseño conceptual  
- Calidad del proceso de normalización  
- Claridad del modelo relacional  
- Correcta implementación SQL  
- Limpieza y coherencia de los datos generados  
- Calidad de los JOINS y GROUP BY  
- Documento MD de normalización  
- Documentación técnica  
- Capacidad de ejecutar todo localmente con Python + SQL  
- Originalidad del dominio elegido

---

Fin del documento.
