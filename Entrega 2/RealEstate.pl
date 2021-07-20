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

%LoopThroughAllSellers
getSmallest([], A).
getSmallest(A, []) :- 
    getSmallest(A, A).
getSmallest([M|L], [H|T]) :- 
    isSmallest([M|L], H) -> getSalesBySeller(H, S),
    write(H), 
    write('   '), 
    write(S), nl,
    select(H, [M|L], C),
    getSmallest(C, T);
    getSmallest([M|L], T).

%VerifyIfIsTheSmallerOfTheList
isSmallest([],A).
isSmallest([H|T],A) :-
    getSalesBySeller(A,V),
    getSalesBySeller(H,D),
    
    isSmallest(T,A),
    V =< D.

%ReturnTheTotalSalesOfASeller
getSalesBySeller(S,V) :- 
    findall(P,sale(_,_,P,_,S),A),
    getSum(A,V).

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

%ListAllSellersByOrderOfSales
listSellerBySales :- 
    findall(A, seller(A), B),
    getSmallest(B, B).

%getTotalSaleValueForEachCompany
findTotalSales(F) :- 
    findall(F, realEstate(F), A),
    loop(A).

%Busca a venda por uma imobiliaria
getSalesByRealEstate(N, A) :-
    findall(S, sale(N,_,S,_,_), B),
	getSum(B,A).

%loop para percorrer todas as imobiliarias
loopSalesByRE([]).
loopSalesByRE([H|T]) :-
    getSalesByRealEstate(H, A),
    write(H),
    write('	'),
    write(A), nl,
    loopSalesByRE(T).

%Lista as imobiliaria com maiores vendas
getRealEstateHighestSales(F) :- 
    findall(F, realEstate(F), A),
    loopSalesByRE(A).

menu :- repeat,
    nl,
    write(' ###################IMOBILIÁRIAS##################'),nl,
    write('[1]. Listar todos clientes'),nl,
    write('[2]. Listar dados de um cliente'),nl,
    write('[3]. Listar todas as vendas de uma imobiliária'),nl,
    write('[4]. Listar clientes por profissão'),nl,
    write('[5]. Exibir preço média de vendas'),nl,
    write('[6]. Alterar idade de um cliente'),nl,
    write('[7]. Listar imobiliárias com valores das vendas'),nl,
    write('[8]. Listar todos vendedores'),nl,
    write('[0]. Sair'),nl,
    write(' #################################################'),nl,
    write('Faça sua escolha:'),nl,
    read(Option),
    doit(Option),Option=0, !.

doit(1):- nl,
    getCustumers.

doit(2):- nl,
    write('Informe o numero do cliente:'),nl,
    read(Choise),
    getCustumerDetailsByNumber(Choise).

doit(3):- nl,
    write('Informe o nome da imobiliária:'),nl,
    read(Choise),
    getPropertiesSaledByRealEstate(Choise).

doit(4):- nl,
    write('Informe a ocupação:'),nl,
    read(Choise),
    getCustumersByOccupation(Choise).

doit(5):- nl,
    findTotalSales(M),
    write(M).

doit(7):- nl,
    getRealEstateHighestSales(R),
    write(R).

doit(8):- nl,
    listSellerBySales.

doit(0):- nl,
    write('Até logo e obrigado por usar nossos serviços!').