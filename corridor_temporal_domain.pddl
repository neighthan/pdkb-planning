(define (domain corridor)

  (:requirements :strips :conditional-effects)

  (:predicates
    (not_at_l1)
    (not_at_l2)
    (not_at_l3)
    (not_at_l4)
    (not_secret)
    (not_succ_l1_l1)
    (not_succ_l1_l2)
    (not_succ_l1_l3)
    (not_succ_l1_l4)
    (not_succ_l2_l1)
    (not_succ_l2_l2)
    (not_succ_l2_l3)
    (not_succ_l2_l4)
    (not_succ_l3_l1)
    (not_succ_l3_l2)
    (not_succ_l3_l3)
    (not_succ_l3_l4)
    (not_succ_l4_l1)
    (not_succ_l4_l2)
    (not_succ_l4_l3)
    (not_succ_l4_l4)
    (Ba_not_secret)
    (Ba_secret)
    (Bb_not_secret)
    (Bb_secret)
    (Bc_not_secret)
    (Bc_secret)
    (Pa_not_secret)
    (Pa_secret)
    (Pb_not_secret)
    (Pb_secret)
    (Pc_not_secret)
    (Pc_secret)
    (at_l1)
    (at_l2)
    (at_l3)
    (at_l4)
    (secret)
    (succ_l1_l1)
    (succ_l1_l2)
    (succ_l1_l3)
    (succ_l1_l4)
    (succ_l2_l1)
    (succ_l2_l2)
    (succ_l2_l3)
    (succ_l2_l4)
    (succ_l3_l1)
    (succ_l3_l2)
    (succ_l3_l3)
    (succ_l3_l4)
    (succ_l4_l1)
    (succ_l4_l2)
    (succ_l4_l3)
    (succ_l4_l4)
  )

  (:durative-action left_l1_l1
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l1))
      (over all (succ_l1_l1))
    )

    :effect (and
      (at start (not_at_l1))  ; #73953: <==commonly_known== 59510 (neg)
      (at start (not (at_l1)))  ; #59510: origin
      (at end (at_l1))  ; #59510: origin
      (at end (not (not_at_l1)))  ; #73953: <==negation-removal== 59510 (pos)
    )
  )

  (:durative-action left_l1_l2
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l2))
      (over all (succ_l1_l2))
    )

    :effect (and
      (at start (not_at_l2))  ; #35151: <==commonly_known== 80773 (neg)
      (at start (not (at_l2)))  ; #80773: origin
      (at end (at_l1))  ; #59510: origin
      (at end (not (not_at_l1)))  ; #73953: <==negation-removal== 59510 (pos)
    )
  )

  (:durative-action left_l1_l3
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l3))
      (over all (succ_l1_l3))
    )

    :effect (and
      (at start (not_at_l3))  ; #34431: <==commonly_known== 50170 (neg)
      (at start (not (at_l3)))  ; #50170: origin
      (at end (at_l1))  ; #59510: origin
      (at end (not (not_at_l1)))  ; #73953: <==negation-removal== 59510 (pos)
    )
  )

  (:durative-action left_l1_l4
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l4))
      (over all (succ_l1_l4))
    )

    :effect (and
      (at start (not_at_l4))  ; #29801: <==commonly_known== 29558 (neg)
      (at start (not (at_l4)))  ; #29558: origin
      (at end (at_l1))  ; #59510: origin
      (at end (not (not_at_l1)))  ; #73953: <==negation-removal== 59510 (pos)
    )
  )

  (:durative-action left_l2_l1
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l1))
      (over all (succ_l2_l1))
    )

    :effect (and
      (at start (not_at_l1))  ; #73953: <==commonly_known== 59510 (neg)
      (at start (not (at_l1)))  ; #59510: origin
      (at end (at_l2))  ; #80773: origin
      (at end (not (not_at_l2)))  ; #35151: <==negation-removal== 80773 (pos)
    )
  )

  (:durative-action left_l2_l2
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l2))
      (over all (succ_l2_l2))
    )

    :effect (and
      (at start (not_at_l2))  ; #35151: <==commonly_known== 80773 (neg)
      (at start (not (at_l2)))  ; #80773: origin
      (at end (at_l2))  ; #80773: origin
      (at end (not (not_at_l2)))  ; #35151: <==negation-removal== 80773 (pos)
    )
  )

  (:durative-action left_l2_l3
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l3))
      (over all (succ_l2_l3))
    )

    :effect (and
      (at start (not_at_l3))  ; #34431: <==commonly_known== 50170 (neg)
      (at start (not (at_l3)))  ; #50170: origin
      (at end (at_l2))  ; #80773: origin
      (at end (not (not_at_l2)))  ; #35151: <==negation-removal== 80773 (pos)
    )
  )

  (:durative-action left_l2_l4
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l4))
      (over all (succ_l2_l4))
    )

    :effect (and
      (at start (not_at_l4))  ; #29801: <==commonly_known== 29558 (neg)
      (at start (not (at_l4)))  ; #29558: origin
      (at end (at_l2))  ; #80773: origin
      (at end (not (not_at_l2)))  ; #35151: <==negation-removal== 80773 (pos)
    )
  )

  (:durative-action left_l3_l1
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l1))
      (over all (succ_l3_l1))
    )

    :effect (and
      (at start (not_at_l1))  ; #73953: <==commonly_known== 59510 (neg)
      (at start (not (at_l1)))  ; #59510: origin
      (at end (at_l3))  ; #50170: origin
      (at end (not (not_at_l3)))  ; #34431: <==negation-removal== 50170 (pos)
    )
  )

  (:durative-action left_l3_l2
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l2))
      (over all (succ_l3_l2))
    )

    :effect (and
      (at start (not_at_l2))  ; #35151: <==commonly_known== 80773 (neg)
      (at start (not (at_l2)))  ; #80773: origin
      (at end (at_l3))  ; #50170: origin
      (at end (not (not_at_l3)))  ; #34431: <==negation-removal== 50170 (pos)
    )
  )

  (:durative-action left_l3_l3
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l3))
      (over all (succ_l3_l3))
    )

    :effect (and
      (at start (not_at_l3))  ; #34431: <==commonly_known== 50170 (neg)
      (at start (not (at_l3)))  ; #50170: origin
      (at end (at_l3))  ; #50170: origin
      (at end (not (not_at_l3)))  ; #34431: <==negation-removal== 50170 (pos)
    )
  )

  (:durative-action left_l3_l4
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l4))
      (over all (succ_l3_l4))
    )

    :effect (and
      (at start (not_at_l4))  ; #29801: <==commonly_known== 29558 (neg)
      (at start (not (at_l4)))  ; #29558: origin
      (at end (at_l3))  ; #50170: origin
      (at end (not (not_at_l3)))  ; #34431: <==negation-removal== 50170 (pos)
    )
  )

  (:durative-action left_l4_l1
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l1))
      (over all (succ_l4_l1))
    )

    :effect (and
      (at start (not_at_l1))  ; #73953: <==commonly_known== 59510 (neg)
      (at start (not (at_l1)))  ; #59510: origin
      (at end (at_l4))  ; #29558: origin
      (at end (not (not_at_l4)))  ; #29801: <==negation-removal== 29558 (pos)
    )
  )

  (:durative-action left_l4_l2
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l2))
      (over all (succ_l4_l2))
    )

    :effect (and
      (at start (not_at_l2))  ; #35151: <==commonly_known== 80773 (neg)
      (at start (not (at_l2)))  ; #80773: origin
      (at end (at_l4))  ; #29558: origin
      (at end (not (not_at_l4)))  ; #29801: <==negation-removal== 29558 (pos)
    )
  )

  (:durative-action left_l4_l3
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l3))
      (over all (succ_l4_l3))
    )

    :effect (and
      (at start (not_at_l3))  ; #34431: <==commonly_known== 50170 (neg)
      (at start (not (at_l3)))  ; #50170: origin
      (at end (at_l4))  ; #29558: origin
      (at end (not (not_at_l4)))  ; #29801: <==negation-removal== 29558 (pos)
    )
  )

  (:durative-action left_l4_l4
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l4))
      (over all (succ_l4_l4))
    )

    :effect (and
      (at start (not_at_l4))  ; #29801: <==commonly_known== 29558 (neg)
      (at start (not (at_l4)))  ; #29558: origin
      (at end (at_l4))  ; #29558: origin
      (at end (not (not_at_l4)))  ; #29801: <==negation-removal== 29558 (pos)
    )
  )

  (:durative-action right_l1_l1
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l1))
      (over all (succ_l1_l1))
    )

    :effect (and
      (at start (not_at_l1))  ; #73953: <==commonly_known== 59510 (neg)
      (at start (not (at_l1)))  ; #59510: origin
      (at end (at_l1))  ; #59510: origin
      (at end (not (not_at_l1)))  ; #73953: <==negation-removal== 59510 (pos)
    )
  )

  (:durative-action right_l1_l2
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l1))
      (over all (succ_l1_l2))
    )

    :effect (and
      (at start (not_at_l1))  ; #73953: <==commonly_known== 59510 (neg)
      (at start (not (at_l1)))  ; #59510: origin
      (at end (at_l2))  ; #80773: origin
      (at end (not (not_at_l2)))  ; #35151: <==negation-removal== 80773 (pos)
    )
  )

  (:durative-action right_l1_l3
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l1))
      (over all (succ_l1_l3))
    )

    :effect (and
      (at start (not_at_l1))  ; #73953: <==commonly_known== 59510 (neg)
      (at start (not (at_l1)))  ; #59510: origin
      (at end (at_l3))  ; #50170: origin
      (at end (not (not_at_l3)))  ; #34431: <==negation-removal== 50170 (pos)
    )
  )

  (:durative-action right_l1_l4
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l1))
      (over all (succ_l1_l4))
    )

    :effect (and
      (at start (not_at_l1))  ; #73953: <==commonly_known== 59510 (neg)
      (at start (not (at_l1)))  ; #59510: origin
      (at end (at_l4))  ; #29558: origin
      (at end (not (not_at_l4)))  ; #29801: <==negation-removal== 29558 (pos)
    )
  )

  (:durative-action right_l2_l1
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l2))
      (over all (succ_l2_l1))
    )

    :effect (and
      (at start (not_at_l2))  ; #35151: <==commonly_known== 80773 (neg)
      (at start (not (at_l2)))  ; #80773: origin
      (at end (at_l1))  ; #59510: origin
      (at end (not (not_at_l1)))  ; #73953: <==negation-removal== 59510 (pos)
    )
  )

  (:durative-action right_l2_l2
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l2))
      (over all (succ_l2_l2))
    )

    :effect (and
      (at start (not_at_l2))  ; #35151: <==commonly_known== 80773 (neg)
      (at start (not (at_l2)))  ; #80773: origin
      (at end (at_l2))  ; #80773: origin
      (at end (not (not_at_l2)))  ; #35151: <==negation-removal== 80773 (pos)
    )
  )

  (:durative-action right_l2_l3
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l2))
      (over all (succ_l2_l3))
    )

    :effect (and
      (at start (not_at_l2))  ; #35151: <==commonly_known== 80773 (neg)
      (at start (not (at_l2)))  ; #80773: origin
      (at end (at_l3))  ; #50170: origin
      (at end (not (not_at_l3)))  ; #34431: <==negation-removal== 50170 (pos)
    )
  )

  (:durative-action right_l2_l4
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l2))
      (over all (succ_l2_l4))
    )

    :effect (and
      (at start (not_at_l2))  ; #35151: <==commonly_known== 80773 (neg)
      (at start (not (at_l2)))  ; #80773: origin
      (at end (at_l4))  ; #29558: origin
      (at end (not (not_at_l4)))  ; #29801: <==negation-removal== 29558 (pos)
    )
  )

  (:durative-action right_l3_l1
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l3))
      (over all (succ_l3_l1))
    )

    :effect (and
      (at start (not_at_l3))  ; #34431: <==commonly_known== 50170 (neg)
      (at start (not (at_l3)))  ; #50170: origin
      (at end (at_l1))  ; #59510: origin
      (at end (not (not_at_l1)))  ; #73953: <==negation-removal== 59510 (pos)
    )
  )

  (:durative-action right_l3_l2
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l3))
      (over all (succ_l3_l2))
    )

    :effect (and
      (at start (not_at_l3))  ; #34431: <==commonly_known== 50170 (neg)
      (at start (not (at_l3)))  ; #50170: origin
      (at end (at_l2))  ; #80773: origin
      (at end (not (not_at_l2)))  ; #35151: <==negation-removal== 80773 (pos)
    )
  )

  (:durative-action right_l3_l3
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l3))
      (over all (succ_l3_l3))
    )

    :effect (and
      (at start (not_at_l3))  ; #34431: <==commonly_known== 50170 (neg)
      (at start (not (at_l3)))  ; #50170: origin
      (at end (at_l3))  ; #50170: origin
      (at end (not (not_at_l3)))  ; #34431: <==negation-removal== 50170 (pos)
    )
  )

  (:durative-action right_l3_l4
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l3))
      (over all (succ_l3_l4))
    )

    :effect (and
      (at start (not_at_l3))  ; #34431: <==commonly_known== 50170 (neg)
      (at start (not (at_l3)))  ; #50170: origin
      (at end (at_l4))  ; #29558: origin
      (at end (not (not_at_l4)))  ; #29801: <==negation-removal== 29558 (pos)
    )
  )

  (:durative-action right_l4_l1
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l4))
      (over all (succ_l4_l1))
    )

    :effect (and
      (at start (not_at_l4))  ; #29801: <==commonly_known== 29558 (neg)
      (at start (not (at_l4)))  ; #29558: origin
      (at end (at_l1))  ; #59510: origin
      (at end (not (not_at_l1)))  ; #73953: <==negation-removal== 59510 (pos)
    )
  )

  (:durative-action right_l4_l2
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l4))
      (over all (succ_l4_l2))
    )

    :effect (and
      (at start (not_at_l4))  ; #29801: <==commonly_known== 29558 (neg)
      (at start (not (at_l4)))  ; #29558: origin
      (at end (at_l2))  ; #80773: origin
      (at end (not (not_at_l2)))  ; #35151: <==negation-removal== 80773 (pos)
    )
  )

  (:durative-action right_l4_l3
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l4))
      (over all (succ_l4_l3))
    )

    :effect (and
      (at start (not_at_l4))  ; #29801: <==commonly_known== 29558 (neg)
      (at start (not (at_l4)))  ; #29558: origin
      (at end (at_l3))  ; #50170: origin
      (at end (not (not_at_l3)))  ; #34431: <==negation-removal== 50170 (pos)
    )
  )

  (:durative-action right_l4_l4
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (at start (at_l4))
      (over all (succ_l4_l4))
    )

    :effect (and
      (at start (not_at_l4))  ; #29801: <==commonly_known== 29558 (neg)
      (at start (not (at_l4)))  ; #29558: origin
      (at end (at_l4))  ; #29558: origin
      (at end (not (not_at_l4)))  ; #29801: <==negation-removal== 29558 (pos)
    )
  )

  (:durative-action sense
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (over all (at_l2))
    )

    :effect (and
      (at end (Ba_secret))  ; #59711: origin
      (at end (Pa_secret))  ; #77167: <==closure== 59711 (pos)
      (at end (not (Pa_not_secret)))  ; #19188: <==negation-removal== 59711 (pos)
      (at end (not (Ba_not_secret)))  ; #59385: <==negation-removal== 77167 (pos)
    )
  )

  (:durative-action shout-1
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (over all (Ba_secret))
      (over all (at_l1))
      (over all (Pa_secret))
    )

    :effect (and
      (at end (Pb_secret))  ; #14627: <==closure== 50394 (pos)
      (at end (Bb_secret))  ; #50394: origin
      (at end (not (Pb_not_secret)))  ; #43912: <==negation-removal== 50394 (pos)
      (at end (not (Bb_not_secret)))  ; #82247: <==negation-removal== 14627 (pos)
    )
  )

  (:durative-action shout-2
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (over all (Ba_secret))
      (over all (at_l2))
      (over all (Pa_secret))
    )

    :effect (and
      (at end (Pb_secret))  ; #14627: <==closure== 50394 (pos)
      (at end (Pc_secret))  ; #36903: <==closure== 91840 (pos)
      (at end (Bb_secret))  ; #50394: origin
      (at end (Bc_secret))  ; #91840: origin
      (at end (not (Pc_not_secret)))  ; #38065: <==negation-removal== 91840 (pos)
      (at end (not (Pb_not_secret)))  ; #43912: <==negation-removal== 50394 (pos)
      (at end (not (Bc_not_secret)))  ; #70044: <==negation-removal== 36903 (pos)
      (at end (not (Bb_not_secret)))  ; #82247: <==negation-removal== 14627 (pos)
    )
  )

  (:durative-action shout-3
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (over all (Ba_secret))
      (over all (Pa_secret))
      (over all (at_l3))
    )

    :effect (and
      (at end (Pb_secret))  ; #14627: <==closure== 50394 (pos)
      (at end (Pc_secret))  ; #36903: <==closure== 91840 (pos)
      (at end (Bb_secret))  ; #50394: origin
      (at end (Bc_secret))  ; #91840: origin
      (at end (not (Pc_not_secret)))  ; #38065: <==negation-removal== 91840 (pos)
      (at end (not (Pb_not_secret)))  ; #43912: <==negation-removal== 50394 (pos)
      (at end (not (Bc_not_secret)))  ; #70044: <==negation-removal== 36903 (pos)
      (at end (not (Bb_not_secret)))  ; #82247: <==negation-removal== 14627 (pos)
    )
  )

  (:durative-action shout-4
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (over all (Ba_secret))
      (over all (Pa_secret))
      (over all (at_l4))
    )

    :effect (and
      (at end (Pc_secret))  ; #36903: <==closure== 91840 (pos)
      (at end (Bc_secret))  ; #91840: origin
      (at end (not (Pc_not_secret)))  ; #38065: <==negation-removal== 91840 (pos)
      (at end (not (Bc_not_secret)))  ; #70044: <==negation-removal== 36903 (pos)
    )
  )

)