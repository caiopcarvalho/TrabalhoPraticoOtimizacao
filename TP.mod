# definição dos parâmetros

param P;
#cardinalidade do conjunto de professores

param T;
#cardinalidade do conjunto de turmas

param H;
#cardinalidade do conjunto de horários

param D;
#cardinalidade do conjunto de dias

param S;
#quantidade de disciplinas

param PS{1..P,1..D};
#peso ref. à preferência de trabalho do professor p no dia d

param Q{1..P,1..T};
#quantidade de aulas que o professor p deverá lecionar na turma t

param DP{1..H,1..T};
#disponibilidade da turma t no horário h;

param F{1..S,1..T};
#parametro binário que informa se a disciplina s pertence a turma t

param ch{1..S};
#carga horária da disciplina

#definição das variáveis

var Z{1..P,1..D}, binary;
#se o professor p trabalha no dia d

var X{1..P,1..T,1..H}, binary;
#se o professor p trabalha na turma t no horário h

var Y{1..P,1..T,1..D}, binary;
#se o professor p trabalha na turma t no dia d

var W{1..P,1..S}, binary;
#se o professor p leciona a disciplina s

minimize fo: sum{p in 1..P, d in 1..D}PS[p,d]*Z[p,d];
#Função objetiva - Minimizar os dias em que o professor deverá ir lecionar atendendo as suas preferências

#Restrições

#evita que dois professores possam dar aulas para uma mesma turma em um mesmo horário
s.t. R1{t in 1..T, h in 1..H}: sum{p in 1..P}X[p,t,h] <= 1;

#evita que um professor seja alocado a mais de uma turma em um mesmo horário.
s.t. R2{p in 1..P, h in 1..H}: sum{t in 1..T}X[p,t,h] <= 1;

#faz com que a carga horária do professor seja cumprida no turno correto
s.t. R3{p in 1..P, t in 1..T}: sum{h in 1..H}X[p,t,h] * DP[h,t] = Q[p,t];

#faz com que o professor não dê duas aulas para a mesma turma no mesmo dia
s.t. R4{t in 1..T, p in 1..P, d in 1..D}: sum{h in ((d*4)-3)..(d*4)}X[p,t,h] <= Y[p,t,d];

#fazem com que o professor não dê aula para a mesma turma dois dias seguidos
s.t. R5{t in 1..T, p in 1..P, d in 1..D: d<5}: Y[p,t,d] + Y[p,t,d+1] <= 1;

s.t. R6{t in 1..T, p in 1..P}: sum{d in 1..D}Y[p,t,d] = Q[p,t];

#faz com que o professor só possa dar aula para uma turma em dia que dá aula
s.t. R7{t in 1..T, p in 1..P, d in 1..D}: Y[p,t,d] <= Z[p,d];

#faz com que toda disciplina tenha exatamente um professor
s.t. R8{s in 1..S}: sum{p in 1..P}W[p,s] = 1;

#faz com que o total de disciplinas de um professor em cada turma seja igual a Q
s.t. R9{t in 1..T, p in 1..P}: sum{s in 1..S}(W[p,s]*F[s,t]*ch[s]) = Q[p,t];



end;



