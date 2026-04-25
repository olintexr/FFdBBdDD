# 02 — Introducción al Modelo Entidad–Relación (E‑R)  
*Fundamentos conceptuales para el diseño de bases de datos*

## 1. Idea central del capítulo

El **Modelo Entidad–Relación (E‑R)** es la herramienta fundamental para representar la estructura conceptual de un sistema de información. Permite describir el negocio mediante **entidades**, **atributos** y **relaciones**, antes de pensar en tablas, claves o SQL.  
Su propósito es capturar la realidad de forma clara, precisa y comprensible tanto para analistas como para usuarios.

Modelar no es dibujar cajas: es **interpretar el negocio**, abstraerlo y traducirlo a un lenguaje formal que luego se convertirá en el diseño lógico y físico de la base de datos.

---

## 2. Modelar el negocio

Antes de construir el modelo E‑R, se debe entender el funcionamiento del negocio. Esto implica analizar:

### **2.1. Qué se quiere hacer (el negocio)**
Define el propósito del sistema: qué problema resuelve, qué procesos soporta y qué información necesita.

### **2.2. Actores**
Son los entes involucrados: personas, departamentos, sistemas, clientes, proveedores, usuarios.

### **2.3. Flujo de datos**
Describe cómo se mueve la información:

- Qué datos circulan  
- Qué documentos participan  
- Qué procesos los generan  
- Qué eventos los transforman  

### **2.4. Reducción conceptual**
Todo lo anterior se reduce a:

- **Entidades** (objetos del mundo real)  
- **Atributos** (características de esos objetos)  
- **Métodos o procesos** (acciones que operan sobre los datos)

El modelo E‑R captura esta estructura conceptual de forma ordenada.

---

## 3. Entidades

Una **entidad** es un objeto del mundo real que puede identificarse de manera única y que posee atributos.

### **3.1. Características**
- Son **objetos identificables**.  
- Tienen **atributos** que describen sus propiedades.  
- Representan cosas relevantes para el negocio.

Ejemplos: Cliente, Producto, Empleado, Curso, Factura.

---

## 4. Atributos

Los atributos son las **columnas** o características que describen a una entidad.

### **4.1. Tipos de atributos**

#### **Repetibles**
Pueden tener valores comunes entre distintas instancias.  
Ejemplos: color de ojos, estatura, precio, fecha de nacimiento.

#### **No repetibles**
Identifican de forma única.  
Ejemplos: cédula, placa del carro, número de carné, huella dactilar.

---

### **4.2. Dominio del atributo**
Es el **tipo de dato** permitido:

- Numéricos: entero, real, flotante  
- Tiempo: fecha, hora, timestamp  
- Caracteres: char, varchar, long varchar  
- Lógico: verdadero/falso  
- Semiestructurados: JSON, XML  
- No estructurados: BLOB  

---

### **4.3. Rango del atributo**
Son los **valores posibles** dentro del dominio.

Ejemplos:

- Sexo: F, M, D, O  
- Edad: ≥ 0  
- Sueldo: ≥ 0  
- Estado civil: So, Ca, Vi, Di, Co, D  
- Precio: ≥ 0  

---

### **4.4. Coherencia dominio/rango**
El rango debe corresponder al dominio.

Ejemplos:

- Si `sueldo ≥ 0`, el dominio debe ser numérico.  
- Si `sexo ∈ {F, M, D, O}`, el dominio debe ser cadena.

---

### **4.5. Obligatoria vs. opcional**
Un atributo puede ser obligatorio o no.

- Espacio en blanco es un valor.  
- Cadena vacía es un valor.  
- Cero es un valor.  

**NULL significa SIN VALOR**, no cero, no vacío, no espacio.

---

## 5. Relaciones

Las relaciones definen **cómo se vinculan las entidades** entre sí.

### **5.1. Ejemplos**
- Una lista contiene muchos productos.  
- Un alumno inscribe varios cursos.  
- Un curso tiene un profesor asignado.  
- Una persona tiene muchos familiares.  
- Una cuenta bancaria tiene un titular.

---

### **5.2. Tipos de relaciones**

#### **1:1**
Una instancia se relaciona con una sola instancia.  
Ejemplo: una persona tiene un solo padre.

#### **1:N**
Una instancia se relaciona con muchas.  
Ejemplo: un alumno compra varios libros.

#### **N:N**
Muchas instancias se relacionan con muchas.  
Ejemplo: productos ↔ facturas.

---

### **5.3. Cardinalidad**
Define el número mínimo y máximo de ocurrencias:

- (0,1) → opcional, máximo una  
- (1,1) → obligatorio, exactamente una  
- (0,n) → opcional, muchas  
- (1,n) → obligatorio, muchas  

---

### **5.4. Tipo de participación**
- **Total:** la entidad debe participar.  
- **Parcial:** puede existir sin participar.

---

## 6. Tipos de entidades

### **6.1. Entidades fuertes**
Pueden existir por sí mismas.  
Ejemplos: Cliente, Producto, Empleado.

### **6.2. Entidades débiles**
Dependen de otra entidad.  
Ejemplo: DetalleFactura depende de Factura.  
Requieren clave compuesta o clave foránea.

---

## 7. Atributos especiales

- **Clave primaria:** identifica de forma única.  
- **Derivado:** se calcula a partir de otros.  
  Ejemplo: Edad ← FechaNacimiento.  
- **Multivaluado:** tiene varios valores.  
  Ejemplo: teléfonos, correos.  
- **Compuesto:** se descompone.  
  Ejemplo: Dirección → Calle, Número, Ciudad, País.

---

## 8. Importancia del modelo E‑R

El modelo E‑R es fundamental porque:

- Representa la **estructura conceptual** de los datos.  
- Facilita la comunicación entre analistas y usuarios.  
- Es la base del diseño lógico y físico de la BD.  
- Permite detectar errores y redundancias tempranas.  
- Visualiza el sistema antes de implementarlo.

---

## 9. Representación textual (ASCII)

```
[Entidad] --(Relación)--> [OtraEntidad]
```

Ejemplo:

```
[Cliente] --(Compra)--> [Producto]

Cliente:
    id_cliente, nombre, email

Producto:
    id_producto, nombre, precio

Compra:
    fecha, cantidad, total
```

---

## 10. Glosario

- **Entidad:** objeto del mundo real.  
- **Atributo:** característica de una entidad.  
- **Dominio:** tipo de dato permitido.  
- **Rango:** valores posibles dentro del dominio.  
- **Relación:** vínculo entre entidades.  
- **Cardinalidad:** número mínimo y máximo de ocurrencias.  
- **Participación:** obligatoriedad de la relación.  
- **Entidad fuerte:** independiente.  
- **Entidad débil:** dependiente.  
- **Atributo clave:** identifica de forma única.  
- **Atributo derivado:** calculado.  
- **Atributo multivaluado:** varios valores.  
- **Atributo compuesto:** se descompone.

---

## 11. Mini‑quiz

1. ¿Qué diferencia a una entidad fuerte de una entidad débil?  
2. Da un ejemplo de atributo derivado.  
3. ¿Qué significa la cardinalidad (1,n)?  
4. ¿Qué es el dominio de un atributo?  
5. ¿Por qué el modelo E‑R es útil antes de implementar la base de datos?

---

## 12. Ejercicios sugeridos

- Identifica 5 entidades de un negocio real.  
- Define 3 atributos para cada entidad, indicando dominio y rango.  
- Crea 3 relaciones entre esas entidades, con cardinalidades.  
- Clasifica cada entidad como fuerte o débil.  
- Representa el modelo en ASCII.

---

# 📬 Tarea del capítulo

### **Ejercicios a entregar**
- Identificación de entidades  
- Atributos con dominio y rango  
- Relaciones con cardinalidades  
- Diagrama E‑R en texto (ASCII)  
- Ensayo (máx. 300 palabras): *¿Por qué es importante modelar antes de diseñar?*

### **Formato del correo**
- **Asunto:**  
  `TAREA 02 - CAPÍTULO 2 - APELLIDOS Y NOMBRES COMPLETOS DEL ALUMNO EN MAYÚSCULA`

- **Nombre del archivo:**  
  `TAREA 02 - CAPÍTULO 2 - APELLIDOS Y NOMBRES COMPLETOS DEL ALUMNO EN MAYÚSCULA.docx`

### **Reglas para la entrega**
- Solo preguntas y respuestas.  
- Sin portada ni nombre dentro del archivo.  
- Sin dedicatorias ni elementos extra.  
- Formato obligatorio: **Word (.docx)**.  
- No se aceptan fotos, capturas ni escaneos.  
- El archivo debe enviarse durante la sesión de clases.

