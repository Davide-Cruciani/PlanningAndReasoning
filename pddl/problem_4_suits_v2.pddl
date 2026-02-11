(define (problem klondike-4suits-hard)
  (:domain klondike-solitaire)

  ;; ======================
  (:objects
    t1 t2 t3 t4 t5 t6 t7 - tableau
    f1 f2 f3 f4 - foundation
    h1 h2 h3 h4 h5 h6 h7 h8 h9 h10
    d1 d2 d3 d4 d5 d6 d7 d8 d9 d10
    c1 c2 c3 c4 c5 c6 c7 c8 c9 c10
    s1 s2 s3 s4 s5 s6 s7 s8 s9 s10
    - card
    tbx - auxt
  )

  ;; ======================
  (:init

    ;; -------- min / max --------
    (max-card h10) (max-card d10) (max-card c10) (max-card s10)
    (min-card h1) (min-card d1) (min-card c1) (min-card s1)

    ;; -------- can-stack-in-tableau --------
    (can-stack h1 c2) (can-stack h1 s2) (can-stack d1 c2) (can-stack d1 s2)
    (can-stack c1 h2) (can-stack c1 d2) (can-stack s1 h2) (can-stack s1 d2)
    (can-stack h2 c3) (can-stack h2 s3) (can-stack d2 c3) (can-stack d2 s3)
    (can-stack c2 h3) (can-stack c2 d3) (can-stack s2 h3) (can-stack s2 d3)
    (can-stack h3 c4) (can-stack h3 s4) (can-stack d3 c4) (can-stack d3 s4)
    (can-stack c3 h4) (can-stack c3 d4) (can-stack s3 h4) (can-stack s3 d4)
    (can-stack h4 c5) (can-stack h4 s5) (can-stack d4 c5) (can-stack d4 s5)
    (can-stack c4 h5) (can-stack c4 d5) (can-stack s4 h5) (can-stack s4 d5)
    (can-stack h5 c6) (can-stack h5 s6) (can-stack d5 c6) (can-stack d5 s6)
    (can-stack c5 h6) (can-stack c5 d6) (can-stack s5 h6) (can-stack s5 d6)
    (can-stack h6 c7) (can-stack h6 s7) (can-stack d6 c7) (can-stack d6 s7)
    (can-stack c6 h7) (can-stack c6 d7) (can-stack s6 h7) (can-stack s6 d7)
    (can-stack h7 c8) (can-stack h7 s8) (can-stack d7 c8) (can-stack d7 s8)
    (can-stack c7 h8) (can-stack c7 d8) (can-stack s7 h8) (can-stack s7 d8)
    (can-stack h8 c9) (can-stack h8 s9) (can-stack d8 c9) (can-stack d8 s9)
    (can-stack c8 h9) (can-stack c8 d9) (can-stack s8 h9) (can-stack s8 d9)
    (can-stack h9 c10) (can-stack h9 s10) (can-stack d9 c10) (can-stack d9 s10)
    (can-stack c9 h10) (can-stack c9 d10) (can-stack s9 h10) (can-stack s9 d10)


    ;; -------- can-stack-in-aux-tableau --------
    (can-stack-aux h10 c9) (can-stack-aux h10 s9) (can-stack-aux d10 c9) (can-stack-aux d10 s9)
    (can-stack-aux c10 h9) (can-stack-aux c10 d9) (can-stack-aux s10 h9) (can-stack-aux s10 d9)

    (can-stack-aux h9 c8) (can-stack-aux h9 s8) (can-stack-aux d9 c8) (can-stack-aux d9 s8)
    (can-stack-aux c9 h8) (can-stack-aux c9 d8) (can-stack-aux s9 h8) (can-stack-aux s9 d8)

    (can-stack-aux h8 c7) (can-stack-aux h8 s7) (can-stack-aux d8 c7) (can-stack-aux d8 s7)
    (can-stack-aux c8 h7) (can-stack-aux c8 d7) (can-stack-aux s8 h7) (can-stack-aux s8 d7)

    (can-stack-aux h7 c6) (can-stack-aux h7 s6) (can-stack-aux d7 c6) (can-stack-aux d7 s6)
    (can-stack-aux c7 h6) (can-stack-aux c7 d6) (can-stack-aux s7 h6) (can-stack-aux s7 d6)

    (can-stack-aux h6 c5) (can-stack-aux h6 s5) (can-stack-aux d6 c5) (can-stack-aux d6 s5)
    (can-stack-aux c6 h5) (can-stack-aux c6 d5) (can-stack-aux s6 h5) (can-stack-aux s6 d5)

    (can-stack-aux h5 c4) (can-stack-aux h5 s4) (can-stack-aux d5 c4) (can-stack-aux d5 s4)
    (can-stack-aux c5 h4) (can-stack-aux c5 d4) (can-stack-aux s5 h4) (can-stack-aux s5 d4)

    (can-stack-aux h4 c3) (can-stack-aux h4 s3) (can-stack-aux d4 c3) (can-stack-aux d4 s3)
    (can-stack-aux c4 h3) (can-stack-aux c4 d3) (can-stack-aux s4 h3) (can-stack-aux s4 d3)

    (can-stack-aux h3 c2) (can-stack-aux h3 s2) (can-stack-aux d3 c2) (can-stack-aux d3 s2)
    (can-stack-aux c3 h2) (can-stack-aux c3 d2) (can-stack-aux s3 h2) (can-stack-aux s3 d2)

    (can-stack-aux h2 c1) (can-stack-aux h2 s1) (can-stack-aux d2 c1) (can-stack-aux d2 s1)
    (can-stack-aux c2 h1) (can-stack-aux c2 d1) (can-stack-aux s2 h1) (can-stack-aux s2 d1)



    ;; -------- can-put-on-foundation --------
    (put h2 h1) (put h3 h2) (put h4 h3) (put h5 h4) (put h6 h5) (put h7 h6) (put h8 h7) (put h9 h8) (put h10 h9)
    (put c2 c1) (put c3 c2) (put c4 c3) (put c5 c4) (put c6 c5) (put c7 c6) (put c8 c7) (put c9 c8) (put c10 c9)
    (put d2 d1) (put d3 d2) (put d4 d3) (put d5 d4) (put d6 d5) (put d7 d6) (put d8 d7) (put d9 d8) (put d10 d9)
    (put s2 s1) (put s3 s2) (put s4 s3) (put s5 s4) (put s6 s5) (put s7 s6) (put s8 s7) (put s9 s8) (put s10 s9)

    ;; -------- state of the agent --------
    (free)

    ;; -----ex1-----
    ; (on-tableau h10 t1) (on s9 h10) (on d8 s9) (on c7 d8) (on h6 c7) (on s2 h6) (on s1 s2) (clear s1)
    ; (on-tableau d10 t2) (on c9 d10) (on h8 c9) (on s7 h8) (on d6 s7) (on c5 d6) (clear c5)
    ; (on-tableau s10 t3) (on h9 s10) (on c8 h9) (on d7 c8) (on s6 d7) (on c1 s6) (clear c1)
    ; (on-tableau c10 t4) (on h7 c10) (on s5 h7) (on d4 s5) (on c3 d4) (clear c3)
    ; (on-tableau s8 t5) (on d5 s8) (on c4 d5) (on d1 c4) (on h2 d1) (clear h2)
    ; (on-tableau c6 t6) (on s4 c6) (on h1 s4) (on d2 h1) (clear d2)
    ; (on-tableau h5 t7) (on d3 h5) (on c2 d3) (on s3 c2) (clear s3)

    ; ;; =========================================================
    ; (in-stock h3) (in-stock h4) (in-stock d9)


;; =========================================================


    (on-tableau h10 t1) (on s9 h10) (on c8 s9) (on d7 c8) (on s1 d7) (on h6 s1) (on c5 h6) (clear c5)
    (on-tableau d10 t2) (on c9 d10) (on h8 c9) (on s7 h8) (on c1 s7) (on d6 c1) (on h5 d6) (clear h5)
    (on-tableau s10 t3) (on d9 s10) (on c7 d9) (on h7 c7) (on d1 h7) (on s6 d1) (clear s6)
    (on-tableau c10 t4) (on h9 c10) (on s8 h9) (on d8 s8) (on h1 d8) (on c6 h1) (clear c6)
    (on-tableau s9 t5) (on h4 s9) (on d5 h4) (on c4 d5) (on s3 c4) (on h2 s3) (clear h2)
    (on-tableau s2 t6) (on d4 s2) (on c3 d4) (on d2 c3) (clear d2)
    (on-tableau s4 t7) (clear s4)

;; =========================================================
    (in-stock s5) (in-stock c2) (in-stock h3) (in-stock d3)

    (empty-aux-tableau tbx)
   
    ;; -------- foundations --------
    (empty-foundation f1) (empty-foundation f2) (empty-foundation f3) (empty-foundation f4)
    (= (foundation-count f1) 0) (= (foundation-count f2) 0)
    (= (foundation-count f3) 0) (= (foundation-count f4) 0)
  )

  ;; ======================
  (:goal
    (and
      (= (foundation-count f1) 10)
      (= (foundation-count f2) 10)
      (= (foundation-count f3) 10)
      (= (foundation-count f4) 10)
    )
  )
 
)