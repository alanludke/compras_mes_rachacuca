
blusa(amarela).
blusa(azul).
blusa(branca).
blusa(verde).
blusa(vermelha).

nome(aline).
nome(carol).
nome(fernanda).
nome(juliana).
nome(natalia).

esqueceu(amaciante).
esqueceu(frutas).
esqueceu(leite).
esqueceu(pao).
esqueceu(presunto).

pagamento(cheque).
pagamento(credito).
pagamento(debito).
pagamento(dinheiro).
pagamento(vale).

foicom(filho).
foicom(irma).
foicom(mae).
foicom(marido).
foicom(namorado).

carro(crossover).
carro(hatch).
carro(pickup).
carro(sedan).
carro(suv).

%X está à ao lado de Y
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).
                       
%X está à esquerda de Y (em qualquer posiçao à esquerda)
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X), 
                        nth0(IndexY,Lista,Y), 
                        IndexX < IndexY.
                        
%X está à direita de Y (em qualquer posiçao à direita)
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista). 

%X está no canto se ele e o primeiro ou o último da lista
noCanto(X,Lista) :- last(Lista,X).
noCanto(X,[X|_]).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

solucao(ListaSolucao) :- 

    ListaSolucao = [
        caixa(Blusa1, Nome1, Esqueceu1, Pagamento1, FoiCom1, Carro1),
        caixa(Blusa2, Nome2, Esqueceu2, Pagamento2, FoiCom2, Carro2),
        caixa(Blusa3, Nome3, Esqueceu3, Pagamento3, FoiCom3, Carro3),
        caixa(Blusa4, Nome4, Esqueceu4, Pagamento4, FoiCom4, Carro4),
        caixa(Blusa5, Nome5, Esqueceu5, Pagamento5, FoiCom5, Carro5)
    ],

    %A mulher que esqueceu o Amaciante está exatamente à esquerda da que foi dirigindo um Sedan.
    aEsquerda(caixa(_, _, amaciante, _, _, _), caixa(_, _, _, _, _, sedan), ListaSolucao),
    aoLado(caixa(_, _, amaciante, _, _, _), caixa(_, _, _, _, _, sedan), ListaSolucao),

    %Quem foi num Crossover está exatamente à direita de quem vai pagar no cartao de Debito.
    aDireita(caixa(_, _, _, _, _, crossover), caixa(_, _, _, debito, _, _), ListaSolucao),
    aoLado(caixa(_, _, _, _, _, crossover), caixa(_, _, _, debito, _, _), ListaSolucao),

    %A mulher que foi com o Namorado foi fazer as compras dirigindo uma Pickup.
    member(caixa(_, _, _, _, namorado, pickup), ListaSolucao),

    %A dona do Sedan está exatamente à esquerda da dona do suv.
    aEsquerda(caixa(_, _, _, _, _, sedan), caixa(_, _, _, _, _, suv), ListaSolucao),
    aoLado(caixa(_, _, _, _, _, sedan), caixa(_, _, _, _, _, suv), ListaSolucao),

    %Quem esqueceu o Pao foi com a Mae.
    member(caixa(_, _, pao, _, mae, _), ListaSolucao),

    %aline está ao lado da mulher que foi ao supermercado com o Filho.
    aoLado(caixa(_, aline, _, _, _, _), caixa(_, _, _, _, filho, _), ListaSolucao),

    %Em um dos caixas da pontas está a mulher que foi ao supermercado com o Marido.
    noCanto(caixa(_, _, _, _, marido, _),ListaSolucao),

    %No caixa da quarta posiçao está a mulher que vai pagar com Cheque.
    %A mulher da blusa Azul está no quarto caixa.
    %Blusa4 = azul.
    %Pagamento4 = cheque.

    ListaSolucao = [
        caixa(_, _, _, _, _, _),
        caixa(_, _, _, _, _, _),
        caixa(_, _, _, _, _, _),
        caixa(azul, _, _, cheque, _, _),
        caixa(_, _, _, _, _, _)
    ],

    %Quem vai pagar com Dinheiro está em um dos caixas das pontas.
    noCanto(caixa(_, _, _, dinheiro, _, _),ListaSolucao),

    %A mulher que vai pagar com oc cartao de Debito está exatamente à esquerda de quem vai pagar com Vale.
    aEsquerda(caixa(_, _, _, debito, _, _), caixa(_, _, _, vale, _, _), ListaSolucao),
    aoLado(caixa(_, _, _, debito, _, _), caixa(_, _, _, vale, _, _), ListaSolucao),

    %juliana foi ao supermercado com a Mae.
    member(caixa(_, juliana, _, _, mae, _), ListaSolucao),

    %Quem esqueceu o Presunto vai pagar com o cartao de Debito.
    member(caixa(_, _, presunto, debito, _, _), ListaSolucao),

    %A mulher da blusa Amarela está ao lado da que esqueceu as Frutas.
    aoLado(caixa(amarela, _, _, _, _, _), caixa(_, _, frutas, _, _, _), ListaSolucao),

    %Quem esqueceu o Pao foi ao supermercado dirigindo um suv.
    member(caixa(_, _, pao, _, _, suv), ListaSolucao),

    %fernanda foi para o supermercado com o Filho.
    member(caixa(_, fernanda, _, _, filho, _), ListaSolucao),

    %carol está exatamente à direita da mulher que esqueceu o Amaciante.
    aDireita(caixa(_, carol, _, _, _, _), caixa(_, _, amaciante, _, _, _), ListaSolucao),
    aoLado(caixa(_, carol, _, _, _, _), caixa(_, _, amaciante, _, _, _), ListaSolucao),

    %A mulher da blusa Verde está em algum lugar à esquerda da de blusa Vermelha.
    aEsquerda(caixa(verde, _, _, _, _, _), caixa(vermelha, _, _, _, _, _), ListaSolucao),

    %Quem esqueceu as Frutas está ao lado de quem esqueceu o Presunto.
    aoLado(caixa(_, _, frutas, _, _, _), caixa(_, _, presunto, _, _, _), ListaSolucao),

    %A mulher da blusa Amarela está em algum lugar entre a que foi com o Marido e a de blusa Verde, nessa ordem.
    %Sabemos que a mulher de blusa verde esta a esquerda da mulher de blusa vermelha entao a de blusa amarela esta a esquerda da verde
    aEsquerda(caixa(amarela, _, _, _, _, _), caixa(verde, _, _, _, _, _), ListaSolucao),
    aDireita(caixa(amarela, _, _, _, _, _), caixa(_, _, _, _, marido, _), ListaSolucao),

    %Quem vai pagar com Dinheiro está ao lado de quem foi de Sedan ao supermercado.
    aoLado(caixa(_, _, _, dinheiro, _, _), caixa(_, _, _, _, _, sedan), ListaSolucao),

    %Testa todas as possibilidades...
    blusa(Blusa1), blusa(Blusa2), blusa(Blusa3), blusa(Blusa4), blusa(Blusa5),
    todosDiferentes([Blusa1, Blusa2, Blusa3, Blusa4, Blusa5]),
    
    nome(Nome1), nome(Nome2), nome(Nome3), nome(Nome4), nome(Nome5),
    todosDiferentes([Nome1, Nome2, Nome3, Nome4, Nome5]),
    
    esqueceu(Esqueceu1), esqueceu(Esqueceu2), esqueceu(Esqueceu3), esqueceu(Esqueceu4), esqueceu(Esqueceu5),
    todosDiferentes([Esqueceu1, Esqueceu2, Esqueceu3, Esqueceu4, Esqueceu5]),
    
    pagamento(Pagamento1), pagamento(Pagamento2), pagamento(Pagamento3), pagamento(Pagamento4), pagamento(Pagamento5),
    todosDiferentes([Pagamento1, Pagamento2, Pagamento3, Pagamento4, Pagamento5]),
    
    foicom(FoiCom1), foicom(FoiCom2), foicom(FoiCom3), foicom(FoiCom4), foicom(FoiCom5),
    todosDiferentes([FoiCom1, FoiCom2, FoiCom3, FoiCom4, FoiCom5]),

    carro(Carro1), carro(Carro2), carro(Carro3), carro(Carro4), carro(Carro5),
    todosDiferentes([Carro1, Carro2, Carro3, Carro4, Carro5]).
    
% Formata a lista de Pessoas de uma forma mais parecida com o layout do rachacuca
exibir_lista([caixa(Blusa1,Nome1,Esqueceu1,Pagamento1,FoiCom1,Carro1),
              caixa(Blusa2,Nome2,Esqueceu2,Pagamento2,FoiCom2,Carro2),
              caixa(Blusa3,Nome3,Esqueceu3,Pagamento3,FoiCom3,Carro3),
              caixa(Blusa4,Nome4,Esqueceu4,Pagamento4,FoiCom4,Carro4),
              caixa(Blusa5,Nome5,Esqueceu5,Pagamento5,FoiCom5,Carro5)]):-
    write('\n              -----------------------------------------------------------\n             |  Caixa 1  |  Caixa 2  |  Caixa 3  |  Caixa 4  |  Caixa 5  |'),
    format("~n|~`-t~73||~n"),
    format("|Blusa~t~13||~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~n", 
            [Blusa1, Blusa2, Blusa3, Blusa4, Blusa5]),
    format("|~`-t~73||~n"),
    format("|Nome~t~13||~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~n", 
            [Nome1, Nome2, Nome3, Nome4, Nome5]),
    format("|~`-t~73||~n"),
    format("|Esqueceu~t~13||~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~n", 
            [Esqueceu1, Esqueceu2, Esqueceu3, Esqueceu4, Esqueceu5]),
    format("|~`-t~73||~n"),
    format("|Pagamento~t~13||~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~n", 
            [Pagamento1, Pagamento2, Pagamento3, Pagamento4, Pagamento5]),
    format("|~`-t~73||~n"),
    format("|FoiCom~t~13||~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~n", 
            [FoiCom1, FoiCom2, FoiCom3, FoiCom4, FoiCom5]),
    format("|~`-t~73||~n"),
    format("|Carro~t~13||~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~t~a~t~12+|~n", 
            [Carro1, Carro2, Carro3, Carro4, Carro5]),
    format("|~`-t~73||~n~n~n").