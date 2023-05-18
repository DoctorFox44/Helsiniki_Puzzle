grid_build(N,M):-  buildh(N,M,N).

buildh(_,[],0).
buildh(N,[H|T],Num):-
					Num>0,
					length(L,N),
					H = L,
					N1 is Num-1,
					buildh(N,T,N1).
grid_gen(N,M):- grid_build(N,M1),
				gh(N,M,M1).
gh(_,[],[]).
gh(N,[H|T],[X|Xs]):- randList(N,X),
					H = X,
					gh(N,T,Xs).

randList(_,[]).
randList(N,[H|T]):- N1 is N+1,
					random(1,N1,X),
					H = X,
					randList(N,T).
num_gen(L,L,[L|[]]).
num_gen(F,L,[F|T]):- 
					F<L,
					F1 is F+1,
					num_gen(F1,L,T).
gh1(_,[],0).
gh1(N,[H|T],Num):-   length(L,N),
					randList(N,L),
					H = L,
					Num1 is Num-1,
					gh1(N,T,Num1).
check_num_grid([H|T]):-	flatten([H|T],F),
					max_list(F,Max),
					length(H,N),
					Max=<N,
					check_g(F,Max,1,F).
check_g(_,Max,Max,_).
check_g([N|_],Max,N,G):-
				   N1 is N+1,
				   check_g(G,Max,N1,G).
check_g([H|T],Max,N,G):- H\=N,
				   check_g(T,Max,N,G).