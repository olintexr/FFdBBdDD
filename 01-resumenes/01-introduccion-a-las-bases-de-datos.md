
# 01 — Introducción a las Bases de Datos  
*Fundamentos ampliados para FFdBBdDD*

## 1. Idea central del capítulo

Una **base de datos** es un conjunto organizado de estructuras que almacenan información de manera fiable, estable, eficiente y práctica. Su propósito es permitir que los datos sobrevivan al tiempo, a los errores humanos, a las fallas del sistema y a la complejidad de los procesos.  
En cualquier organización moderna, la base de datos es el **sistema nervioso central**: coordina, conserva y distribuye la información que alimenta aplicaciones, reportes, decisiones y automatizaciones.

Más allá de ser un simple contenedor, una base de datos representa un **modelo estructurado del mundo real**, diseñado para capturar entidades, relaciones, reglas y restricciones que describen cómo funciona un negocio, una institución o un sistema. Su fortaleza radica en que permite almacenar grandes volúmenes de información sin perder coherencia, evitando duplicaciones innecesarias y garantizando que los datos permanezcan íntegros incluso cuando múltiples usuarios acceden simultáneamente.

En la práctica, una base de datos es el punto donde convergen tres necesidades fundamentales:

- **Persistencia:** los datos deben mantenerse disponibles incluso después de apagar el sistema.  
- **Consistencia:** la información debe ser correcta, completa y coherente en todo momento.  
- **Accesibilidad:** los usuarios y aplicaciones deben poder consultar y actualizar los datos de forma segura y eficiente.

Gracias a estas características, las bases de datos permiten que procesos complejos —como transacciones bancarias, inventarios, matrículas, reservas, historiales médicos o sistemas de facturación— funcionen sin interrupciones y sin riesgo de corrupción de datos.  
En esencia, una base de datos bien diseñada no solo almacena información: **la protege, la organiza y la convierte en un recurso confiable para la toma de decisiones**.

## 2. Conceptos fundamentales

### **Base de datos**
Una base de datos no es solo un archivo con datos: es un **ecosistema estructurado** donde la información se almacena siguiendo reglas claras, con mecanismos que garantizan integridad, coherencia y disponibilidad.  
Su diseño busca que múltiples usuarios puedan acceder a la información sin conflictos, sin duplicación innecesaria y sin riesgo de corrupción.

En este ecosistema conviven diversos componentes que trabajan de manera coordinada: estructuras de almacenamiento optimizadas, índices que aceleran las búsquedas, restricciones que protegen la calidad de los datos, transacciones que aseguran operaciones confiables y mecanismos de recuperación que permiten restaurar el sistema ante fallas. Cada elemento cumple un rol específico dentro de un entorno más amplio, donde la información fluye, se transforma y se conserva con precisión.

Además, este ecosistema no existe aislado: interactúa con aplicaciones, servicios, usuarios y procesos automatizados que dependen de él para funcionar correctamente. Por eso, una base de datos bien diseñada no solo guarda información; **la organiza, la regula y la hace utilizable**, convirtiéndose en la base operativa de cualquier sistema moderno.

---

### **Usos en sistemas de información**
Un sistema de información típico se compone de tres capas:

- **Base de datos**  
  Es el repositorio central donde se almacena la información. Su diseño determina qué tan fácil será consultar, actualizar y mantener los datos.

- **Reglas de negocio**  
  Representan la lógica que gobierna cómo deben comportarse los datos: validaciones, cálculos, restricciones, flujos, políticas internas.  
  Ejemplo: *“Un estudiante no puede inscribirse en más de 6 materias”*.

- **Aplicaciones**  
  Son las interfaces (web, móviles, de escritorio) que permiten a los usuarios interactuar con la información.  
  Las aplicaciones cambian con frecuencia; la base de datos debe permanecer estable.

La base de datos actúa como **fuente única de verdad (Single Source of Truth)**, evitando inconsistencias entre sistemas.

---

### **Niveles de abstracción**
Los SGBD utilizan tres niveles para separar la complejidad del almacenamiento físico de la forma en que los usuarios ven los datos:

1. **Nivel físico**  
   Describe cómo se almacenan los datos en el hardware: archivos, bloques, índices, páginas, estructuras internas.  
   Es el nivel más cercano al sistema operativo y al disco.

2. **Nivel lógico**  
   Define qué datos existen, cómo se organizan y cómo se relacionan.  
   Aquí viven las tablas, claves primarias y foráneas, relaciones, restricciones y modelos conceptuales.

3. **Nivel de vistas**  
   Presenta los datos de forma parcial, filtrada o simplificada según el usuario.  
   Permite ocultar complejidad, proteger información sensible y personalizar la experiencia.

Este modelo permite **independencia de datos**, uno de los pilares del diseño de bases de datos.  
Gracias a esta separación entre niveles, los cambios realizados en un nivel no afectan directamente a los demás: el almacenamiento físico puede optimizarse sin alterar las tablas lógicas, y las vistas pueden modificarse sin impactar la estructura interna. Esta independencia es lo que permite que un sistema evolucione sin romper aplicaciones, reportes o procesos que dependen de él.

En una base de datos, **todos estos elementos confluyen para formar un entorno cohesionado**, donde cada capa cumple una función específica dentro de un ecosistema mayor. El nivel físico garantiza eficiencia y rendimiento; el nivel lógico aporta estructura, reglas y coherencia; y el nivel de vistas ofrece flexibilidad, seguridad y personalización.  
Cuando estos niveles trabajan en armonía, el sistema logra estabilidad, escalabilidad y claridad conceptual, permitiendo que usuarios, aplicaciones y procesos interactúen con los datos de manera confiable y sin exponerse a la complejidad interna del almacenamiento.

---

### **Lenguajes de datos**
Los lenguajes que interactúan con los datos se dividen en dos grandes familias:

- **Procedimentales** (C, C++, Java)  
  El programador debe indicar *cómo* lograr el resultado: pasos, bucles, condiciones, estructuras de control.  
  Ejemplo: recorrer un arreglo para encontrar un valor.

- **No procedimentales** (SQL, QBE)  
  El programador indica *qué* desea obtener, y el sistema decide cómo lograrlo.  
  Ejemplo: `SELECT * FROM Empleado WHERE sueldo > 1000;`

Esta diferencia es clave: SQL no es un lenguaje de programación tradicional, sino un lenguaje declarativo.

---

### **Lenguajes de bases de datos**

#### **DDL — Data Definition Language**
Define y modifica las estructuras de datos.  
Incluye:

- **Restricciones de dominio**  
  Determinan el tipo, rango y formato permitido para cada dato.  
  Ejemplo: `edad INT CHECK (edad >= 0)`

- **Integridad referencial**  
  Garantiza coherencia entre tablas relacionadas.  
  Ejemplo: un pedido no puede existir sin un cliente válido.

- **Asertos**  
  Condiciones globales que deben cumplirse siempre.  
  Ejemplos:  
  - `sueldo > 500`  
  - `inventario >= 0`  
  - `fecha_nacimiento < fecha_actual`

- **Autorización**  
  Controla quién puede ver, modificar o administrar los datos.  
  Es la base de la seguridad en un SGBD.

---

#### **DML — Data Manipulation Language**
Permite trabajar directamente con los datos:

- **Inserción** (`INSERT`)  
- **Modificación** (`UPDATE`)  
- **Eliminación** (`DELETE`)  
- **Consulta** (`SELECT`)

Es el lenguaje que los usuarios y aplicaciones utilizan diariamente.

---

#### **TCL — Transaction Control Language**
Administra transacciones y garantiza las propiedades **ACID**:

## Propiedades ACID explicadas con una transferencia bancaria

### **Atomicidad — Todo o nada**
La atomicidad garantiza que una transacción se ejecute completa o no se ejecute en absoluto.  
En una transferencia bancaria, esto significa:

- Si vas a transferir **₡50.000** desde la cuenta A hacia la cuenta B,  
  entonces deben ocurrir **dos operaciones**:
  1. Restar ₡50.000 de la cuenta A  
  2. Sumar ₡50.000 a la cuenta B  

La atomicidad asegura que **ambas operaciones ocurren juntas**.  
Si ocurre un fallo entre la operación 1 y la 2 (por ejemplo, se cae el servidor), el sistema **revierte todo**.  
Nunca puede quedar el dinero descontado de A sin llegar a B.

---

### **Consistencia — El estado final debe ser válido**
La consistencia garantiza que la base de datos pase de un estado válido a otro estado válido, respetando todas las reglas del sistema.

En la transferencia:

- Ninguna cuenta puede quedar con saldo negativo si la regla del banco lo prohíbe.  
- Las sumas deben cuadrar.  
- Las restricciones deben mantenerse (tipos de datos, rangos, integridad referencial, etc.).

Si la cuenta A solo tiene ₡20.000, una transferencia de ₡50.000 **viola las reglas del sistema**.  
La propiedad de consistencia evita que la transacción se ejecute y mantiene la base de datos en un estado correcto.

---

### **Aislamiento — Las transacciones no interfieren entre sí**
El aislamiento garantiza que cada transacción se ejecute como si fuera la única en el sistema, aunque haya miles ocurriendo al mismo tiempo.

Ejemplo:

- Tú transfieres ₡50.000 de A a B.  
- Al mismo tiempo, otra persona intenta retirar ₡30.000 de la cuenta A.  

El aislamiento evita que ambas operaciones lean un saldo “intermedio” o inconsistente.  
Cada transacción ve la base de datos como si estuviera sola, evitando errores como:

- Doble gasto  
- Lecturas sucias  
- Lecturas no repetibles  
- Actualizaciones perdidas  

El banco no puede permitir que dos operaciones simultáneas “se roben” información entre sí.

---

### **Durabilidad — Una vez confirmada, la transacción persiste**
La durabilidad garantiza que, una vez que la transacción se confirma (COMMIT), el resultado **no se pierde**, incluso si ocurre:

- Un apagón  
- Una caída del sistema  
- Un reinicio del servidor  
- Un fallo de hardware  

Si la transferencia se completó y el sistema devolvió “Transacción exitosa”, entonces:

- El dinero salió de A  
- El dinero llegó a B  
- Y esa información queda guardada en disco, en logs, en registros de recuperación  

No importa lo que pase después: **la operación no se borra**.

Sin ACID, los datos no serían confiables.

---

## 3. Micro‑ejemplos

Esto se muestra a manera de ejemplo, se verá con detalles en temas posteriores.

```sql
-- DDL: creación de una tabla con restricciones básicas
CREATE TABLE Empleado (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    sueldo DECIMAL(10,2) CHECK (sueldo > 500)
);

-- DML: inserción de un registro
INSERT INTO Empleado (id, nombre, sueldo)
VALUES (1, 'Ana Torres', 850);

-- DML: consulta declarativa
SELECT nombre, sueldo
FROM Empleado
WHERE sueldo > 700;

-- TCL: inicio y confirmación de una transacción
BEGIN TRANSACTION;
UPDATE Empleado SET sueldo = sueldo + 50 WHERE id = 1;
COMMIT;
```

---

## 4. Conexión con Korth
Para profundizar en el libro de referencia:

**Korth — Capítulo 1: Introducción a los sistemas de bases de datos**

Secciones clave:
- Motivación de las bases de datos  
- Arquitectura de un SGBD  
- Independencia física y lógica  
- Lenguajes de definición y manipulación  
- Concepto de transacción  

Este capítulo del repositorio funciona como **andamiaje cognitivo** para que el estudiante llegue al texto con claridad conceptual.

---

## 5. Glosario ampliado

- **Base de datos** — Conjunto organizado de datos.  
- **SGBD** — Software que administra la base de datos.  
- **Vista** — Representación parcial o filtrada de los datos.  
- **Dominio** — Conjunto de valores permitidos para un atributo.  
- **Integridad referencial** — Coherencia entre tablas relacionadas.  
- **DDL** — Lenguaje para definir estructuras.  
- **DML** — Lenguaje para manipular datos.  
- **TCL** — Lenguaje para controlar transacciones.  
- **ACID** — Propiedades que garantizan confiabilidad en transacciones.  
- **Transacción** — Unidad lógica de trabajo que debe ejecutarse completa.  

---

## 6. Mini‑quiz

1. Explica con tus palabras la diferencia entre un lenguaje procedimental y uno no procedimental.  
2. ¿Qué nivel de abstracción permite ocultar información sensible a ciertos usuarios?  
3. Da dos ejemplos de restricciones de dominio.  
4. ¿Qué propiedad ACID evita que una transacción quede incompleta?  
5. ¿Por qué las vistas son fundamentales en sistemas con múltiples usuarios?  

---

## 7. Ejercicios sugeridos

- Diseña una tabla con al menos dos restricciones de dominio y una clave primaria.  
- Crea dos tablas relacionadas y define integridad referencial entre ellas.  
- Escribe un ejemplo de transacción que incluya `BEGIN`, `UPDATE` y `COMMIT`.  
- Explica por qué la independencia lógica es importante para el mantenimiento de sistemas.  

---

# Tarea del capítulo

### **Ejercicios a entregar**
- 1.1  
- 1.6  
- 1.7  
- Ensayo (máx. 300 palabras): *¿Qué entiende usted por base de datos?*

Estos ejercicios permiten reforzar los conceptos fundamentales del capítulo y evaluar la comprensión inicial del estudiante sobre la estructura, propósito y funcionamiento de un sistema de bases de datos.

---

### **Formato del correo**

Para garantizar orden y uniformidad en las entregas, el correo debe enviarse siguiendo estrictamente estas indicaciones:

- **Asunto:**  
  `TAREA 01 - CAPÍTULO 1 - APELLIDOS Y NOMBRES COMPLETOS DEL ALUMNO EN MAYÚSCULA`  
  Ejemplo:  
  `TAREA 01 - CAPÍTULO 1 - PEREZ BONALDE, JUAN ANTONIO`

- **Nombre del archivo:**  
  `TAREA 01 - CAPÍTULO 1 - APELLIDOS Y NOMBRES COMPLETOS DEL ALUMNO EN MAYÚSCULA.docx`  
  Ejemplo:  
  `TAREA 01 - CAPÍTULO 1 - PEREZ BONALDE, JUAN ANTONIO.docx`

El nombre del archivo y el asunto del correo deben coincidir exactamente con este formato.  
Esto facilita la organización, clasificación y revisión de las tareas.

---

## Reglas para la entrega del documento

Estas reglas son obligatorias y forman parte de la evaluación:

- El documento **solo debe contener las preguntas y sus respuestas**.  
  No debe incluir explicaciones adicionales, portadas, imágenes ni elementos decorativos.

- No debe llevar portada ni nombre dentro del archivo, ya que esa información se especifica en el asunto del correo.  
  El archivo debe comenzar directamente con la pregunta 1.1.

- No debe incluir dedicatorias, mensajes personales ni elementos ajenos al contenido académico.

- El archivo debe ser creado en **Microsoft Word (.docx)**.  
  No se aceptan otros formatos como PDF, Google Docs, Pages, etc.

- No se aceptan fotografías, imágenes de cuadernos, capturas de pantalla ni digitalizaciones (escaneos).  
  El documento debe ser escrito y editado directamente en Word.

- El estudiante debe **editar el archivo en Word** y enviarlo al correo indicado durante la sesión de clases.  
  Enviar el archivo correcto, con el nombre correcto y en el formato correcto forma parte de la evaluación.

Estas reglas garantizan claridad, legibilidad, uniformidad y profesionalismo en las entregas.

