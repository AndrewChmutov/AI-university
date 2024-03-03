(define (problem building-a-tower)
    (:domain world-of-blocks)
    (:objects a b c d e)
    (:init
        (clear a)
        (clear b)
        (clear c)
        (clear d)
        (clear e)
        (on-floor a)
        (on-floor b)
        (on-floor c)
        (on-floor d)
        (on-floor e)
    )
    (:goal
        (and
            (forall (?x) (not (holding ?x)))                        ; nothing is held

            ; there exists only one block that is on the ground
            (exists (?x)
                (and
                    (on-floor ?x)
                    (forall (?y) (imply (on-floor ?y) (= ?y ?x)))
                )
            )
        )
    )
)
