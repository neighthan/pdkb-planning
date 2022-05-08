(define (domain corridor)

  (:requirements :conditional-effects :strips)

  (:predicates
    (not_at_l1)
    (not_at_l2)
    (not_at_l3)
    (not_at_l4)
    (not_exists_a)
    (not_exists_b)
    (not_exists_c)
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
    (exists_a)
    (exists_b)
    (exists_c)
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
      (at start (not_at_l1))  ; #11856: <==commonly_known== 53422 (neg)
      (at start (not (at_l1)))  ; #53422: origin
      (at end (at_l1))  ; #53422: origin
      (at end (not (not_at_l1)))  ; #11856: <==negation-removal== 53422 (pos)
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
      (at start (not_at_l2))  ; #42548: <==commonly_known== 92041 (neg)
      (at start (not (at_l2)))  ; #92041: origin
      (at end (at_l1))  ; #53422: origin
      (at end (not (not_at_l1)))  ; #11856: <==negation-removal== 53422 (pos)
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
      (at start (not_at_l3))  ; #25325: <==commonly_known== 35450 (neg)
      (at start (not (at_l3)))  ; #35450: origin
      (at end (at_l1))  ; #53422: origin
      (at end (not (not_at_l1)))  ; #11856: <==negation-removal== 53422 (pos)
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
      (at start (not_at_l4))  ; #99830: <==commonly_known== 18377 (neg)
      (at start (not (at_l4)))  ; #18377: origin
      (at end (at_l1))  ; #53422: origin
      (at end (not (not_at_l1)))  ; #11856: <==negation-removal== 53422 (pos)
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
      (at start (not_at_l1))  ; #11856: <==commonly_known== 53422 (neg)
      (at start (not (at_l1)))  ; #53422: origin
      (at end (at_l2))  ; #92041: origin
      (at end (not (not_at_l2)))  ; #42548: <==negation-removal== 92041 (pos)
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
      (at start (not_at_l2))  ; #42548: <==commonly_known== 92041 (neg)
      (at start (not (at_l2)))  ; #92041: origin
      (at end (at_l2))  ; #92041: origin
      (at end (not (not_at_l2)))  ; #42548: <==negation-removal== 92041 (pos)
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
      (at start (not_at_l3))  ; #25325: <==commonly_known== 35450 (neg)
      (at start (not (at_l3)))  ; #35450: origin
      (at end (at_l2))  ; #92041: origin
      (at end (not (not_at_l2)))  ; #42548: <==negation-removal== 92041 (pos)
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
      (at start (not_at_l4))  ; #99830: <==commonly_known== 18377 (neg)
      (at start (not (at_l4)))  ; #18377: origin
      (at end (at_l2))  ; #92041: origin
      (at end (not (not_at_l2)))  ; #42548: <==negation-removal== 92041 (pos)
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
      (at start (not_at_l1))  ; #11856: <==commonly_known== 53422 (neg)
      (at start (not (at_l1)))  ; #53422: origin
      (at end (at_l3))  ; #35450: origin
      (at end (not (not_at_l3)))  ; #25325: <==negation-removal== 35450 (pos)
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
      (at start (not_at_l2))  ; #42548: <==commonly_known== 92041 (neg)
      (at start (not (at_l2)))  ; #92041: origin
      (at end (at_l3))  ; #35450: origin
      (at end (not (not_at_l3)))  ; #25325: <==negation-removal== 35450 (pos)
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
      (at start (not_at_l3))  ; #25325: <==commonly_known== 35450 (neg)
      (at start (not (at_l3)))  ; #35450: origin
      (at end (at_l3))  ; #35450: origin
      (at end (not (not_at_l3)))  ; #25325: <==negation-removal== 35450 (pos)
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
      (at start (not_at_l4))  ; #99830: <==commonly_known== 18377 (neg)
      (at start (not (at_l4)))  ; #18377: origin
      (at end (at_l3))  ; #35450: origin
      (at end (not (not_at_l3)))  ; #25325: <==negation-removal== 35450 (pos)
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
      (at start (not_at_l1))  ; #11856: <==commonly_known== 53422 (neg)
      (at start (not (at_l1)))  ; #53422: origin
      (at end (at_l4))  ; #18377: origin
      (at end (not (not_at_l4)))  ; #99830: <==negation-removal== 18377 (pos)
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
      (at start (not_at_l2))  ; #42548: <==commonly_known== 92041 (neg)
      (at start (not (at_l2)))  ; #92041: origin
      (at end (at_l4))  ; #18377: origin
      (at end (not (not_at_l4)))  ; #99830: <==negation-removal== 18377 (pos)
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
      (at start (not_at_l3))  ; #25325: <==commonly_known== 35450 (neg)
      (at start (not (at_l3)))  ; #35450: origin
      (at end (at_l4))  ; #18377: origin
      (at end (not (not_at_l4)))  ; #99830: <==negation-removal== 18377 (pos)
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
      (at start (not_at_l4))  ; #99830: <==commonly_known== 18377 (neg)
      (at start (not (at_l4)))  ; #18377: origin
      (at end (at_l4))  ; #18377: origin
      (at end (not (not_at_l4)))  ; #99830: <==negation-removal== 18377 (pos)
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
      (at start (not_at_l1))  ; #11856: <==commonly_known== 53422 (neg)
      (at start (not (at_l1)))  ; #53422: origin
      (at end (at_l1))  ; #53422: origin
      (at end (not (not_at_l1)))  ; #11856: <==negation-removal== 53422 (pos)
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
      (at start (not_at_l1))  ; #11856: <==commonly_known== 53422 (neg)
      (at start (not (at_l1)))  ; #53422: origin
      (at end (at_l2))  ; #92041: origin
      (at end (not (not_at_l2)))  ; #42548: <==negation-removal== 92041 (pos)
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
      (at start (not_at_l1))  ; #11856: <==commonly_known== 53422 (neg)
      (at start (not (at_l1)))  ; #53422: origin
      (at end (at_l3))  ; #35450: origin
      (at end (not (not_at_l3)))  ; #25325: <==negation-removal== 35450 (pos)
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
      (at start (not_at_l1))  ; #11856: <==commonly_known== 53422 (neg)
      (at start (not (at_l1)))  ; #53422: origin
      (at end (at_l4))  ; #18377: origin
      (at end (not (not_at_l4)))  ; #99830: <==negation-removal== 18377 (pos)
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
      (at start (not_at_l2))  ; #42548: <==commonly_known== 92041 (neg)
      (at start (not (at_l2)))  ; #92041: origin
      (at end (at_l1))  ; #53422: origin
      (at end (not (not_at_l1)))  ; #11856: <==negation-removal== 53422 (pos)
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
      (at start (not_at_l2))  ; #42548: <==commonly_known== 92041 (neg)
      (at start (not (at_l2)))  ; #92041: origin
      (at end (at_l2))  ; #92041: origin
      (at end (not (not_at_l2)))  ; #42548: <==negation-removal== 92041 (pos)
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
      (at start (not_at_l2))  ; #42548: <==commonly_known== 92041 (neg)
      (at start (not (at_l2)))  ; #92041: origin
      (at end (at_l3))  ; #35450: origin
      (at end (not (not_at_l3)))  ; #25325: <==negation-removal== 35450 (pos)
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
      (at start (not_at_l2))  ; #42548: <==commonly_known== 92041 (neg)
      (at start (not (at_l2)))  ; #92041: origin
      (at end (at_l4))  ; #18377: origin
      (at end (not (not_at_l4)))  ; #99830: <==negation-removal== 18377 (pos)
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
      (at start (not_at_l3))  ; #25325: <==commonly_known== 35450 (neg)
      (at start (not (at_l3)))  ; #35450: origin
      (at end (at_l1))  ; #53422: origin
      (at end (not (not_at_l1)))  ; #11856: <==negation-removal== 53422 (pos)
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
      (at start (not_at_l3))  ; #25325: <==commonly_known== 35450 (neg)
      (at start (not (at_l3)))  ; #35450: origin
      (at end (at_l2))  ; #92041: origin
      (at end (not (not_at_l2)))  ; #42548: <==negation-removal== 92041 (pos)
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
      (at start (not_at_l3))  ; #25325: <==commonly_known== 35450 (neg)
      (at start (not (at_l3)))  ; #35450: origin
      (at end (at_l3))  ; #35450: origin
      (at end (not (not_at_l3)))  ; #25325: <==negation-removal== 35450 (pos)
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
      (at start (not_at_l3))  ; #25325: <==commonly_known== 35450 (neg)
      (at start (not (at_l3)))  ; #35450: origin
      (at end (at_l4))  ; #18377: origin
      (at end (not (not_at_l4)))  ; #99830: <==negation-removal== 18377 (pos)
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
      (at start (not_at_l4))  ; #99830: <==commonly_known== 18377 (neg)
      (at start (not (at_l4)))  ; #18377: origin
      (at end (at_l1))  ; #53422: origin
      (at end (not (not_at_l1)))  ; #11856: <==negation-removal== 53422 (pos)
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
      (at start (not_at_l4))  ; #99830: <==commonly_known== 18377 (neg)
      (at start (not (at_l4)))  ; #18377: origin
      (at end (at_l2))  ; #92041: origin
      (at end (not (not_at_l2)))  ; #42548: <==negation-removal== 92041 (pos)
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
      (at start (not_at_l4))  ; #99830: <==commonly_known== 18377 (neg)
      (at start (not (at_l4)))  ; #18377: origin
      (at end (at_l3))  ; #35450: origin
      (at end (not (not_at_l3)))  ; #25325: <==negation-removal== 35450 (pos)
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
      (at start (not_at_l4))  ; #99830: <==commonly_known== 18377 (neg)
      (at start (not (at_l4)))  ; #18377: origin
      (at end (at_l4))  ; #18377: origin
      (at end (not (not_at_l4)))  ; #99830: <==negation-removal== 18377 (pos)
    )
  )

  (:durative-action sense
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (over all (at_l2))
    )

    :effect (and
      (at end (Pa_secret))  ; #72444: <==closure== 87728 (pos)
      (at end (Ba_secret))  ; #87728: origin
      (at end (not (Pa_not_secret)))  ; #21453: <==negation-removal== 87728 (pos)
      (at end (not (Ba_not_secret)))  ; #65331: <==negation-removal== 72444 (pos)
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
      (at end (Pb_secret))  ; #12310: <==closure== 67637 (pos)
      (at end (Bb_secret))  ; #67637: origin
      (at end (not (Bb_not_secret)))  ; #41597: <==negation-removal== 12310 (pos)
      (at end (not (Pb_not_secret)))  ; #56360: <==negation-removal== 67637 (pos)
    )
  )

  (:durative-action shout-2
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (over all (Ba_secret))
      (over all (Pa_secret))
      (over all (at_l2))
    )

    :effect (and
      (at end (Pb_secret))  ; #12310: <==closure== 67637 (pos)
      (at end (Bc_secret))  ; #27689: origin
      (at end (Bb_secret))  ; #67637: origin
      (at end (Pc_secret))  ; #80404: <==closure== 27689 (pos)
      (at end (not (Pc_not_secret)))  ; #17009: <==negation-removal== 27689 (pos)
      (at end (not (Bb_not_secret)))  ; #41597: <==negation-removal== 12310 (pos)
      (at end (not (Pb_not_secret)))  ; #56360: <==negation-removal== 67637 (pos)
      (at end (not (Bc_not_secret)))  ; #83656: <==negation-removal== 80404 (pos)
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
      (at end (Pb_secret))  ; #12310: <==closure== 67637 (pos)
      (at end (Bc_secret))  ; #27689: origin
      (at end (Bb_secret))  ; #67637: origin
      (at end (Pc_secret))  ; #80404: <==closure== 27689 (pos)
      (at end (not (Pc_not_secret)))  ; #17009: <==negation-removal== 27689 (pos)
      (at end (not (Bb_not_secret)))  ; #41597: <==negation-removal== 12310 (pos)
      (at end (not (Pb_not_secret)))  ; #56360: <==negation-removal== 67637 (pos)
      (at end (not (Bc_not_secret)))  ; #83656: <==negation-removal== 80404 (pos)
    )
  )

  (:durative-action shout-4
    :parameters ()
    :duration (= ?duration 1)
    :condition (and
      (over all (at_l4))
      (over all (Ba_secret))
      (over all (Pa_secret))
    )

    :effect (and
      (at end (Bc_secret))  ; #27689: origin
      (at end (Pc_secret))  ; #80404: <==closure== 27689 (pos)
      (at end (not (Pc_not_secret)))  ; #17009: <==negation-removal== 27689 (pos)
      (at end (not (Bc_not_secret)))  ; #83656: <==negation-removal== 80404 (pos)
    )
  )

)