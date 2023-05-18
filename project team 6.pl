grid_build(N,M):-  buildh(N,M,N).

buildh(_,[],0).
buildh(N,[H|T],Num):-
					Num>0,
					length(L,N),
					H = L,
					N1 is Num-1,
					buildh(N,T,N1).
randi([],_).
randi(L,L1):-L=[H|T],member(H,L1),randi(T,L1).
randgrid([],_).
randgrid([L|T],L1):- randi(L,L1),randgrid(T,L1).
grid_gen(N,M):- grid_build(N,M1),num_gen(1,N,L1),randgrid(M1,L1),M=M1.

num_gen(L,L,[L|[]]).
num_gen(F,L,[F|T]):- 
					F<L,
					F1 is F+1,
					num_gen(F1,L,T).
check_num_grid([H|T]):-	flatten([H|T],F),
					max_list(F,Max),
					length(H,N),
					Max=<N,
					check_g(F,Max,1,F),!.
check_g(_,Max,Max,_).
check_g([N|_],Max,N,G):-
				   N1 is N+1,
				   check_g(G,Max,N1,G).
check_g([H|T],Max,N,G):- H\=N,
				   check_g(T,Max,N,G).

check_pl([],[]).
check_pl([H|T],[H1|T1]):- H1\=H,
						  check_pl(T,T1).
acceptable_permutation(L,R):- permutation(L,L1),
							  check_pl(L,L1),
							  R = L1.
reverseall([],[]).
reverseall([H|T],[H1|T1]):- reverse(H,H1),
							reverseall(T,T1).
listotll([],_,[]).
listotll([H|T],[H1|T1],[H2|T2]):- H2 = [H|H1],
						 listotll(T,T1,T2).
trans(L,R):-length(L,N),emptylist(N,C),
			changetocolumn(L,C,R).
changetocolumn([],C,R):-reverseall(C,R).						 
changetocolumn([H|T],C,C1):-  listotll(H,C,C2),
						   changetocolumn(T,C2,C1).
emptylist(0,[]).
emptylist(N,[H|T]):- N>0,H = [],
					N1 is N-1,
					emptylist(N1,T).
acceptable_distribution(L):- trans(L,R),
							checkRL(L,R).
checkRL([],[]).
checkRL([H|T],[H1|T1]):- \+ checkEq(H,H1),
						checkRL(T,T1).
checkEq([],[]).
checkEq([H|T],[H1|T1]):-H=H1,checkEq(T,T1).
check_mem([],_).
check_mem([H|T],L2):- member(H,L2),check_mem(T,L2).
row_col_match(L):- acceptable_distribution(L),
					trans(L,R),check_pl(L,R),check_mem(L,R).
distinct_rows([]).
distinct_rows([H|T]):- \+ member(H,T),distinct_rows(T).

distinct_columns(M):-trans(M,M1),distinct_rows(M1).

helsinki(N,G):- grid_gen(N,G),check_num_grid(G),acceptable_distribution(G),row_col_match(G),
distinct_rows(G),distinct_columns(G).
