# Conversión de Modelo E/R a Modelo Relacional

Este documento describe cómo transformar distintos tipos de relaciones del modelo entidad-relación (E/R) en tablas del modelo relacional.

## Caso 1: Relaciones 1:N

En una relación 1:N, una entidad del lado "1" se asocia con varias entidades del lado "N". La forma más habitual de representarlo en el modelo relacional es agregar una clave foránea en la tabla del lado "N".

### Ejemplo

Entidad `Pais`:

- `pais_id*` (clave primaria)
- `nombre`
- `capital`
- `poblacion`

| pais_id | nombre    | capital | poblacion   |
|--------:|-----------|---------|-------------|
| 0001    | Venezuela | Caracas | 30 000 000  |
| 0003    | España    | Madrid  | 20 000 000  |
| 0008    | Egipto    | Cairo   | 60 000 000  |

Entidad `Autor`:

- `autor_id*` (clave primaria)
- `nombre`
- `fecha_nacimiento`
- `pais_id` (clave foránea)

| autor_id | nombre   | fecha_nacimiento | pais_id |
|---------:|----------|------------------|--------:|
| 0001     | Olinto   | 1969             | 0008    |
| 7777     | Juancito | 1999             | 0001    |
| 0008     | Mariana  | 2003             | 0003    |
| 0088     | Rita     | 1980             | 0003    |
| 0888     | Abdul    | 1987             | 0008    |

### Reglas clave

- La tabla del lado `N` hereda la clave primaria de la tabla del lado `1`.
- El atributo heredado se denomina **clave foránea**.
- La clave foránea no necesita ser clave primaria en la tabla que la recibe, aunque puede serlo si el diseño lo requiere.
- Esta técnica garantiza integridad referencial: cada autor debe pertenecer a un país existente.

---

## Caso 2: Relaciones N:N

Cuando una entidad puede relacionarse con varias de otra y viceversa, la relación es de tipo N:N. En el modelo relacional se resuelve creando una tabla intermedia.

### Ejemplo

Entidad `Autor`:

- `autor_id*`
- `nombre`
- `fecha_nacimiento`

Entidad `Obra`:

- `obra_id*`
- `nombre`
- `fecha_publicacion`

| obra_id | nombre                       | fecha_publicacion |
|--------:|------------------------------|-------------------|
| 9999    | El lobo gris                 | 2020              |
| 9995    | Historia del crimen          | 2022              |
| 7788    | Venezuela y sus bosques      | 2025              |

Entidad intermedia `escrita`:

- `obra_id*` (clave foránea hacia `Obra`)
- `autor_id*` (clave foránea hacia `Autor`)
- `porcentaje`

| obra_id | autor_id | porcentaje |
|--------:|---------:|-----------:|
| 9999    | 0001     | 100        |
| 7788    | 7777     | 100        |
| 9995    | 0008     | 20         |
| 9995    | 0888     | 10         |
| 9995    | 0088     | 70         |

> Ejemplo incorrecto: `9995, 0088, 0`.
> Este registro viola la unicidad de la clave primaria compuesta `(obra_id, autor_id)` porque duplicaría la misma combinación de claves.

### Reglas clave

- Las relaciones N:N siempre se traducen a una tabla nueva.
- La tabla intermedia hereda las claves de las dos tablas originales.
- Es común que las claves heredadas formen conjuntamente la clave primaria de la tabla intermedia.
- Si la relación tiene atributos propios (como `porcentaje`), se agregan en la tabla intermedia.
- El nombre de la relación suele convertirse en el nombre de la tabla resultante.

---

## Caso 3: Relaciones 1:1

En relaciones 1:1, cada instancia de una entidad se relaciona con como máximo una instancia de la otra entidad. Hay dos formas comunes de implementar esto en el modelo relacional.

### Opción A: Usar clave foránea en una tabla

1. Elegir una tabla como independiente y la otra como dependiente.
2. La tabla dependiente recibe la clave primaria de la tabla independiente.
3. El atributo heredado actúa como clave foránea.

Esto se maneja de manera similar a una relación 1:N, pero con una restricción adicional de unicidad para preservar el carácter 1:1.

### Opción B: Usar tabla intermedia

1. Crear una tabla intermedia que represente la relación.
2. La tabla intermedia hereda las claves primarias de ambas tablas.
3. La clave primaria de la tabla intermedia puede ser una de las claves heredadas o la combinación de ambas.
4. La otra clave heredada actúa como clave foránea adicional.

Esta opción puede ser útil cuando la relación 1:1 tiene atributos propios o cuando se desea modelar la asociación de forma explícita.

### Consideraciones

- Opción A es más simple y eficiente cuando no hay atributos de relación.
- Opción B es más flexible si la relación tiene atributos o requiere una asociación independiente.
- En ambos casos se debe asegurar que no exista más de una fila relacionada para cada lado de la relación.

---

## Caso 4: Relaciones N:N que participan en otra relación

Cuando una relación N:N se conecta con una tercera entidad `U`, el proceso se hace en dos pasos.

1. Resolver la relación N:N original y generar la tabla intermedia.
2. Tratar la tabla intermedia resultante como una tabla normal.

### Luego aplicar el caso según la nueva relación con `U`

- Si la relación con `U` es `1:N`, usar el método del **Caso 1**.
- Si la relación con `U` es `N:N`, usar el método del **Caso 2**.
- Si la relación con `U` es `1:1`, usar el método del **Caso 3**.

### Ejemplo conceptual

Si `Autor` y `Obra` están en una relación N:N y la tabla intermedia `escrita` se relaciona con otra entidad `Editorial`, entonces:

- Primero se crea `escrita`.
- Luego se modela la relación entre `escrita` y `Editorial` según el tipo de relación que exista.

Este enfoque modular facilita el diseño relacional cuando hay múltiples niveles de asociación.
