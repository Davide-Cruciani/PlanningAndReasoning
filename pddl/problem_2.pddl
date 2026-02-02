(define (problem klondike-2suits)
    (:domain klondike-solitaire)

(:objects
    t1 t2 t3 t4 t5 - tableau
    f1 f2 - foundation
    h1 h2 h3 h4 h5 h6 h7 h8 h9 h10
    s1 s2 s3 s4 s5 s6 s7 s8 s9 s10
    - card
)

(:init
    ;; -------- min / max --------
    (max-rank h10)
    (max-rank s10)
    (min-rank h1)
    (min-rank s1)

    ;; -------- can-tab --------
    (can-tab h1 s2) (can-tab s1 h2)
    (can-tab h2 s3) (can-tab s2 h3)
    (can-tab h3 s4) (can-tab s3 h4)
    (can-tab h4 s5) (can-tab s4 h5)
    (can-tab h5 s6) (can-tab s5 h6)
    (can-tab h6 s7) (can-tab s6 h7)
    (can-tab h7 s8) (can-tab s7 h8)
    (can-tab h8 s9) (can-tab s8 h9)
    (can-tab h9 s10) (can-tab s9 h10)

    ;; -------- can-fund --------
    (can-fund h2 h1) (can-fund h3 h2) (can-fund h4 h3)
    (can-fund h5 h4) (can-fund h6 h5) (can-fund h7 h6)
    (can-fund h8 h7) (can-fund h9 h8) (can-fund h10 h9)

    (can-fund s2 s1) (can-fund s3 s2) (can-fund s4 s3)
    (can-fund s5 s4) (can-fund s6 s5) (can-fund s7 s6)
    (can-fund s8 s7) (can-fund s9 s8) (can-fund s10 s9)

    ;; ================= Tableau =================

    ;; t1: h4 s6 h7 s9
    (on-t h4 t1)
    (on s6 h4)
    (on h7 s6)
    (on s9 h7)
    (free s9)

    ;; t2: s3 h5 s8 s10 h9
    (on-t s3 t2)
    (on h5 s3)
    (on s8 h5)
    (on s10 s8)
    (on h9 s10)
    (free h9)

    ;; t3: h3 s5 h6 s7
    (on-t h3 t3)
    (on s5 h3)
    (on h6 s5)
    (on s7 h6)
    (free s7)

    ;; t4: s2 h8 s4 h10
    (on-t s2 t4)
    (on h8 s2)
    (on s4 h8)
    (on h10 s4)
    (free h10)

    ;; empty tableau
    (free-t t5)

    ;; -------- stock --------
    (in-stock h1)
    (in-stock h2)
    (in-stock s1)

    ;; -------- foundations --------
    (free-f f1)
    (free-f f2)

    (= (foundation-count f1) 0)
    (= (foundation-count f2) 0)
)

(:goal
(and
    (= (foundation-count f1) 10)
    (= (foundation-count f2) 10)
)
)
)