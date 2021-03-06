%% aumento setea los valores de aumento de cada arma/armadura
aumento(espada_y_escudo, [20,20,20]).
aumento(baston, [0,30,30]).
aumento(espada_larga, [0,0,60]).
aumento(arco_y_flecha, [0,60,0]).
aumento(armadura_ligera, [20,40,0]).
aumento(armadura_completa, [60,0,0]).
aumento(armadura_normal, [40,20,0]).

%% defensaTotal calcula la defensa de un personaje + defensa agregada por el arma/armadura
defensaTotal(X,DT):- personaje(X,DP,_,_,W,A), aumento(A,[DA,_,_]), aumento(W,[DW,_,_]), plus(DA,DW,Y), plus(Y,DP,DT),!.

%% velocidadTotal calcula la velocidad de un personaje + velocidad agregada por el arma/armadura
velocidadTotal(X,VT):- personaje(X,_,VP,_,W,A), aumento(A,[_,VA,_]), aumento(W,[_,VW,_]), plus(VA,VW,Y), plus(Y,VP,VT),!.

%% fuerzaTotal calcula la fuerza de un personaje + fuerza agregada por el arma/armadura
fuerzaTotal(X,FT):- personaje(X,_,_,FP,W,_), aumento(W,[_,_,FW]), plus(FP,FW,FT),!.

%% numeroGolpes calcula en número de golpes que da un personaje usando la formula entregada
numeroGolpes(X,DE,NG):- fuerzaTotal(X,FT), velocidadTotal(X,VT), U is DE * 100, D is VT * FT, NG is U / D. 

%% pelea compara los NG de cada personaje, si X < Y, retorna X, si no, retorna Y (gracias a la segunda declaración)
pelea(X,Y,Z):- personaje(X, D, V, F, _, _), S is (D + V + F), S > 100, Z = personajeXincorrecto,!. 
pelea(X,Y,Z):- personaje(Y, D, V, F, _, _), S is (D + V + F), S > 100, Z = personajeYincorrecto,!. 
pelea(X,Y,Z):- defensaTotal(X,DX), defensaTotal(Y,DY), numeroGolpes(X,DY,GX), numeroGolpes(Y,DX,GY), GX < GY, Z = X,!.
pelea(X,Y,Z):- defensaTotal(X,DX), defensaTotal(Y,DY), numeroGolpes(X,DY,GX), numeroGolpes(Y,DX,GY), GY < GX, Z = Y,!.
pelea(X,Y,Z):- Z = empate,!.

%% declaración de ambos personajes
personaje(theViper, 40, 40, 20, baston, armadura_ligera).
personaje(theMountain, 30, 10, 60, espada_larga, armadura_completa).