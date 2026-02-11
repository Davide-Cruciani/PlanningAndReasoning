:- dynamic controller/1.

:- discontiguous
    fun_fluent/1,
    rel_fluent/1,
    proc/2,
    causes_true/3,
    causes_false/3.

cache(_) :- fail.

max_rank(4).
rank(N) :-  between(1, M, N), max_rank(M).
color(C) :- member(C, [red, black]).

card(C) :- member(C,
    [
        h1,h2,h3,h4,
        d1,d2,d3,d4
    ]).

tableau(T) :- member(T, [t1,t2]).
foundation(F) :- member(F, [b1,b2]).
suit(S) :- member(S, [diamonds,  hearts]).

card_suit(C, diamonds) :- member(C,[d1,d2,d3,d4]).
card_suit(C, hearts) :- member(C,[h1,h2,h3,h4]).

card_color(C, red) :- member(C, [h1,h2,h3,h4]).
card_color(C, black) :- member(C,[d1,d2,d3,d4]).


card_rank(C, 1) :- member(C, [d1, h1]).
card_rank(C, 2) :- member(C, [d2, h2]).
card_rank(C, 3) :- member(C, [d3, h3]).
card_rank(C, 4) :- member(C, [d4, h4]).

succ(1,2).
succ(2,3).
succ(3,4).

can_tab(C1, C2) :-
    card_rank(C1, R1),
    card_rank(C2, R2),
    succ(R1, R2),
    card_color(C1, CR1),
    card_color(C2, CR2),
    CR1 \= CR2. 

%%%%% Compatible in foundation
can_fun(C1, C2) :-
    card_rank(C1, R1),
    card_rank(C2, R2),
    succ(R2, R1),
    card_suit(C1, S1),
    card_suit(C2, S2),
    S1=S2.

%%%%% Compatible in hand
can_hand(C1, C2):-
    card_rank(C1, R1),
    card_rank(C2, R2),
    succ(R2, R1),
    card_color(C1, CR1),
    card_color(C2, CR2),
    CR1 \= CR2.

max_card(C) :- member(C, [h4,d4]).
min_card(C) :- member(C, [h1,d1]).


rel_fluent(aux_min_card(C)):- card(C).
rel_fluent(aux_max_card(C)):- card(C).
rel_fluent(aux_can_fun(C1, C2)) :- card(C1), card(C2).
rel_fluent(aux_can_tab(C1, C2)) :- card(C1), card(C2).
rel_fluent(aux_can_hand(C1, C2)) :- card(C1), card(C2).

rel_fluent(on(C1, C2)) :- card(C1), card(C2).
rel_fluent(on_f(C, F)) :- card(C), foundation(F).
rel_fluent(on_t(C, T)) :- card(C), tableau(T).

rel_fluent(free_t(T)) :- tableau(T).
rel_fluent(free_f(F)) :- foundation(F).
rel_fluent(free(C)) :- card(C).

rel_fluent(in_stock(C)) :- card(C).
rel_fluent(last(C, T)) :- card(C), tableau(T).

rel_fluent(in_hand(C)) :- card(C).

fun_fluent(foundation_count).
fun_fluent(hand_count).

prim_action(stock_foundation_card(C1, C2, F)) :- card(C1), card(C2), foundation(F).
poss(stock_foundation_card(C1, C2, F),(
        in_stock(C1),
        on_f(C2, F),
        free(C2),
        aux_can_fun(C1, C2)
        )).

causes_val(stock_foundation_card(_C1, _C2, _F), foundation_count, X, X is foundation_count+1).
causes_true(stock_foundation_card(C1, C2, _F), on(C1, C2), true).
causes_true(stock_foundation_card(C1, _C2, F), on_f(C1, F), true).
causes_false(stock_foundation_card(_C1, C2, _F), free(C2), true).
causes_false(stock_foundation_card(C1, _C2, _F), in_stock(C1), true).



prim_action(stock_foundation(C1, F)) :- card(C1), foundation(F).
poss(stock_foundation(C1, F),(
        in_stock(C1),
        free_f(F),
        aux_min_card(C1)
    )).

causes_val(stock_foundation(_C1, _F), foundation_count, X, X is foundation_count+1).
causes_false(stock_foundation(_C1, F), free_f(F), true).
causes_false(stock_foundation(C1, _F), in_stock(C1), true).
causes_true(stock_foundation(C1,  F), on_f(C1, F), true).


prim_action(tableau_foundation_card(C1, C2, T, F)) :- card(C1), card(C2), tableau(T), foundation(F).
poss(tableau_foundation_card(C1, C2, T, F),
    (
        free(C1),
        hand_count=0,
        on_t(C1, T),            
        on_f(C2, F), 
        free(C2),
        aux_can_fun(C1, C2)
    )
).

causes_val(tableau_foundation_card(_, _, _, _), foundation_count, X, X is foundation_count+1).

causes_true(tableau_foundation_card(C1, _, T, _), free(C3), and(on_t(C3, T), on(C1,C3))).
causes_true(tableau_foundation_card(C1, _, T, _), free_t(T), last(C1, T)).
causes_true(tableau_foundation_card(C1, C2, _, _), on(C1, C2), true).
causes_true(tableau_foundation_card(C1, _, _, F), on_f(C1, F), true).

causes_false(tableau_foundation_card(C1, _, T, _), on(C1, C3), and(on(C1, C3), on_t(C3, T))).
causes_false(tableau_foundation_card(C1, _, T, _), on_t(C1, T), true).
causes_false(tableau_foundation_card(C1, _, T, _), last(C1, T), true).
causes_false(tableau_foundation_card(_, C2, _, _), free(C2), true).



prim_action(tableau_foundation(C1, T, F)) :- card(C1),  tableau(T), foundation(F).
poss(tableau_foundation(C1,  T, F),
    (
        free(C1),
        hand_count=0,
        on_t(C1, T),
        free_f(F), 
        aux_min_card(C1)
    )
).

causes_val(tableau_foundation(_C1, _C2, _F), foundation_count, X, X is foundation_count+1).
causes_true(tableau_foundation(C1, T, _F), free(C3), and(on_t(C3, T), on(C1,C3))).
causes_true(tableau_foundation(C1, T, _F), free_t(T), last(C1, T)).
causes_true(tableau_foundation(C1, _T, F), on_f(C1, F), true).
causes_false(tableau_foundation(_C1, _T, F), free_f(F), true).
causes_false(tableau_foundation(C1, T, _F), on(C1, C3), and(on(C1, C3), on_t(C3, T))).
causes_false(tableau_foundation(C1, T, _F), on_t(C1, T), true).
causes_false(tableau_foundation(C1, T, _F), last(C1, T), true).



prim_action(tableau_tableau_card(C1, C2, T1, T2)) :- card(C1), card(C2), tableau(T1), tableau(T2).
poss(tableau_tableau_card(C1, C2, T1, T2),
    (
        free(C1),
        hand_count=0,
        on_t(C1, T1),
        T1 \= T2,    
        on_t(C2, T2), 
        free(C2),
        aux_can_tab(C1, C2)
            
    )
).


causes_true(tableau_tableau_card(C1, _C2, T1, _T2), free(C3), and(on_t(C3, T1), on(C1,C3))).
causes_true(tableau_tableau_card(C1, _C2, T1, _T2), free_t(T1), last(C1, T1)).
causes_true(tableau_tableau_card(C1, C2, _T1, _T2), on(C1, C2), true).
causes_true(tableau_tableau_card(C1, _C2, _T1, T2), on_t(C1, T2), true).
causes_false(tableau_tableau_card(_C1, C2, _T1, _T2), free(C2), true).
causes_false(tableau_tableau_card(C1, _C2, T1, _T2), on(C1, C3), and(on(C1, C3), on_t(C3, T1))).
causes_false(tableau_tableau_card(C1, _C2, T1, _T2), on_t(C1, T1), true).
causes_false(tableau_tableau_card(C1, _C2, T1, _T2), last(C1, T1), true).




prim_action(tableau_tableau(C1, T1, T2)) :- card(C1), tableau(T1), tableau(T2).
poss(tableau_tableau(C1, T1, T2),
    (
        free(C1),
        hand_count=0,
        on_t(C1, T1),
        T1 \= T2,
        \+ last(C1, T1),
        free_t(T2), 
        aux_max_card(C1)
    )
).

causes_true(tableau_tableau(C1,  T1, _T2), free(C3), and(on_t(C3, T1), on(C1,C3))).
causes_true(tableau_tableau(C1, _T1, T2), on_t(C1, T2), true).
causes_false(tableau_tableau(_C1, _T2, T2), free_t(T2), true).
causes_false(tableau_tableau(C1, T1, _T2), on(C1, C3), and(on(C1, C3), on_t(C3, T1))).
causes_false(tableau_tableau(C1, T1, _T2), on_t(C1, T1), true).

prim_action(stock_tableau_card(C1, C2, T)) :- card(C1), card(C2), tableau(T).
poss(stock_tableau_card(C1, C2, T),
    (
        in_stock(C1),
        hand_count=0,
        on_t(C2, T),     
        free(C2),
        aux_can_tab(C1, C2)
    )
).

causes_true(stock_tableau_card(C1, C2, _T), on(C1, C2), true).
causes_true(stock_tableau_card(C1, _C2, T), on_t(C1, T),  true).
causes_false(stock_tableau_card(_C1, C2, _T), free(C2),  true).
causes_false(stock_tableau_card(C1, _C2, _T), in_stock(C1),  true).



prim_action(stock_tableau(C1, T)) :- card(C1), tableau(T).
poss(stock_tableau(C1, T),
    (
        in_stock(C1),
        hand_count=0,
        free_t(T), 
        aux_max_card(C1)
    )
).

causes_true(stock_tableau(C1, T), on_t(C1, T),  true).
causes_true(stock_tableau(C1, T), last(C1, T),  true).
causes_false(stock_tableau(_C1, T), free_t(T),  true).
causes_false(stock_tableau(C1, _T), in_stock(C1),  true).


prim_action(to_hand_card(C1, C2, T)):- card(C1), card(C2), tableau(T).
poss(to_hand_card(C1, C2, T), 
    (
        on_t(C1, T),
        free(C1),
        (\+(last(C1, T));\+(aux_max_card(C1))),
        in_hand(C2), 
        free(C2),
        aux_can_hand(C1, C2)
    )
).

causes_val(to_hand_card(_C1, _C2, _T), hand_count, X, X is hand_count+1).
causes_true(to_hand_card(C1, _C2, T), free(C3), and(on_t(C3, T), on(C1, C3))).
causes_true(to_hand_card(C1, _C2, T), free_t(T), last(C1, T)).
causes_true(to_hand_card(C1, _C2, _T), in_hand(C1), true).
causes_true(to_hand_card(C1, C2, _T), on(C1, C2), true).
causes_false(to_hand_card(C1, _C2, T), on(C1, C3), and(on(C1, C3), on_t(C3, T))).
causes_false(to_hand_card(C1, _C2, T), on_t(C1, T), true).
causes_false(to_hand_card(C1, _C2, T), last(C1, T), true).
causes_false(to_hand_card(_C1, C2, _T), free(C2), true).

prim_action(to_hand(C, T)):- card(C), tableau(T).
poss(to_hand(C, T), 
    (
        on_t(C, T),
        free(C),
        ((\+ last(C, T));(\+ aux_max_card(C))),
        hand_count=0
    )
).

causes_val(to_hand(_C, _T), hand_count, X, X is hand_count+1).
causes_true(to_hand(C, T), free(C3), and(on_t(C3, T), on(C, C3))).
causes_true(to_hand(C, _T), in_hand(C), true).
causes_true(to_hand(C, T), free_t(T), last(C, T)).
causes_false(to_hand(C, T), on(C, C3), and(on(C, C3), on_t(C3, T))).
causes_false(to_hand(C, T), on_t(C, T), true).
causes_false(to_hand(C, T), last(C, T), true).


prim_action(from_hand_card(C1, C2, T)):- card(C1), card(C2), tableau(T).
poss(from_hand_card(C1, C2, T),
    (
        in_hand(C1),
        free(C1),       
        on_t(C2, T), 
        free(C2),
        aux_can_tab(C1, C2)
    )
).

causes_val(from_hand_card(_C1, _C2, _T), hand_count, X, X is hand_count-1).
causes_true(from_hand_card(C1, _C2, _T), free(C3), and(in_hand(C3), on(C1, C3))).
causes_true(from_hand_card(C1, C2, T), on(C1, C2), on_t(C2, T)).
causes_true(from_hand_card(C1, _C2, T), on_t(C1, T), true).
causes_false(from_hand_card(_C1, C2, T), free(C2), on_t(C2, T)).
causes_false(from_hand_card(C1, _C2, _T), in_hand(C1), true).
causes_false(from_hand_card(C1, _C2, _T), on(C1, C3), and(in_hand(C3), on(C1,C3))).


prim_action(from_hand(C1, T)):- card(C1), tableau(T).
poss(from_hand(C1, T),
    (
        in_hand(C1),
        free(C1),   
        free_t(T), 
        aux_max_card(C1)
    )
).

% and(in_hand(C1),free(C1),free_t(T), aux_max_card(C1))

causes_val(from_hand(_C1, _T), hand_count, X, X is hand_count-1).
causes_true(from_hand(C1, _T), free(C3), and(in_hand(C3), on(C1, C3))).
causes_true(from_hand(C1, T), on_t(C1, T), true).
causes_true(from_hand(C1, T), last(C1, T), true).
causes_false(from_hand(_C1, T), free_t(T), true).
causes_false(from_hand(C1, _T), in_hand(C1), true).
causes_false(from_hand(C1, _T), on(C1, C3), and(in_hand(C3), on(C1,C3))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

initially(foundation_count, 0).
initially(hand_count, 0).

initially(aux_min_card(C), true) :- card(C), min_card(C).
initially(aux_max_card(C), true) :- card(C), max_card(C).
initially(aux_can_tab(C1,C2), true) :- card(C1), card(C2), can_tab(C1, C2).
initially(aux_can_fun(C1,C2), true) :- card(C1), card(C2), can_fun(C1, C2).
initially(aux_can_hand(C1,C2), true) :- card(C1), card(C2), can_hand(C1, C2).


initially(aux_min_card(C), false) :- card(C), \+ initially(aux_min_card(C), true).
initially(aux_max_card(C), false) :- card(C), \+ initially(aux_max_card(C), true).
initially(aux_can_tab(C1,C2), false) :- card(C1), card(C2), \+ initially(aux_can_tab(C1,C2), true).
initially(aux_can_fun(C1,C2), false) :- card(C1), card(C2), \+ initially(aux_can_fun(C1,C2), true).
initially(aux_can_hand(C1,C2), false) :- card(C1), card(C2), \+ initially(aux_can_hand(C1,C2), true).


initially(on_t(C, t1), true) :- member(C, [d3, h4, h3, d4]).
initially(on_t(C, t2), true) :- member(C, [d1, h2]).
initially(on_t(C, T), false) :- card(C), tableau(T), \+ initially(on_t(C,T), true).
initially(on_f(C, F), false) :- card(C), foundation(F).

initially(on(d3, h4), true).
initially(on(h4, h3), true).
initially(on(h3, d4), true).
initially(on(d1, h2), true).
initially(on(C1, C2), false) :- card(C1), card(C2), \+ initially(on(C1, C2), true).

initially(in_stock(C), true) :- member(C, [d2, h1]).
initially(in_stock(C), false) :- card(C), \+ initially(in_stock(C), true).
initially(in_hand(C), false) :- card(C).


initially(free(C), true) :- card(C), \+ initially(on(_, C), true).
initially(free(C), false) :- member(C, [d4, h4, h3, h2]).

initially(last(d4, t1), true).
initially(last(h2, t2), true).
initially(last(C, T), false) :- card(C), tableau(T), \+ initially(last(C, T), true).

initially(free_t(T), true) :- member(T, []).
initially(free_t(T), false) :- tableau(T), \+ initially(T, true).

initially(free_f(F), true) :- foundation(F).

initially(something_happened, false).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rel_fluent(something_happened).
exog_action(exogenous_swap(C1, C2, T)) :- card(C1), card(C2), tableau(T).

poss(exogenous_swap(C1, C2, T), 
    (
        on_t(C1, T),
        on_t(C2, T),
        on(C1, C2),
        free(C1)
    )
).

causes_true(exogenous_swap(C1, C2, T), on(C1, C3), and(on_t(C2, T), on(C2, C3))).
causes_true(exogenous_swap(C1, C2, _), on(C2, C1), true).
causes_true(exogenous_swap(_, C2, _), free(C2), true).
causes_true(exogenous_swap(C1, C2, T), last(C1, T), last(C2, T)).
causes_true(exogenous_swap(_, _, _), something_happened, true).

causes_false(exogenous_swap(C1, C2, _), on(C1, C2), true).
causes_false(exogenous_swap(C1, _, _), free(C1), true).
causes_false(exogenous_swap(_, C2, T), last(C2, T), last(C2, T)).

prim_action(notice_event).
poss(notice_event, something_happened).

causes_false(notice_event, something_happened, true).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc(not_done, foundation_count < 8).

proc(sfc_helper, pi(c1, pi(c2, pi(f, [ stock_foundation_card(c1, c2, f) ])))).
proc(sf_helper,pi(c1, pi(f, [ stock_foundation(c1, f) ]))).

proc(tfc_helper, pi(c1, pi(c2, pi(t, pi(f, [ tableau_foundation_card(c1, c2, t, f) ]))))).
proc(tf_helper, pi(c1, pi(t, pi(f, [ tableau_foundation(c1, t, f) ])))).

proc(ttc_helper,  pi(c1, pi(c2, pi(ta, pi(tb, [ tableau_tableau_card(c1, c2, ta, tb) ]))))).
proc(tt_helper, pi(c1, pi(ta, pi(tb, [ tableau_tableau(c1, ta, tb) ])))).

proc(stc_helper, pi(c1, pi(c2, pi(t, [ stock_tableau_card(c1, c2, t) ])))).
proc(st_helper, pi(c1, pi(t, [ stock_tableau(c1, t) ]))).

proc(thc_helper, pi(c1, pi(c2, pi(t, [ to_hand_card(c1, c2, t) ])))).
proc(th_helper, pi(c1, pi(t, [ to_hand(c1, t) ]))).

proc(fhc_helper, pi(c1, pi(c2, pi(t, [ from_hand_card(c1, c2, t) ])))).
proc(fh_helper, pi(c, pi(t, [ from_hand(c, t) ]))).

proc(stock_to_foundation, ndet(sf_helper, sfc_helper)).
proc(tableau_to_foundation, ndet(tf_helper, tfc_helper)).
proc(tableau_to_tableau, ndet(tt_helper, ttc_helper)).
proc(stock_to_tableau, ndet(st_helper, stc_helper)).
proc(tableau_to_hand, ndet(th_helper, thc_helper)).
proc(hand_to_tableau, ndet(fh_helper, fhc_helper)).

proc(to_foundation,  ndet(stock_to_foundation, tableau_to_foundation)).
proc(shufle_tableau, ndet(tableau_to_tableau, stock_to_foundation)).
proc(use_hand, ndet(tableau_to_hand, hand_to_tableau), hand_to_tableau).

proc(next_move, ndet(to_foundation, ndet(shufle_tableau, use_hand))).

proc(solve, while(not_done, next_move)).

proc(control(basic_ctrl), solve).
proc(control(search_ctrl), search(solve)).


proc(control(reactive_ctrl), [
    prioritized_interrupts([
        interrupt(something_happened, [
            notice_event,
            search(solve)
        ]),
        interrupt(not_done, [
            search(solve)
        ])
    ])
]).


actionNum(X, X).