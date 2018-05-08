# definição dos parâmetros

param P;
#cardinalidade do conjunto de professores

param T;
#cardinalidade do conjunto de turmas

param H;
#cardinalidade do conjunto de horários

param D;
#cardinalidade do conjunto de dias

param PS{1..P,1..D};
#peso ref. à preferência de trabalho do professor p no dia d

param Q{1..P,1..T};
#quantidade de aulas que o professor p deverá lecionar na turma p

param DP{1..H,1..T};
# Disponibilidade da turma t no horário h;

# Definição das variáveis

var Z{1..P,1..D}, binary;
#se o professor p trabalha no dia d

var X{1..P,1..T,1..H}, binary;
#se o professor p trabalha na turma t no horário h

var Y{1..P,1..T,1..D}, binary;
#se o professor p trabalha na turma t no dia d

minimize fo: sum{p in 1..P, d in 1..D}PS[p,d]*Z[p,d];
#Função objetiva - Minimizar os dias em que o professor deverá ir lecionar atendendo as suas preferências

#Restrições

s.t. R1{t in 1..T, h in 1..H}: sum{p in 1..P}X[p,t,h] <= 1;

s.t. R2{p in 1..P, h in 1..H}: sum{t in 1..T}X[p,t,h] <= 1;

s.t. R3{p in 1..P, t in 1..T}: sum{h in 1..H}X[p,t,h] * DP[h,t] = Q[p,t];

s.t. R4{t in 1..T, p in 1..P, d in 1..D}: sum{h in ((d*4)-3)..(d*4)}X[p,t,h] <= Y[p,t,d];

s.t. R5{t in 1..T, p in 1..P, d in 1..D: d<5}: Y[p,t,d] + Y[p,t,d+1] <= 1;

s.t. R6{t in 1..T, p in 1..P}: sum{d in 1..D}Y[p,t,d] = Q[p,t];

s.t. R7{t in 1..T, p in 1..P, d in 1..D}: Y[p,t,d] <= Z[p,d];


end;



