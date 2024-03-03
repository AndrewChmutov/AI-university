(define
    (domain world-of-blocks)
    (:predicates
        (on-top ?x ?y)  ;x is on y
        (on-floor ?x)   ;x is on floor
        (clear ?x)      ;nothing is above x
        (holding ?x)    ;holding is block x
    )

    ; take x from floor
    (:action
        pickup-from-floor
            :parameters (?x)
            :precondition
            (and
                (forall (?y) (not (holding ?y)))    ; nothing should be held at the same time
                (clear ?x)                          ; x should have nothing above
                (on-floor ?x)                       ; pick x from floor
            )
            :effect
            (and
                (holding ?x)                        ; take x
                (not (clear ?x))
                (not (on-floor ?x))                 ; x is now not on floor
            )
    )

    ; put x on floor
    (:action
        putdown-to-floor
            :parameters (?x)
            :precondition
            (and
                (holding ?x)                        ; if the x is being held
            )
            :effect
            (and
                (not (holding ?x))                  ; put x
                (clear ?x)                          ; x has nothing above
                (on-floor ?x)                       ; x is now on floor
            )
    )

    ; put y on x
    (:action
        putdown-to-block
            :parameters (?x ?y)
            :precondition
            (and
                (holding ?y)                        ; if x is being held
                (clear ?x)                          ; x should have nothing above
            )
            :effect
            (and
                (not (holding ?y))                  ; put x
                (clear ?y)
                (not (clear ?x))                    ; now x has y above
                (on-top ?y ?x)                      ; y is on top of x
            )
    )

    ; take y from block x
    (:action
        pickup-from-block
        :parameters (?x ?y)
        :precondition
        (and
            (forall (?z) (not (holding ?z)))        ; nothing should be held at the same time
            (on-top ?y ?x)                          ; y has to be on x
            (clear ?y)                              ; y should have nothing above
        )
        :effect
        (and
            (holding ?y)                            ; y is now held
            (not (on-top ?y ?x))                    ; y is now not on x
            (not (clear ?y))
            (clear ?x)                              ; x has nothing above
        )
    )
)
