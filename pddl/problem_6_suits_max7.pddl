(define (problem klondike-6suits-rank7-dense)
  (:domain klondike-solitaire)

  ;; ======================
  (:objects
    t1 t2 t3 t4 t5 t6 t7 t8 t9  - tableau
    f1 f2 f3 f4 f5 f6 - foundation
    h1 h2 h3 h4 h5 h6 h7
    d1 d2 d3 d4 d5 d6 d7
    m1 m2 m3 m4 m5 m6 m7
    c1 c2 c3 c4 c5 c6 c7
    s1 s2 s3 s4 s5 s6 s7
    tc1 tc2 tc3 tc4 tc5 tc6 tc7
    - card
    tbx - auxt  
  )

  ;; ======================
  (:init
    ;; --- min / max ---
    (max-card h7) (max-card d7) (max-card m7) (max-card c7) (max-card s7) (max-card tc7)
    (min-card h1) (min-card d1) (min-card m1) (min-card c1) (min-card s1) (min-card tc1)
    
    (free)
    (empty-aux-tableau tbx)
    
    ;; -------- can-stack-in-tableau --------
    
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

    ;; -------- can-stack-in-aux-tableau --------
        
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

    ;; -------- can-put-on-foundation --------
    (put h2 h1) (put h3 h2) (put h4 h3) (put h5 h4) (put h6 h5) (put h7 h6)
    (put d2 d1) (put d3 d2) (put d4 d3) (put d5 d4) (put d6 d5) (put d7 d6)
    (put m2 m1) (put m3 m2) (put m4 m3) (put m5 m4) (put m6 m5) (put m7 m6)
    (put c2 c1) (put c3 c2) (put c4 c3) (put c5 c4) (put c6 c5) (put c7 c6)
    (put s2 s1) (put s3 s2) (put s4 s3) (put s5 s4) (put s6 s5) (put s7 s6)
    (put tc2 tc1) (put tc3 tc2) (put tc4 tc3) (put tc5 tc4) (put tc6 tc5) (put tc7 tc6)

    ;; =========================================================

    ;;---ex2---
    (on-tableau h4 t1) (on tc1 h4) (on s7 tc1) (on d2 s7) (on m6 d2) (on c5 m6) (clear c5)
    (on-tableau m2 t2) (on h1 m2) (on c7 h1) (on s3 c7) (on tc5 s3) (on d6 tc5) (clear d6)
    (on-tableau s1 t3) (on d4 s1) (on tc7 d4) (on h2 tc7) (on m5 h2) (on c3 m5) (clear c3)
    (on-tableau c2 t4) (on m7 c2) (on s6 m7) (on d1 s6) (on tc3 d1) (on h5 tc3) (clear h5)
    (on-tableau tc6 t5) (on s2 tc6) (on h7 s2) (on m1 h7) (on d3 m1) (clear d3)
    (on-tableau d5 t6) (on c1 d5) (on tc2 c1) (on s4 tc2) (clear s4)
    (on-tableau m3 t7) (on h6 m3) (clear h6)
    (on-tableau c4 t8) (on s5 c4) (clear s5)
    (empty-tableau t9)

    (in-stock tc4) 
    (in-stock m4) 
    (in-stock d7) 
    (in-stock c6) 
    (in-stock h3)

    ;; --- foundations ---
    (empty-foundation f1) (empty-foundation f2) (empty-foundation f3)
    (empty-foundation f4) (empty-foundation f5) (empty-foundation f6) (empty-aux-tableau tbx)
    (= (foundation-count f1) 0) (= (foundation-count f2) 0) (= (foundation-count f3) 0)
    (= (foundation-count f4) 0) (= (foundation-count f5) 0) (= (foundation-count f6) 0)
  )

  ;; ======================
  (:goal
    (and
      (= (foundation-count f1) 7)
      (= (foundation-count f2) 7)
      (= (foundation-count f3) 7)
      (= (foundation-count f4) 7)
      (= (foundation-count f5) 7)
      (= (foundation-count f6) 7)
    )
  )

  
)