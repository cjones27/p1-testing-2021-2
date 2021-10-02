# Testing Proyecto 1: Minsweeper 💣

## Introducción
Se desarrolló el juego Minesweeper (Buscaminas) en el contexto del proyecto 1 del curso IIC3745 - Testing. 

El juego consta de un juego normal de Minesweeper de 9x9 (índices de 0 a 8) con todas las funcionalidades como descubrir casillas, marcar celdas, mapas aleatorios, ganar el juego y poder salir de el. Este programa fue construido en ruby y se juega a través de la consola. Se utilizó un patrón de Modelo Vista Controlador (MVC). Además, se desarrolló testeo de cobertura de líneas de código, unit testing, verificación de ofensas con rubocop e integracíon continua usando Travis-ci.


## Instalación

Para jugar al juego, primero se debe clonar el repositorio.
Después correr las gemas utilizas en el proyecto con
```
bundle install
```
Ahora ya se puede iniciar el juego con el siguiente comando en el root del proyecto
```
ruby src/main.rb
```

## Cómo jugar

Al inicio de la partida, el jugador se verá presentado con la vista mostrada en el [ejemplo](#ejemplo).
Para jugar, el jugador puede realizar una de las siguientes 3 acciones:

| Índice | Jugada | Descripción |
| ------ | ------ | ----------- |
| 1 | Unlock Square | Revela una celda, en caso de ser bomba termina el juego |
| 2 | Flag/Unflag  Square | Marca o desmarca una celda que uno cree que puede ser una bomba |
| 3 | Exit Game | Finaliza el juego y vuelve a la consola |

Si las opciones 1 o 2 son escogidas, se le solicitará al usuario poner primero un input X, que corresponde a la posición en el eje horizontal, y después un input Y que corresponde a la posición en el eje vertical.

Mientras el jugador no pierda, irá revelando cada vez más celdas hasta que no queden celdas sin bombas. En ese momento, el jugador va a haber ganado el juego.

## Ejemplo

Aquí podrás encontrar un [vídeo de prueba]().

A continuación se muestra un ejemplo de la vista del jugador:

```
  012345678
  ---------
0|?????????|
1|?????????|
2|?????????|
3|?????????|
4|?????????|
5|?????????|
6|?????????|
7|?????????|
8|?????????|
  ---------
Type number to choose action
1 Unlock Square
2 Flag/unflag Square
3 Exit Game 
```

