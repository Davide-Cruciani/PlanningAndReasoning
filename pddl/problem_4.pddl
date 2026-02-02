(define (problem klondike-4suits)
    (:domain klondike-solitaire)

    (:objects
        t1 t2 t3 t4 t5 t6 t7 - tableau
        f1 f2 f3 f4 - foundation
        h1 h2 h3 h4 h5 h6 h7 h8 h9 h10
        d1 d2 d3 d4 d5 d6 d7 d8 d9 d10
        c1 c2 c3 c4 c5 c6 c7 c8 c9 c10
        s1 s2 s3 s4 s5 s6 s7 s8 s9 s10
        - card
    )

(:init
    ;; -------- min / max --------
    (max-rank h10) (max-rank d10) (max-rank c10) (max-rank s10)
    (min-rank h1)  (min-rank d1)  (min-rank c1)  (min-rank s1)

    ;; -------- can-tab --------
    (can-tab h1 c2) (can-tab h1 s2)
    (can-tab d1 c2) (can-tab d1 s2)
    (can-tab c1 h2) (can-tab c1 d2)
    (can-tab s1 h2) (can-tab s1 d2)

    (can-tab h2 c3) (can-tab h2 s3)
    (can-tab d2 c3) (can-tab d2 s3)
    (can-tab c2 h3) (can-tab c2 d3)
    (can-tab s2 h3) (can-tab s2 d3)

    (can-tab h3 c4) (can-tab h3 s4)
    (can-tab d3 c4) (can-tab d3 s4)
    (can-tab c3 h4) (can-tab c3 d4)
    (can-tab s3 h4) (can-tab s3 d4)

    (can-tab h4 c5) (can-tab h4 s5)
    (can-tab d4 c5) (can-tab d4 s5)
    (can-tab c4 h5) (can-tab c4 d5)
    (can-tab s4 h5) (can-tab s4 d5)

    (can-tab h5 c6) (can-tab h5 s6)
    (can-tab d5 c6) (can-tab d5 s6)
    (can-tab c5 h6) (can-tab c5 d6)
    (can-tab s5 h6) (can-tab s5 d6)

    (can-tab h6 c7) (can-tab h6 s7)
    (can-tab d6 c7) (can-tab d6 s7)
    (can-tab c6 h7) (can-tab c6 d7)
    (can-tab s6 h7) (can-tab s6 d7)

    (can-tab h7 c8) (can-tab h7 s8)
    (can-tab d7 c8) (can-tab d7 s8)
    (can-tab c7 h8) (can-tab c7 d8)
    (can-tab s7 h8) (can-tab s7 d8)

    (can-tab h8 c9) (can-tab h8 s9)
    (can-tab d8 c9) (can-tab d8 s9)
    (can-tab c8 h9) (can-tab c8 d9)
    (can-tab s8 h9) (can-tab s8 d9)

    (can-tab h9 c10) (can-tab h9 s10)
    (can-tab d9 c10) (can-tab d9 s10)
    (can-tab c9 h10) (can-tab c9 d10)
    (can-tab s9 h10) (can-tab s9 d10)

    ;; -------- can-fund --------
    (can-fund h2 h1) (can-fund h3 h2) (can-fund h4 h3)
    (can-fund h5 h4) (can-fund h6 h5) (can-fund h7 h6)
    (can-fund h8 h7) (can-fund h9 h8) (can-fund h10 h9)

    (can-fund c2 c1) (can-fund c3 c2) (can-fund c4 c3)
    (can-fund c5 c4) (can-fund c6 c5) (can-fund c7 c6)
    (can-fund c8 c7) (can-fund c9 c8) (can-fund c10 c9)

    (can-fund d2 d1) (can-fund d3 d2) (can-fund d4 d3)
    (can-fund d5 d4) (can-fund d6 d5) (can-fund d7 d6)
    (can-fund d8 d7) (can-fund d9 d8) (can-fund d10 d9)

    (can-fund s2 s1) (can-fund s3 s2) (can-fund s4 s3)
    (can-fund s5 s4) (can-fund s6 s5) (can-fund s7 s6)
    (can-fund s8 s7) (can-fund s9 s8) (can-fund s10 s9)

    ;; -------- tableau --------
    (on-t h8 t1) (on h9 h8) (on h10 h9) (free h10)
    (on-t c7 t2) (on c8 c7) (on c9 c8) (free c9)
    (on-t d6 t3) (on d7 d6) (on d8 d7) (free d8)
    (on-t s5 t4) (on s6 s5) (on s7 s6) (free s7)

    ;; -------- empty tableau --------
    (free-t t5)
    (free-t t6)
    (free-t t7)

    ;; -------- stock --------
    (in-stock h1) (in-stock h2) (in-stock h3) (in-stock h4)
    (in-stock h5) (in-stock h6) (in-stock h7)

    (in-stock d1) (in-stock d2) (in-stock d3)
    (in-stock d4) (in-stock d5) (in-stock d9) (in-stock d10)

    (in-stock c1) (in-stock c2) (in-stock c3)
    (in-stock c4) (in-stock c5) (in-stock c6) (in-stock c10)

    (in-stock s1) (in-stock s2) (in-stock s3)
    (in-stock s4) (in-stock s8) (in-stock s9) (in-stock s10)

    ;; -------- foundations --------
    (free-f f1) (free-f f2) (free-f f3) (free-f f4)

    (= (foundation-count f1) 0)
    (= (foundation-count f2) 0)
    (= (foundation-count f3) 0)
    (= (foundation-count f4) 0)
)

(:goal
    (and
        (= (foundation-count f1) 10)
        (= (foundation-count f2) 10)
        (= (foundation-count f3) 10)
        (= (foundation-count f4) 10)
    )
)
)
