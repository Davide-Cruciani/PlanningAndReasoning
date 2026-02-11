(define (problem klondike-2suits-hard)
  (:domain klondike-solitaire)

  ;; ======================
  (:objects
    t1 t2 t3 t4 t5 - tableau
    f1 f2 - foundation
    h1 h2 h3 h4 h5 h6 h7 h8 h9 h10
    s1 s2 s3 s4 s5 s6 s7 s8 s9 s10
    - card
    tbx - auxt
  )

  ;; ======================
  (:init

    ;; -------- min / max --------
    (max-card h10) (max-card s10)
    (min-card h1) (min-card s1)

    ;; -------- can-stack-in-tableau --------
    (can-stack h1 s2) (can-stack s1 h2)
    (can-stack h2 s3) (can-stack s2 h3)
    (can-stack h3 s4) (can-stack s3 h4)
    (can-stack h4 s5) (can-stack s4 h5)
    (can-stack h5 s6) (can-stack s5 h6)
    (can-stack h6 s7) (can-stack s6 h7)
    (can-stack h7 s8) (can-stack s7 h8)
    (can-stack h8 s9) (can-stack s8 h9)
    (can-stack h9 s10) (can-stack s9 h10)

    ;; -------- can-stack-in-aux-tableau --------
    (can-stack-aux h10 s9) (can-stack-aux s10 h9)
    (can-stack-aux h9 s8) (can-stack-aux s9 h8)
    (can-stack-aux h8 s7) (can-stack-aux s8 h7)
    (can-stack-aux h7 s6) (can-stack-aux s7 h6)
    (can-stack-aux h6 s5) (can-stack-aux s6 h5)
    (can-stack-aux h5 s4) (can-stack-aux s5 h4)
    (can-stack-aux h4 s3) (can-stack-aux s4 h3)
    (can-stack-aux h3 s2) (can-stack-aux s3 h2)
    (can-stack-aux h2 s1) (can-stack-aux s2 h1)

    ;; -------- can-put-on-foundation --------
    (put h2 h1) (put h3 h2) (put h4 h3) (put h5 h4) (put h6 h5) (put h7 h6) (put h8 h7) (put h9 h8) (put h10 h9)
    (put s2 s1) (put s3 s2) (put s4 s3) (put s5 s4) (put s6 s5) (put s7 s6) (put s8 s7) (put s9 s8) (put s10 s9)

    ;; -------- state of the agent --------
    (free)
    (empty-aux-tableau tbx)
        
    (on-tableau h4 t1)(on s6 h4)(on h7 s6)(on s9 h7)(clear s9)
    (on-tableau s3 t2)(on h5 s3)(on s8 h5)(on s10 s8)(on h9 s10)(clear h9)
    (on-tableau h3 t3)(on s5 h3)(on h6 s5)(on s7 h6)(clear s7)
    (on-tableau s2 t4)(on h8 s2)(on s4 h8)(on h10 s4)(clear h10)

    (empty-tableau t5)

    ;; -------- stock --------
    (in-stock h1) (in-stock h2) (in-stock s1)

    ;; -------- foundations --------
    (empty-foundation f1) (empty-foundation f2)
    (= (foundation-count f1) 0) 
    (= (foundation-count f2) 0)
  )

  ;; ======================
  (:goal
    (and
      (= (foundation-count f1) 10)
      (= (foundation-count f2) 10)
    )
  )

  
)