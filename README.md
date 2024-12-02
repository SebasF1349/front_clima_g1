# ⛅ TP 2 Labo IV - Grupo 1 - Prototipo aplicación Andorid del clima ⛅

## 📋 Descripción del proyecto

Esta es la segunda parte de un proyecto realizado para la materia "Laboratorio IV" de la Tecnicatura Universitaria en Programación, dictada en la UTN-FRBB. Dicho proyecto consiste en la creación de un prototipo de una aplicación donde cada integrante del grupo debe cubrir las siguietnes pantallas o widgets:

- Screen Lista de registros.
- Screen Visualización individual de un registro.
- Widget reutilizable.

## 🛠 Tecnologías utilizadas

- Dart
- Flutter

### Themes

- Latte
- Frappe
- Macchiato
- Mocha
- Sistema

## Screens

### Screen Busqueda

En esta pantalla podemos buscar entre una lista de 50 ciudades, con su bandera y a la provincia que corresponden.

<img src="img_docs/Screen%20busqueda.jpeg" width=30% height=30% alt="Busqueda Ciudades">

Acá elegimos la ciudad que queremos saber el clima.

<img src="img_docs/Lista%20de%20ciudades.jpeg" width=30% height=30% alt="Busqueda Ciudades">

### Screen Ciudad Seleccionada

En esta pantalla muestra la ciudad seleccionada, con su nombre y bandera del país correspondiente y dos botones para saber el clima de hoy y el futuro o el clima pasado, donde al presionarlos te redigirá a las pantallas correspondientes.

<img src="img_docs/Screen%20ciudad%20seleccionada.jpeg" width=30% height=30% alt="Ciudad seleccionada: Bahía Blanca, Argentina. Con dos botones.">

### Screen Pronóstico

En esta pantalla, una vez seleccionada la ciudad, muestra el nombre de la ciudad con su país, la temperatura actual, una descripción del tiempo, la temperatura máxima y mínima, el porcentaje de probabilidad de lluvia. Seguido muestra un gráfico de la temperatura por hora del día actual y otra gráfico donde muestra la temperatura máxima y mínima de los próximos 15 días.

<img src="img_docs/Screen%20pronostico.png" width=30% height=30% alt="Pantalla de pronóstico">

Al presionar en cada horario se puede acceder a más información sobre el prónostico en esa hora. Además, en la parte inferior de la pantalla se encuentran botones para navegar entre los horarios.

<img src="img_docs/Mas%20informacion%20en%20horario.jpeg" width=30% height=30% alt="Pantalla hora, con más información.">

Al presionar en cada fecha del gráfico de los próximos días, se puede acceder a otra pantalla que contiene más información del pronóstico de ese día. Además, en la parte inferior de la pantalla se encuentran botones para navegar entre las fechas.

<img src="img_docs/Mas%20informacion%20en%20fecha.jpeg" width=30% height=30% alt="Pantalla fecha, con más información.">

### Screen Historial del Clima

En esta pantalla, una vez seleccionada la ciudad, muestra el historial del clima de los días pasados con información simplificada.

<img src="img_docs/Screen%20historial%20del%20clima.jpeg" width=30% height=30% alt="Pantalla historial del clima.">

Al presionar en una de las fechas pasadas, se muestra información más detallada del clima de esa fecha. Contiene el nombre de la ciudad y su país, la temperatura promedio de ese día, una breve descripción del clima, la temperatura máxima y mínima, el viento, las precipitaciones en mm y un gráfico por hora de la temperatura promedio.

<img src="img_docs/Clima%20de%20una%20fecha%20pasada.jpeg" width=30% height=30% alt="Pantalla del clima de una fecha pasada.">

Al igual que en la pantalla del prónostico actual, se puede acceder a más información en cada hora al presionarla.

### Screen Configuración

En esta pantalla se puede cambiar la configuración de la aplicación.
En primer lugar, tenemos la opción para cambiar el tema, es decir, como se visualiza la aplicación en ciertos colores. Lista de opciones:

- latte: Este tema permite visualizar la aplicación en un tema claro.
- frappe: Este tema permite visualizar la aplicación en un tema oscuro.
- macchiato: Este tema permite visualizar la aplicación en un tema oscuro, siendo un poco más oscuro al tema frappe.
- mocha: Este tema permite visualizar la aplicación en un tema oscuro, siendo un poco más oscuro al tema macchiato.
- sistema: Este tema permite elegir de manera personalizada el Tema Claro y el Tema Oscuro, que cambiará de acuerdo al tema del sistema. La lista de opciones contiene las opciones descritas anteriormente.
  
En segundo lugar, tenemos la opción de cambiar la ciudad que queremos saber el clima. Al presionar redirige a la pantalla de busqueda.
  
En último lugar, tenemos la opción de elegir de manera personalizada la zona horaria que queremos utilizar, siendo las opciones:

- La zona horaria de la ciudad elegida.
- La zona horaria del sistema.
- El Huso horario (en números).

<img src="img_docs/Screen%20configuracion.png" width=30% height=30% alt="Pantalla configuración del usuario.">

## 👥 Autores

- Abraham Mateo
- Dambrosio Valentina
- Fell Sebastián
