# **Java SE 17 Developer (OCP) \- Capítulos 1 y 2**

## ---

**CAPÍTULO 1: Bloques de Construcción (Building Blocks)**

### ---

**1\. Estructura de un Archivo Java**

> * **Orden obligatorio:** package → import → class / interface / record.  
> * **Clase pública:** En un archivo .java puede haber como máximo **una** clase public, y su nombre debe coincidir exactamente con el nombre del archivo. Pueden existir múltiples clases con visibilidad por defecto (*package-private*).  
> * **Método main:**  
>   public static void main(String\[\] args)  
  * public y static pueden intercambiar orden (static public void main).  
  * void siempre va antes del nombre del método.  
  * Los argumentos pueden escribirse como String\[\] args, String args\[\] o varargs String... args.

### **2\. Paquetes e Importaciones**

> * El comodín \* importa todas las clases del paquete, pero **no subpaquetes** (ej. import java.util.\*; no importa java.util.concurrent.\*).  
> * El paquete java.lang se importa de forma implícita y automática en todos los archivos.  
> * **Colisión de nombres:** Si dos paquetes tienen una clase con el mismo nombre (ej. java.util.Date y java.sql.Date), se debe especificar el nombre calificado completo (*FQCN*) o importar explícitamente una de ellas.

### **3\. Tipos Primitivos vs. Referencias**

| Tipo | Tamaño | Rango / Valores | Valor por defecto (atributos) |
| :---- | :---- | :---- | :---- |
| boolean | Depende de la JVM | true o false | false |
| byte | 8 bits | \-128 a 127 | 0 |
| short | 16 bits | \-32,768 a 32,767 | 0 |
| char | 16 bits (sin signo) | 0 a 65,535 ('\\u0000') | '\\u0000' |
| int | 32 bits | \-2^31 a 2^31 \- 1 (por defecto en enteros) | 0 |
| long | 64 bits | \-2^63 a 2^63 \- 1 (sufijo L) | 0L |
| float | 32 bits | Decimal simple (sufijo obligatorio F) | 0.0f |
| double | 64 bits | Decimal doble (por defecto en decimales) | 0.0d |

**Regla de Guiones Bajos (\_):** Se usan para legibilidad (ej. 1\_000\_000). No pueden ir al inicio, al final, pegados a un punto decimal (1\_.5 error) ni pegados al sufijo (100\_L error).

### **4\. Inferencia de Tipo Local (var)**

> * Permitido **únicamente en variables locales** dentro de métodos, constructores o bucles.  
> * **Debe inicializarse en la misma línea:** var x; o var x \= null; **no compilan**.  
> * **No permitido:** En campos de instancia, atributos estáticos, parámetros de métodos o tipos de retorno.  
> * No es una palabra clave reservada; es un nombre de tipo reservado (es legal llamar a una variable var).

### **5\. Ámbito y Valores por Defecto**

> * **Variables locales:** No tienen valor por defecto. Intentar leerlas antes de inicializarlas produce error de compilación.  
> * **Variables de instancia y estáticas:** Se inicializan automáticamente con ceros, false o null al instanciarse o cargarse la clase.

### **6\. Destrucción de Objetos y Garbage Collector**

> * Un objeto es elegible para el recolector de basura (GC) en el momento exacto en que **no existe ninguna referencia accesible hacia él**.  
> * System.gc() sugiere la recolección, pero **no garantiza** su ejecución inmediata.

## ---

**CAPÍTULO 2: Operadores (Operators)**

### ---

**1\. Precedencia de Operadores**

> 1. Posfijo: x++, x--  
> 2. Unarios / Prefijo: \++x, \--x, \+, \-, \!, (type) cast  
> 3. Multiplicativos: \*, /, %  
> 4. Aditivos: \+, \-  
> 5. Relacionales: \<, \<=, \>, \>=, instanceof  
> 6. Igualdad: \==, \!=  
> 7. Lógicos / Cortocircuito: &&, luego ||  
> 8. Ternario: ? :  
> 9. Asignación: \=, \+=, \-=, \*=, etc.

### **2\. Reglas de Promoción Numérica**

> * **Tipos menores:** byte, short y char se promueven **automáticamente a int** en cualquier operación aritmética.  
>   short a \= 1; short b \= 2; short c \= a \+ b; // ¡NO COMPILA\! (a \+ b resulta en int)  
>   *Solución:* short c \= (short)(a \+ b);  
> * **Tipo mayor:** Si los tipos son distintos, el menor se promueve al mayor (ej. int \+ double → double).  
> * **División entera:** 9 / 2 da 4\. Para decimales: 9 / 2.0 da 4.5.

### **3\. Incremento y Decremento**

> * **Pre-incremento (++x):** Modifica el valor en memoria y luego devuelve el nuevo valor.  
> * **Post-incremento (x++):** Devuelve el valor actual para la expresión y luego incrementa en memoria.

### **4\. Asignación Compuesta**

> * Operadores como \+=, \-=, \*= realizan un **casteo implícito**.  
>   short s \= 5;  
>   s \+= 2; // Compila perfectamente, equivale a: s \= (short)(s \+ 2);

### **5\. Comparación e Igualdad**

> * \== en primitivos compara el valor numérico/literal.  
> * \== en objetos compara la **referencia en memoria** (si apuntan al mismo objeto en el Heap), no el contenido lógico. Para contenido se utiliza .equals().

### **6\. Operadores de Cortocircuito**

> * &&: Si el lado izquierdo es falso, el lado derecho **no se evalúa**.  
> * ||: Si el lado izquierdo es verdadero, el lado derecho **no se evalúa**.  
> * Evita excepciones como NullPointerException:  
>   if (cadena \!= null && cadena.length() \> 0\) { ... }

### **7\. Operador Ternario**

condicionBooleana ? expresionSiTrue : expresionSiFalse;

> * Evaluación perezosa: solo una de las dos ramas se ejecuta.  
> * Ambas ramas deben ser compatibles con el tipo de la variable receptora.
