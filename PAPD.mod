# definição dos parâmetros

param P;
#cardinalidade do conjunto de professores

param D;
#cardinalidade do conjunto de disciplinas

param M{1..P}, >=0;
#recurso disponível para utilização do professor p

param Q{1..P, 1..D}, >=0;
# recurso consumido para alocar disciplina d para o professor p 

param S{1..P, 1..D}, >=0;
#custo de alocação da disciplina d ao professor p 

#definição das variáveis

var X{1..P, 1..D}, binary;
#x[p,d] = 1 significa que o professor p está associado a disciplina d

#restrições
minimize obj: sum{p in 1..P, d in 1..D} S[p,d] * X[p,d];
#minimizar o custo de associar um disciplina ao professor atendendo as suas preferências

s.t. R1{d in 1..D}: sum{p in 1..P} X[p,d] = 1;
#disciplina d deve ser associada a exatamente um professor

s.t. R2{p in 1..P}: sum{d in 1..D} Q[p,d] * X[p,d] <= M[p];
# o total de recursos consumido por todas as disciplinas associadas ao professor p não deve exceder a capacidade de disponibilidade dos professor

end;