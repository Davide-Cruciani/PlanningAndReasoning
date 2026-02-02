;Header and description

(define (domain klondike-solitaire)

;remove requirements that are not needed
(:requirements 
    :strips
    :typing
    :equality
    :negative-preconditions
    :disjunctive-preconditions
    :numeric-fluents
    :conditional-effects
)

(:types
    card
    tableau
    foundation
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (on ?c1 ?c2 - card)
    (on-t ?c - card ?t - tableau)
    (on-f ?c - card ?f - foundation)
    (free ?c - card)
    (free-t ?t - tableau)
    (free-f ?f - foundation)
    (can-fund ?c1 ?c2 - card)
    (can-tab ?c1 ?c2 - card)
    (max-rank ?c - card)
    (min-rank ?c - card)
    (in-stock ?c - card)
)


(:functions ;todo: define numeric functions here
    (foundation-count ?f - foundation)
)

(:action stock-tableau
    :parameters (?c1 ?c2 - card ?t - tableau)
    :precondition (and 
        (in-stock ?c1)
        (or 
            (and (free-t ?t)(max-rank ?c1))
            (and (on-t ?c2 ?t)(can-tab ?c1 ?c2)(free ?c2))
        )
    )
    :effect (and 
        (on-t ?c1 ?t)
        (free ?c1)
        (when (free-t ?t)(not(free-t ?t)))
        (when (on-t ?c2 ?t) (and(not(free ?c2))(on ?c1 ?c2)))
    )
)

(:action tableau-tableau
    :parameters (?c1 ?c2 - card ?t1 ?t2 - tableau)
    :precondition (and 
        (on-t ?c1 ?t1)
        (free ?c1)
        (or
            (and (on-t ?c2 ?t2)(free ?c2)(can-tab ?c1 ?c2))
            (and 
                (free-t ?t2)
                (max-rank ?c1)
                (exists (?c - card) (and 
                    (on-t ?c ?t1)
                    (not (= ?c ?c1))
                ))    
            )
        )
    )
    :effect (and 
        (not (on-t ?c1 ?t1))
        (on-t ?c1 ?t2)
        (forall (?c - card) 
            (when (on ?c1 ?c) 
                (and (not (on ?c1 ?c))(free ?c))
            )
        )
        (when (on-t ?c2 ?t2) (and (not(free ?c2))(on ?c1 ?c2)))
        (when (free-t ?t2) (not (free-t ?t2)))
    )
)

(:action stock-foundation
    :parameters (?c1 ?c2 - card ?f - foundation)
    :precondition (and 
        (in-stock ?c1)
        (or 
            (and (on-f ?c2 ?f)(free ?c2)(can-fund ?c1 ?c2))
            (and (free-f ?f)(min-rank ?c1))
        )
    )
    :effect (and 
        (increase (foundation-count ?f) 1)
        (not (in-stock ?c1))
        (free ?c1)
        (on-f ?c1 ?f)
        (when (on-f ?c2 ?f) (and (not(free ?c2))(on ?c1 ?c2)))
        (when (free-f ?f) (not (free-f ?f)))
    )
)

(:action tableau-foundation
    :parameters (?c1 ?c2 - card ?t - tableau ?f - foundation)
    :precondition (and 
        (on-t ?c1 ?t)
        (free ?c1)
        (or 
            (and (free-f ?f)(min-rank ?c1))
            (and (on-f ?c2 ?f)(can-fund ?c1 ?c2)(free ?c2))    
        )
    )
    :effect (and 
        (increase (foundation-count ?f) 1)
        (on-f ?c1 ?f)
        (not (on-t ?c1 ?t))
        (forall (?c - card) 
            (when (on ?c1 ?c) 
                (and (not (on ?c1 ?c))(free ?c))
            )
        )
        (when (free-f ?f)(not(free-f ?f)))
        (when (on-f ?c2 ?f)(and (not(free ?c2))(on ?c1 ?c2)))
    )
)



)