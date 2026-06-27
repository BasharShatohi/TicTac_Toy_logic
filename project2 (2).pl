fixed_cell(1,3,'X').
fixed_cell(2,3,'X').
fixed_cell(3,1,'X').
fixed_cell(5,6,'X').
fixed_cell(6,1,'O').
fixed_cell(6,5,'O').
fixed_cell(3,6,'X').
fixed_cell(4,3,'O').
fixed_cell(5,2,'X').
solve_cell(1,1,'O').
solve_cell(1,2,'O').
solve_cell(1,4,'O').
solve_cell(1,5,'X').
solve_cell(1,6,'O').
solve_cell(2,1,'O').
solve_cell(2,2,'X').
solve_cell(2,4,'O').
solve_cell(2,5,'X').
solve_cell(2,6,'O').
solve_cell(3,2,'O').
solve_cell(3,3,'O').
solve_cell(3,4,'X').
solve_cell(3,5,'O').
solve_cell(4,1,'X').
solve_cell(4,2,'O').
solve_cell(4,4,'X').
solve_cell(4,5,'X').
solve_cell(4,6,'O').
solve_cell(5,1,'O').
solve_cell(5,3,'X').
solve_cell(5,4,'O').
solve_cell(5,5,'O').
solve_cell(6,2,'X').
solve_cell(6,3,'O').
solve_cell(6,4,'X').
solve_cell(6,6,'X').
cell(X,Y,S):- fixed_cell(X,Y,S); solve_cell(X,Y,S).
/***********************************************************************************************************/
show_row(X,L):-findall(S,cell(X,_,S),Cells),length(Cells,NumCols),help_show(X,NumCols,[],L).
help_show(_,0,A,A):-!.
help_show(X,N,A,L):-cell(X,N,S),N1 is N-1,help_show(X,N1,[S|A],L).
/***********************************************************************************************************/
count_X_OR_O_in_row(S,R,N):-findall(S,cell(R,_,S),Symbols),length(Symbols,N).
/***********************************************************************************************************/
equality(R1,R2):-findall(S,cell(R1,_,S),R1cells),findall(S,cell(R2,_,S),R2cells),R1cells=R2cells.
/******************************************************1111111111111*****************************************************/
all_cells_filled:-forall(cell(_, _,Char),member(Char,['O','X'])).
/******************************************************2222222222222*****************************************************/
no_tripple:-(no_tripple_loop(6)->true;fail).
no_tripple_loop(0).
no_tripple_loop(Number):-Number>0,no_tripple_rows(Number,1,[]),no_tripple_columns(1,Number,[]),Number1 is Number-1,no_tripple_loop(Number1).
no_tripple_rows(_,7,_).
no_tripple_rows(Number,ColumN,List):-ColumN=<6,cell(Number,ColumN,X),append(List,[X],NewList),ColumnN1 is ColumN+1,(consecutive(NewList)->writeln('Warning:There is more than 2(X) or 2()O in one row'),fail;no_tripple_rows(Number,ColumnN1,NewList)).
no_tripple_columns(7,_,_).
no_tripple_columns(RowN,Number,List):-RowN=<6,cell(RowN,Number,X),append(List,[X],NewList),RowN1 is RowN+1,(consecutive(NewList)-> writeln('Warning:There is more than 2(X) or 2(O) in one column'),fail;no_tripple_columns(RowN1,Number,NewList)).
consecutive([X,X,X|_]).
consecutive([_|T]):-consecutive(T).
/*****************************************************33333333333333****************************************************/
count_x_and_o_in_row(Row,XCount,OCount):-include(=('X'),Row,Xs),include(=('O'),Row,Os),length(Xs,XCount),length(Os,OCount).
symbol_count_correct:-findall(Row,(between(1,6,X),findall(S,cell(X,_,S),Row)),Rows),maplist(equal_x_and_o_in_row,Rows).
equal_x_and_o_in_row(Row):-count_x_and_o_in_row(Row,XCount,OCount),XCount =:= OCount,length(Row,RowLength),XCount+OCount=:=RowLength.


count_x_and_o_in_column(Row,XCount,OCount):-include(=('X'),Row,Xs),include(=('O'),Row,Os),length(Xs,XCount),length(Os,OCount).
symbol_count_correct:-findall(Row,(between(1,6,X),findall(S,cell(_,X,S),Row)),Rows),maplist(equal_x_and_o_in_row,Rows).
equal_x_and_o_in_column(Row):-count_x_and_o_in_row(Row,XCount,OCount),XCount =:= OCount,length(Row,RowLength),XCount+OCount=:=RowLength.
/*****************************************************444444444444444***************************************************/
no_repeat:-(no_repeat_rows_inner_loop(1,1,[],[])->true;writeln('There is 2 or more identical rows'),false),(no_repeat_columns_inner_loop(1,1,[],[])->true;writeln('There is 2 or more identical columns'),false),
no_repeat_rows_inner_loop(_, 7, _, _).
no_repeat_rows_inner_loop(7, _, _, _).
no_repeat_rows_inner_loop(N, M, List, List2) :-M =< 6,N =< 6,cell(N,M,X),append(List, [X], NewList),M1 is M + 1,(M = 6-> append(List2, [NewList], NewList2),(N = 6 -> unique_lists(NewList2); true),N1 is N + 1,no_repeat_rows_inner_loop(N1, 1, [],NewList2);no_repeat_rows_inner_loop(N, M1, NewList, List2)).
no_repeat_columns_inner_loop(_, 7, _, _).
no_repeat_columns_inner_loop(7, _, _, _).
no_repeat_columns_inner_loop(N, M, List, List2) :-M =< 6,N =< 6,cell(N,M,X),append(List, [X], NewList),N1 is N + 1,(N = 6-> append(List2, [NewList], NewList2),(M = 6 -> unique_lists(NewList2); true),M1 is M + 1,no_repeat_columns_inner_loop(1, M1, [], NewList2);no_repeat_columns_inner_loop(N1, M, NewList, List2)).
unique_lists(Lists) :- all_different(Lists).
all_different([]).
all_different([H|T]) :- maplist(dif(H),T), all_different(T).
/**********************************************Solved******************************************************/
solved:-all_cells_filled,no_tripple,symbol_count_correct,no_repeat.
/*********************************************************************************************************/
:- dynamic fixed_cell/3.
build_patch(N):-findall(fixed_cell(Row,Col,Symbol),fixed_cell(Row,Col,Symbol),Fixed),sort(1,@=<,Fixed,SortedFixed),build_rows(N,N,SortedFixed,Rows),maplist(writeln,Rows),nl.
build_rows(0,_,_,[]):-!.
build_rows(N,Size,Fixed,[Row|Rows]):-build_columns(Size,N,Fixed,Row),N1 is N-1,build_rows(N1,Size,Fixed,Rows).
build_columns(0,_,_,[]):-!.
build_columns(Size,Row,Fixed,[Cell|Cells]):-(member(fixed_cell(Row,Size,Symbol),Fixed)->format(atom(SymbolAtom),'| ~w |',[Symbol]),atom_concat(SymbolAtom,'',Cell);atom_conca('|---|','',Cell)),Size1 is Size-1,build_columns(Size1,Row,Fixed,Cells).
%-------------------------------------------------------------------------FIXED CELLS-----------------------------------------------------------------------------------
new_patch :-
    retractall(fixed_cell(_, _,_)),
    assertz(fixed_cell(1, 3, 'x')),
    assertz(fixed_cell(2, 3, 'x')),
    assertz(fixed_cell(3, 1, 'x')),
    assertz(fixed_cell(3, 6, 'x')),
    assertz(fixed_cell(4, 3, 'o')),
    assertz(fixed_cell(5, 2, 'x')),
    assertz(fixed_cell(5, 6, 'x')),
    assertz(fixed_cell(6, 1, 'o')),
    assertz(fixed_cell(6, 5, 'o')),
    build_patch(6).
%-------------------------------------------------------------------------INSERT METHOD ----------------------------------------------------------------------------
insert_symbol(Row,Col,Symbol):-(fixed_cell(Row,Col,_)->write('Error: cell is already fixed'),nl;assertz(fixed_cell(Row,Col,Symbol)),build_patch(6)).
























