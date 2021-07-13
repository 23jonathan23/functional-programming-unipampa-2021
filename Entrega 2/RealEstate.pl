
%getTotalSaleValueForEachCompany
findTotalSales :- 
    findall(F, realEstate(F), A),
    loop(A).

%loopParaCadaEmpresa
loop([]).
loop([H|T]) :- 
    getAverage(H, A),
    write(H),
    write('  '),
    write(A), nl,
    loop(T).

%PegaAMediaDeUmaEmpresa
getAverage(N, A) :- 
    getList(N, B, L),
    A is B / L.

%PegaAListOValorDaSomaEAQuantidade
getList(N, A, L) :-
    findall(S, sale(N,_,S,_,_), B),
    length(B, L),
	getSum(B,A).

%RetornaASoma
getSum([],0).
getSum([H|T], S) :- getSum(T, R), S is R + H.

realEstate(alegrete).
realEstate(baitachao).
realEstate(ibirapuita).

% sale(realEstate, housingDetails, housingPrice, nrCustumer, saller)
sale(alegrete, 'Casa 3 quartos', 300000, 1010, maria).
sale(alegrete, 'Apartamento 1 quarto', 100000, 1010, maria).
sale(baitachao, 'Casa 3 quartos', 700000, 2010, paulo).
sale(ibirapuita, 'Apartamento 1 quarto', 130000, 3010, ana).
sale(ibirapuita, 'Casa 1 quarto', 220000, 3011, jose).
sale(alegrete, 'Apartamento 3 quartos', 500000, 1011, maria).
sale(ibirapuita, 'Casa 2 quartos', 250000, 3012, lucas).
sale(ibirapuita, 'Apartamento 2 quartos', 140000, 3012, lucas).
sale(baitachao, 'Apartamento 2 quartos', 250000, 2011, marisa).
sale(alegrete, 'Apartamento 2 quartos', 300000, 1012, rosa).
sale(baitachao, 'Casa 2 quartos', 260000, 2012, paulo).
sale(baitachao, 'Casa 1 quarto', 150000, 2012, paulo).
sale(alegrete, 'Apartamento 3 quartos', 650000, 1013, miguel).
sale(alegrete, 'Apartamento 1 quarto', 145000, 1013, miguel).
sale(alegrete, 'Apartamento 2 quartos', 160000, 1013, miguel).

seller(maria).
seller(paulo).
seller(ana).
seller(jose).
seller(lucas).
seller(marisa).
seller(rosa).
seller(miguel).

nrCustumer(1010).
nrCustumer(1011).
nrCustumer(1012).
nrCustumer(1013).
nrCustumer(2010).
nrCustumer(2011).
nrCustumer(2012).
nrCustumer(3010).
nrCustumer(3011).
nrCustumer(3012).

age(25).
age(35).
age(39).
age(40).
age(45).
age(47).
age(53).
age(55).
age(60).
age(65).

occupation(veterinario).
occupation(advogado).
occupation(professor).
occupation(medico).
occupation(militar).

% occupationCustumer(numberCustumer, occupation)
occupationCustumer(1010, veterinario).
occupationCustumer(1011, medico).
occupationCustumer(1012, militar).
occupationCustumer(1013, advogado).
occupationCustumer(2010, advogado).
occupationCustumer(2011, militar).
occupationCustumer(2012, veterinario).
occupationCustumer(3010, professor).
occupationCustumer(3011, professor).
occupationCustumer(3012, medico).

% ageCustumer(numberCustumer, age)
ageCustumer(1010, 55).
ageCustumer(1011, 53).
ageCustumer(1012, 40).
ageCustumer(1013, 65).
ageCustumer(2010, 60).
ageCustumer(2011, 45).
ageCustumer(2012, 39).
ageCustumer(3010, 25).
ageCustumer(3011, 35).
ageCustumer(3012, 47).

%query
%getCustumers
getCustumers :- 
    nrCustumer(N), 
    write('\nCliente: '), write(N), 
    nl, fail.

%getCustumerDetailsByNumber(nrCustumer)
getCustumerDetailsByNumber(N) :-
    ageCustumer(N,A),
    occupationCustumer(N,O),
    write('\nCliente: '), write(N),
    write('\nIdade: '), write(A), 
    write('\nProfissão: '), write(O).

% %getPropertiesByRealEstate(realEstate)
getPropertiesSaledByRealEstate(R) :- sale(R,I,_,_,_), 
    write('\nImovel vendido: '), write(I), nl, fail.

% %getCustumersByOccupation(occupation)
getCustumersByOccupation(O) :- 
    occupationCustumer(C,O), 
    write('\nCliente: '), write(C), 
    nl, fail.