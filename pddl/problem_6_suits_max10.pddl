(define (problem klondike-6suits-rank10-ultra-dense)
  (:domain klondike-solitaire)

  ;; ======================
  (:objects
    t1 t2 t3 t4 t5 t6 t7 t8 t9 - tableau
    f1 f2 f3 f4 f5 f6 - foundation
    h1 h2 h3 h4 h5 h6 h7 h8 h9 h10
    d1 d2 d3 d4 d5 d6 d7 d8 d9 d10
    m1 m2 m3 m4 m5 m6 m7 m8 m9 m10
    c1 c2 c3 c4 c5 c6 c7 c8 c9 c10
    s1 s2 s3 s4 s5 s6 s7 s8 s9 s10
    tc1 tc2 tc3 tc4 tc5 tc6 tc7 tc8 tc9 tc10
    - card
    tbx - auxt
  )

  ;; ======================
  (:init
    ;; --- min / max ---
    (max-card h10) (max-card d10) (max-card m10) (max-card c10) (max-card s10) (max-card tc10)
    (min-card h1) (min-card d1) (min-card m1) (min-card c1) (min-card s1) (min-card tc1)
    
    (free)
    (empty-aux-tableau tbx)
    

    ;; -------- can-stack --------
    (can-stack h1 c2) (can-stack h1 s2) (can-stack h1 tc2) (can-stack d1 c2) (can-stack d1 s2) (can-stack d1 tc2) (can-stack m1 c2) (can-stack m1 s2) (can-stack m1 tc2)
    (can-stack c1 h2) (can-stack c1 d2) (can-stack c1 m2) (can-stack s1 h2) (can-stack s1 d2) (can-stack s1 m2) (can-stack tc1 h2) (can-stack tc1 d2) (can-stack tc1 m2)
    (can-stack h2 c3) (can-stack h2 s3) (can-stack h2 tc3) (can-stack d2 c3) (can-stack d2 s3) (can-stack d2 tc3) (can-stack m2 c3) (can-stack m2 s3) (can-stack m2 tc3)
    (can-stack c2 h3) (can-stack c2 d3) (can-stack c2 m3) (can-stack s2 h3) (can-stack s2 d3) (can-stack s2 m3) (can-stack tc2 h3) (can-stack tc2 d3) (can-stack tc2 m3)
    (can-stack h3 c4) (can-stack h3 s4) (can-stack h3 tc4) (can-stack d3 c4) (can-stack d3 s4) (can-stack d3 tc4) (can-stack m3 c4) (can-stack m3 s4) (can-stack m3 tc4)
    (can-stack c3 h4) (can-stack c3 d4) (can-stack c3 m4) (can-stack s3 h4) (can-stack s3 d4) (can-stack s3 m4) (can-stack tc3 h4) (can-stack tc3 d4) (can-stack tc3 m4)
    (can-stack h4 c5) (can-stack h4 s5) (can-stack h4 tc5) (can-stack d4 c5) (can-stack d4 s5) (can-stack d4 tc5) (can-stack m4 c5) (can-stack m4 s5) (can-stack m4 tc5)
    (can-stack c4 h5) (can-stack c4 d5) (can-stack c4 m5) (can-stack s4 h5) (can-stack s4 d5) (can-stack s4 m5) (can-stack tc4 h5) (can-stack tc4 d5) (can-stack tc4 m5)
    (can-stack h5 c6) (can-stack h5 s6) (can-stack h5 tc6) (can-stack d5 c6) (can-stack d5 s6) (can-stack d5 tc6) (can-stack m5 c6) (can-stack m5 s6) (can-stack m5 tc6)
    (can-stack c5 h6) (can-stack c5 d6) (can-stack c5 m6) (can-stack s5 h6) (can-stack s5 d6) (can-stack s5 m6) (can-stack tc5 h6) (can-stack tc5 d6) (can-stack tc5 m6)
    (can-stack h6 c7) (can-stack h6 s7) (can-stack h6 tc7) (can-stack d6 c7) (can-stack d6 s7) (can-stack d6 tc7) (can-stack m6 c7) (can-stack m6 s7) (can-stack m6 tc7)
    (can-stack c6 h7) (can-stack c6 d7) (can-stack c6 m7) (can-stack s6 h7) (can-stack s6 d7) (can-stack s6 m7) (can-stack tc6 h7) (can-stack tc6 d7) (can-stack tc6 m7)
    (can-stack h7 c8) (can-stack h7 s8) (can-stack h7 tc8) (can-stack d7 c8) (can-stack d7 s8) (can-stack d7 tc8) (can-stack m7 c8) (can-stack m7 s8) (can-stack m7 tc8)
    (can-stack c7 h8) (can-stack c7 d8) (can-stack c7 m8) (can-stack s7 h8) (can-stack s7 d8) (can-stack s7 m8) (can-stack tc7 h8) (can-stack tc7 d8) (can-stack tc7 m8)
    (can-stack h8 c9) (can-stack h8 s9) (can-stack h8 tc9) (can-stack d8 c9) (can-stack d8 s9) (can-stack d8 tc9) (can-stack m8 c9) (can-stack m8 s9) (can-stack m8 tc9)
    (can-stack c8 h9) (can-stack c8 d9) (can-stack c8 m9) (can-stack s8 h9) (can-stack s8 d9) (can-stack s8 m9) (can-stack tc8 h9) (can-stack tc8 d9) (can-stack tc8 m9)
    (can-stack h9 c10) (can-stack h9 s10) (can-stack h9 tc10) (can-stack d9 c10) (can-stack d9 s10) (can-stack d9 tc10) (can-stack m9 c10) (can-stack m9 s10) (can-stack m9 tc10)
    (can-stack c9 h10) (can-stack c9 d10) (can-stack c9 m10) (can-stack s9 h10) (can-stack s9 d10) (can-stack s9 m10) (can-stack tc9 h10) (can-stack tc9 d10) (can-stack tc9 m10)

    ;; -------- can-stack-aux --------
    (can-stack-aux h10 c9) (can-stack-aux h10 s9) (can-stack-aux h10 tc9) (can-stack-aux d10 c9) (can-stack-aux d10 s9) (can-stack-aux d10 tc9) (can-stack-aux m10 c9) (can-stack-aux m10 s9) (can-stack-aux m10 tc9)
    (can-stack-aux c10 h9) (can-stack-aux c10 d9) (can-stack-aux c10 m9) (can-stack-aux s10 h9) (can-stack-aux s10 d9) (can-stack-aux s10 m9) (can-stack-aux tc10 h9) (can-stack-aux tc10 d9) (can-stack-aux tc10 m9)
    (can-stack-aux h9 c8) (can-stack-aux h9 s8) (can-stack-aux h9 tc8) (can-stack-aux d9 c8) (can-stack-aux d9 s8) (can-stack-aux d9 tc8) (can-stack-aux m9 c8) (can-stack-aux m9 s8) (can-stack-aux m9 tc8)
    (can-stack-aux c9 h8) (can-stack-aux c9 d8) (can-stack-aux c9 m8) (can-stack-aux s9 h8) (can-stack-aux s9 d8) (can-stack-aux s9 m8) (can-stack-aux tc9 h8) (can-stack-aux tc9 d8) (can-stack-aux tc9 m8)
    (can-stack-aux h8 c7) (can-stack-aux h8 s7) (can-stack-aux h8 tc7) (can-stack-aux d8 c7) (can-stack-aux d8 s7) (can-stack-aux d8 tc7) (can-stack-aux m8 c7) (can-stack-aux m8 s7) (can-stack-aux m8 tc7)
    (can-stack-aux c8 h7) (can-stack-aux c8 d7) (can-stack-aux c8 m7) (can-stack-aux s8 h7) (can-stack-aux s8 d7) (can-stack-aux s8 m7) (can-stack-aux tc8 h7) (can-stack-aux tc8 d7) (can-stack-aux tc8 m7)
    (can-stack-aux h7 c6) (can-stack-aux h7 s6) (can-stack-aux h7 tc6) (can-stack-aux d7 c6) (can-stack-aux d7 s6) (can-stack-aux d7 tc6) (can-stack-aux m7 c6) (can-stack-aux m7 s6) (can-stack-aux m7 tc6)
    (can-stack-aux c7 h6) (can-stack-aux c7 d6) (can-stack-aux c7 m6) (can-stack-aux s7 h6) (can-stack-aux s7 d6) (can-stack-aux s7 m6) (can-stack-aux tc7 h6) (can-stack-aux tc7 d6) (can-stack-aux tc7 m6)
    (can-stack-aux h6 c5) (can-stack-aux h6 s5) (can-stack-aux h6 tc5) (can-stack-aux d6 c5) (can-stack-aux d6 s5) (can-stack-aux d6 tc5) (can-stack-aux m6 c5) (can-stack-aux m6 s5) (can-stack-aux m6 tc5)
    (can-stack-aux c6 h5) (can-stack-aux c6 d5) (can-stack-aux c6 m5) (can-stack-aux s6 h5) (can-stack-aux s6 d5) (can-stack-aux s6 m5) (can-stack-aux tc6 h5) (can-stack-aux tc6 d5) (can-stack-aux tc6 m5)
    (can-stack-aux h5 c4) (can-stack-aux h5 s4) (can-stack-aux h5 tc4) (can-stack-aux d5 c4) (can-stack-aux d5 s4) (can-stack-aux d5 tc4) (can-stack-aux m5 c4) (can-stack-aux m5 s4) (can-stack-aux m5 tc4)
    (can-stack-aux c5 h4) (can-stack-aux c5 d4) (can-stack-aux c5 m4) (can-stack-aux s5 h4) (can-stack-aux s5 d4) (can-stack-aux s5 m4) (can-stack-aux tc5 h4) (can-stack-aux tc5 d4) (can-stack-aux tc5 m4)
    (can-stack-aux h4 c3) (can-stack-aux h4 s3) (can-stack-aux h4 tc3) (can-stack-aux d4 c3) (can-stack-aux d4 s3) (can-stack-aux d4 tc3) (can-stack-aux m4 c3) (can-stack-aux m4 s3) (can-stack-aux m4 tc3)
    (can-stack-aux c4 h3) (can-stack-aux c4 d3) (can-stack-aux c4 m3) (can-stack-aux s4 h3) (can-stack-aux s4 d3) (can-stack-aux s4 m3) (can-stack-aux tc4 h3) (can-stack-aux tc4 d3) (can-stack-aux tc4 m3)
    (can-stack-aux h3 c2) (can-stack-aux h3 s2) (can-stack-aux h3 tc2) (can-stack-aux d3 c2) (can-stack-aux d3 s2) (can-stack-aux d3 tc2) (can-stack-aux m3 c2) (can-stack-aux m3 s2) (can-stack-aux m3 tc2)
    (can-stack-aux c3 h2) (can-stack-aux c3 d2) (can-stack-aux c3 m2) (can-stack-aux s3 h2) (can-stack-aux s3 d2) (can-stack-aux s3 m2) (can-stack-aux tc3 h2) (can-stack-aux tc3 d2) (can-stack-aux tc3 m2)
    (can-stack-aux h2 c1) (can-stack-aux h2 s1) (can-stack-aux h2 tc1) (can-stack-aux d2 c1) (can-stack-aux d2 s1) (can-stack-aux d2 tc1) (can-stack-aux m2 c1) (can-stack-aux m2 s1) (can-stack-aux m2 tc1)
    (can-stack-aux c2 h1) (can-stack-aux c2 d1) (can-stack-aux c2 m1) (can-stack-aux s2 h1) (can-stack-aux s2 d1) (can-stack-aux s2 m1) (can-stack-aux tc2 h1) (can-stack-aux tc2 d1) (can-stack-aux tc2 m1)

    ;; -------- put foundation --------
    (put h2 h1) (put h3 h2) (put h4 h3) (put h5 h4) (put h6 h5) (put h7 h6) (put h8 h7) (put h9 h8) (put h10 h9)
    (put d2 d1) (put d3 d2) (put d4 d3) (put d5 d4) (put d6 d5) (put d7 d6) (put d8 d7) (put d9 d8) (put d10 d9)
    (put m2 m1) (put m3 m2) (put m4 m3) (put m5 m4) (put m6 m5) (put m7 m6) (put m8 m7) (put m9 m8) (put m10 m9)
    (put c2 c1) (put c3 c2) (put c4 c3) (put c5 c4) (put c6 c5) (put c7 c6) (put c8 c7) (put c9 c8) (put c10 c9)
    (put s2 s1) (put s3 s2) (put s4 s3) (put s5 s4) (put s6 s5) (put s7 s6) (put s8 s7) (put s9 s8) (put s10 s9)
    (put tc2 tc1) (put tc3 tc2) (put tc4 tc3) (put tc5 tc4) (put tc6 tc5) (put tc7 tc6) (put tc8 tc7) (put tc9 tc8) (put tc10 tc9)

    ;; =========================================================

    (on-tableau d10 t1) (on m9 d10) (on h8 m9) (on c7 h8) (on tc6 c7) (on d5 tc6) (on m4 d5) (on s3 m4) (on s1 s3) (clear s1)
    (on-tableau h10 t2) (on tc9 h10) (on s8 tc9) (on s7 s8) (on d6 s7) (on h5 d6) (on tc4 h5) (on c1 tc4) (clear c1)
    (on-tableau s10 t3) (on c9 s10) (on d8 c9) (on m7 d8) (on h6 m7) (on tc5 h6) (on d1 tc5) (clear d1)
    (on-tableau c10 t4) (on h9 c10) (on s6 h9) (on m3 s6) (on h1 m3) (on d2 h1) (clear d2)
    (on-tableau tc10 t5) (on m6 tc10) (on h2 m6) (on d7 h2) (on m1 d7) (on tc2 m1) (clear tc2)
    (on-tableau m10 t6) (on s4 m10) (on tc3 s4) (on c2 tc3) (on tc8 c2) (clear tc8)
    (on-tableau s5 t7) (on tc1 s5) (on h4 tc1) (on d4 h4) (on s9 d4) (clear s9)
    (on-tableau c5 t8) (on tc7 c5) (on c8 tc7) (on h7 c8) (on c6 h7) (on m2 c6) (clear m2)
    (empty-tableau t9)

    (in-stock h3) (in-stock s2) (in-stock d3) (in-stock c3) (in-stock m5) (in-stock m8) (in-stock d9) (in-stock c4)


    ;; --- foundations ---
    (empty-foundation f1) (empty-foundation f2) (empty-foundation f3)
    (empty-foundation f4) (empty-foundation f5) (empty-foundation f6)
    (= (foundation-count f1) 0) (= (foundation-count f2) 0) (= (foundation-count f3) 0)
    (= (foundation-count f4) 0) (= (foundation-count f5) 0) (= (foundation-count f6) 0)
  )

  ;; ======================
  (:goal
    (and
      (= (foundation-count f1) 10)
      (= (foundation-count f2) 10)
      (= (foundation-count f3) 10)
      (= (foundation-count f4) 10)
      (= (foundation-count f5) 10)
      (= (foundation-count f6) 10)
    )
  )

  
)