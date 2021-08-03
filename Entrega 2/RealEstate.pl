%Indica que o predicado custumer será alterado em tempo de execução
:- dynamic(custumer/3).

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

%custumer(nrCustumer, ageCustumer, occupationCustumer).
custumer(1010, 25, veterinario).
custumer(1011, 35, medico).
custumer(1012, 39, militar).
custumer(1013, 40, advogado).
custumer(2010, 45, advogado).
custumer(2011, 47, militar).
custumer(2012, 53, veterinario).
custumer(3010, 55, professor).
custumer(3011, 60, professor).
custumer(3012, 65, medico).

occupation(veterinario).
occupation(advogado).
occupation(professor).
occupation(medico).
occupation(militar).

%LoopThroughAllSellers
getSmallest([], A).
getSmallest(A, []) :- 
    getSmallest(A, A).
getSmallest([M|L], [H|T]) :- 
    isSmallest([M|L], H) -> getSalesBySeller(H, S),
    write('Vendedor(a) '),
    write(H), 
    write(' fez vendas no valor total de '), 
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
    write('Imobiliária '),
    write(H),
    write(' teve média de vendas de '),
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
    custumer(N, _, _),
    sale(I, _, _, N, _),
    write('\nCliente: '), write(N),
    write('\nImobiliária: '), write(I),
    nl, fail.

%getCustumerDetailsByNumber(nrCustumer)
getCustumerDetailsByNumber(N) :-
    custumer(N, A, O),
    write('\nCliente: '), write(N),
    write('\nIdade: '), write(A), 
    write('\nProfissão: '), write(O).

% %getPropertiesByRealEstate(realEstate)
getPropertiesSaledByRealEstate(R) :- sale(R,I,_,_,_), 
    write('\nImovel vendido: '), write(I), nl, fail.

% %getCustumersByOccupation(occupation)
getCustumersByOccupation(O) :- 
    custumer(C, _, O),
    write('\nCliente: '), write(C), 
    nl, fail.

%ListAllSellersByOrderOfSales
listSellerBySales :- 
    findall(A, seller(A), B),
    getSmallest(B, B), !.

%getTotalSaleValueForEachCompany
findTotalSales(F) :- 
    findall(F, realEstate(F), A),
    loop(A).

%Busca a venda por uma imobiliaria
getSalesByRealEstate(N, A) :-
    findall(S, sale(N,_,S,_,_), B),
	getSum(B,A).

%LoopThroughAllEstates
getBiggestValue([], A).
getBiggestValue(A, []) :- 
    getBiggestValue(A, A).
getBiggestValue([M|L], [H|T]) :- 
    isBiggestValue([M|L], H) -> getSalesByRealEstate(H, S),
    write('Imobiliária '),
    write(H), 
    write(' teve vendas no valor total de '), 
    write(S), nl,
    select(H, [M|L], C),
    getBiggestValue(C, T);
    getBiggestValue([M|L], T).

%VerifyIfIsTheSmallerOfTheList
isBiggestValue([],A).
isBiggestValue([H|T],A) :-
    getSalesByRealEstate(A,V),
    getSalesByRealEstate(H,D),
    
    isBiggestValue(T,A),
    V >= D.

%Lista as imobiliaria com maiores vendas
getRealEstateHighestSales(F) :- 
    findall(F, realEstate(F), A),
    getBiggestValue(A, A), !.

%Altera a idade de um cliente conforme o número do cliente
setCustumerAge(N) :-
    custumer(N, A, O),
    write('\nCliente: '),write(N),
    write('\nIdade: '),write(A),nl,
	write('\nDigite a idade que deseja alterar: '),read(I),nl,
    retract(custumer(N, A, O)),
    assert(custumer(N, I, O)).

%Altera a profissão de um cliente conforme o número do cliente
setCustumerOccupation(N) :-
    custumer(N, A, O),
    write('\nCliente: '),write(N),
    write('\nIdade: '),write(A),
    write('\nProfissão: '),write(O),nl,
	write('\nDigite a nova profissão: '),read(I),nl,
    retract(custumer(N, A, O)),
    assert(custumer(N, A, I)).

menu :- repeat,
    nl,
    write(' ###################IMOBILIÁRIAS##################'),nl,
    write('[1]. Listar todos clientes'),nl,
    write('[2]. Listar dados de um cliente'),nl,
    write('[3]. Listar todas as vendas de uma imobiliária'),nl,
    write('[4]. Listar clientes por profissão'),nl,
    write('[5]. Exibir preço média de vendas'),nl,
    write('[6]. Alterar idade de um cliente'),nl,
    write('[7]. Alterar profissão de um cliente'),nl,
    write('[8]. Listar imobiliárias com valores das vendas'),nl,
    write('[9]. Listar todos vendedores'),nl,
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

doit(6):- nl,
    write('Informe o número do cliente:'),nl,
    read(Choise),
    setCustumerAge(Choise).

doit(7):- nl,
    write('Informe o número do cliente:'),nl,
    read(Choise),
    setCustumerOccupation(Choise).

doit(8):- nl,
    getRealEstateHighestSales(R),
    write(R).

doit(9):- nl,
    listSellerBySales.

doit(0):- nl,
    write('Até logo e obrigado por usar nossos serviços!').