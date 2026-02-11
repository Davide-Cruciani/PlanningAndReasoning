(define (domain klondike-solitaire)
  (:requirements
    :strips
    :typing
    :negative-preconditions
    :disjunctive-preconditions
    :numeric-fluents
    
  )

  ;; ======================
  (:types
    card
    tableau
    foundation
    auxt
    )

  ;; ======================
  (:predicates

  
    ;; --- Relation of stacking ---
    (on ?c1 - card ?c2 - card)   ; c1 card on c2 card
    (clear ?c - card)           ; not card on c1

    ;; --- Tableau ---
    (on-tableau ?c - card ?t - tableau) ;card c on t tableau
    
    (empty-tableau ?t - tableau) ;empty-tableau (no cards)

    ;; --- Foundation ---
    (on-foundation ?c - card ?f - foundation) ;card c on foundation f
    (empty-foundation ?f - foundation ) ; foundation f empty

    ;; --- Stock ---
    (in-stock ?c - card) ; card c in stock 

    ;; --- has card ---
    (has-card ?c - card) ; the player has card c
    ;; --- free hands ---
    (free) ; the player has no cards in hand
    ;;--relation of tableau--
    (can-stack ?c1 - card ?c2 - card)
    ;;--relation of foundation--
    (put ?c1 - card ?c2 - card)

    ;; --- max card ---
    (max-card ?c - card)
    ;; --- min card ---
    (min-card ?c - card)

    ;; --- aux-tableau ---
    (on-aux-tableau ?c - card) ; card on aux-tableau
    (empty-aux-tableau ?t - auxt) ;aux-tableau is empty
    (first-aux ?c - card) ; card c is the first in aux-tableau
    (can-stack-aux ?c1 - card ?c2 - card ) ; relation of stack in aux-tableau

  )

(:functions
  (foundation-count ?f - foundation)
  
)

;; --- action pick from the stack---
(:action pick-card-stock
  :parameters (?c - card )
  :precondition(and(in-stock ?c)(free))
  :effect (and(has-card ?c)(not(free))(not(in-stock ?c))))

;; --- action pick from tableau---
(:action pick-card-card
  :parameters (?c1 - card ?c2 - card )
  :precondition(and(free)(clear ?c1)(on ?c1 ?c2)(not(in-stock ?c1))(not(on-aux-tableau ?c1 )))
  :effect (and(has-card ?c1)(not(free))(clear ?c2)(not(on ?c1 ?c2))))

;; --- action pick from tableau its last card---
(:action pick-last-card-tableau
  :parameters (?c1 - card ?t - tableau)
  :precondition(and(on-tableau ?c1 ?t)(free)(clear ?c1))
  :effect (and(has-card ?c1)(not(free))(not(on-tableau ?c1 ?t))(empty-tableau ?t)))

;; --- action drop card to tableau not empty---
(:action drop-card-tableau-not-free
  :parameters (?c1 - card ?c2 - card  )
  :precondition(and(has-card ?c1)(clear ?c2)(can-stack ?c1  ?c2 )(not(on-aux-tableau ?c2)))
  :effect (and(on ?c1 ?c2)(not(clear ?c2))(clear ?c1)(free)(not(has-card ?c1))))

;; --- action drop to from tableau empty---
(:action drop-card-tableau-free
  :parameters (?c1 - card ?t - tableau )
  :precondition(and(has-card ?c1)(empty-tableau ?t)(max-card ?c1))
  :effect (and(free)(clear ?c1)(not(empty-tableau ?t))(on-tableau ?c1 ?t)(not(has-card ?c1))))

;; --- action drop card to foundation not empty---
(:action drop-card-foundation-not-free
  :parameters (?c1 - card ?c2 - card ?f - foundation)
  :precondition(and(has-card ?c1)(clear ?c2)(on-foundation ?c2 ?f)(put ?c1 ?c2))
  :effect (and(clear ?c1)(not(clear ?c2))(free)(on-foundation ?c1 ?f)(not(has-card ?c1))(increase (foundation-count ?f) 1)))
  
;; --- action drop card to foundation empty---
(:action drop-card-foundation-free
  :parameters (?c1 - card ?f - foundation)
  :precondition(and(has-card ?c1)(empty-foundation ?f)(min-card ?c1))
  :effect (and(free)(clear ?c1)(not(empty-foundation ?f))(on-foundation ?c1 ?f)(not(has-card ?c1))(increase (foundation-count ?f) 1)))

;; --- action pick from aux-tableau its last card---
(:action pick-last-card-aux-tableau
  :parameters (?c1 - card ?t - auxt)
  :precondition(and(free)(clear ?c1)(on-aux-tableau ?c1 )(first-aux ?c1))
  :effect (and(not(free))(has-card ?c1)(empty-aux-tableau ?t)(not(on-aux-tableau ?c1))(not(first-aux ?c1))))

;; --- action pick from aux-tableau ---
(:action pick-card-aux-tableau
  :parameters (?c1 - card ?c2 - card )
  :precondition(and(free)(clear ?c1)(on ?c1 ?c2)(on-aux-tableau ?c1 )(on-aux-tableau ?c2 ))
  :effect (and(not(free))(has-card ?c1)(clear ?c2)(not(on-aux-tableau ?c1 ))(not(on ?c1 ?c2))))

;; --- action drop card to aux-tableau empty---
(:action drop-card-aux-tableau-free
  :parameters (?c1 - card ?t - auxt )
  :precondition(and(has-card ?c1)(empty-aux-tableau ?t))
  :effect (and(free)(clear ?c1)(first-aux ?c1)(not(empty-aux-tableau ?t))(on-aux-tableau ?c1 )(not(has-card ?c1))))

;; --- action drop card to aux-tableau ---
(:action drop-card-aux-tableau-not-free
  :parameters (?c1 - card ?c2 - card )
  :precondition(and(has-card ?c1)(on-aux-tableau ?c2)(clear ?c2)(can-stack-aux ?c1  ?c2 ))
  :effect (and(on ?c1 ?c2)(not(clear ?c2))(clear ?c1)(free)(not(has-card ?c1))(on-aux-tableau ?c1)))


)
