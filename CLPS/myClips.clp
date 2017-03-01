;;*****************
;;* INITIAL STATE *
;;*****************
(defmodule MAIN (export ?ALL))
;;************************
;;* question input facts *
;;************************


(deftemplate input
(slot questionNum)
;;(slot questionDescription)
;;(multislot questionAnswerList) ;; NO USE
(slot inputnum);; for normalized question may be 1,2,3,4,5;for classify question 1 stand for A ,2 stand for B ....
(slot flag)
)
(deffacts answer-input
;;example below:
;;(input (questionNum 0)(questionDescription "R U lone wolf")(inputnum 1))
)

;;************************
;;* final answer facts   *
;;************************
;;character type definition,in order to caculate percentage of each character
(deftemplate subgoal_certification
(slot degree)
(slot certainty)
)

(deftemplate subgoal_subject-matter-expertise
(slot evaluation)
(slot certainty)
)

(deftemplate subgoal_capability
(slot assessment)
)

(deftemplate characters
(slot name)
(slot certainty)
)

(deftemplate trainproject
(slot name)
(slot certainty)
)

(deftemplate type
(slot name)
(slot weight)
)
(deffacts orgin-type
(type (name RB) (weight 0))
(type (name RP) (weight 0))
(type (name H) (weight 0))
(type (name L) (weight 0))
(type (name C) (weight 0))
(type (name QuestionNUM) (weight 0))
)

(deftemplate lcharacters
(slot name)
;;(slot description)
(slot certainty))

(deftemplate working_characters
(slot name)
;;(slot description)
(slot certainty (default 100.0)))

(deffacts answer-characters
;;example below:
;;(characters (name lonewolf)(certainty 70) (description description..))
;;(characters (name relationship) (certainty 60) (description description...))
;;(working_characters (name RelationshipBuilders) (certainty 0))
;;(working_characters (name ReactiveProblemSolvers) (certainty 0))
;;(working_characters (name HardWorkers) (certainty 0))
;;(working_characters (name LoneWolves) (certainty 0))
;;(working_characters (name Challengers) (certainty 0))
)



(deftemplate cont
(slot contnum))
(deffacts originalcont
(cont (contnum 0))
)


;;************************
;;* rules for fire       *
;;************************

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Conclusion-combining - refer to coursenotes (slide35)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule combine-positive-cf-rule1
?f1 <- (lcharacters (name ?name)(certainty ?certainty1&:(>= ?certainty1 0)))
?f2 <- (working_characters (name ?name)(certainty ?certainty2&:(>= ?certainty2 0)))
?u<-(cont (contnum ?con))
=>
(modify ?u (contnum (+ ?con 1))
)
(retract ?f2)
(modify ?f1 (certainty =(+ ?certainty1 (* ?certainty2 (- 1 ?certainty1)))))
)


(defrule RULE-DECISION-TREE-1-rule23
(input (questionNum 8) (inputnum 1) (flag 1))
=>(assert (working_characters (name RelationshipBuilders)(certainty 0.43)))
)

(defrule RULE-DECISION-TREE-2-rule24
(not (input (questionNum 8) (inputnum 1) (flag 1)))
(or (input (questionNum 17) (inputnum 4) (flag 0)) (input (questionNum 17) (inputnum 5) (flag 0)))
=>(assert (working_characters (name RelationshipBuilders)(certainty 0.16)))
)

(defrule RULE-DECISION-TREE-3-rule25
(or (input (questionNum 17) (inputnum 1) (flag 0)) (input (questionNum 17) (inputnum 3) (flag 0)) (input (questionNum 17) (inputnum 5) (flag 0))
)
=>(assert (working_characters (name ReactiveProblemSolvers)(certainty 0.43)))
)

(defrule RULE-DECISION-TREE-4-rule26
(or (input (questionNum 17) (inputnum 2) (flag 0)) (input (questionNum 17) (inputnum 4) (flag 0))
)
(input (questionNum 4)(inputnum 1)(flag 1))
=>(assert (working_characters (name ReactiveProblemSolvers)(certainty 0.34)))
)

(defrule RULE-DECISION-TREE-5-rule27
(or (input (questionNum 15) (inputnum 1) (flag 0)) (input (questionNum 15) (inputnum 2) (flag 0)) (input (questionNum 15) (inputnum 4) (flag 0))
)
(input (questionNum 14)(inputnum 2)(flag 0))
=>(assert (working_characters (name HardWorkers)(certainty 0.45)))
)

(defrule RULE-DECISION-TREE-6-rule28
(or (input (questionNum 13) (inputnum 3) (flag 0)) (input (questionNum 13) (inputnum 4) (flag 0))
)
(not (input (questionNum 18)(inputnum 2)(flag 0))
)
=>(assert (working_characters (name HardWorkers)(certainty 0.32)))
)

(defrule RULE-DECISION-TREE-7-rule29
(or (input (questionNum 7) (inputnum 2) (flag 1)) (input (questionNum 7) (inputnum 3) (flag 0))
)
(not (input (questionNum 12)(inputnum 2)(flag 1))
)
=>(assert (working_characters (name HardWorkers)(certainty 0.39)))
)

(defrule RULE-2-rule7
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 2) (inputnum ?ans)(flag 0))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pRP(weight (+ ?RPweight 1)))
(modify ?pH(weight (+ ?Hweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 2) (inputnum 1) (flag 1)))
)

(case 2 then (modify ?pH(weight (+ ?Hweight 1)))
(modify ?pL(weight (+ ?Lweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 2) (inputnum 2) (flag 1)))
)

(case 3 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pRP(weight (+ ?RPweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 2) (inputnum 3) (flag 1)))
)

(case 4 then (modify ?pH(weight (+ ?Hweight 1)))
(modify ?pL(weight (+ ?Lweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 2) (inputnum 4) (flag 1)))
)

)
)

(defrule RULE-3-rule8
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 3) (inputnum ?ans)(flag 0))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pRP(weight (+ ?RPweight 1)))
(modify ?pH(weight (+ ?Hweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 3) (inputnum 1) (flag 1)))
)

(case 2 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pRP(weight (+ ?RPweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 3) (inputnum 2) (flag 1)))
)

(case 3 then (modify ?pRP(weight (+ ?RPweight 1)))
(modify ?pH(weight (+ ?Hweight 1)))
(modify ?pL(weight (+ ?Lweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 3) (inputnum 3) (flag 1)))
)

)
)

(defrule RULE-4-rule9
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 4) (inputnum ?ans)(flag 0))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pL(weight (+ ?Lweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 4) (inputnum 1) (flag 1)))
)

(case 2 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 4) (inputnum 2) (flag 1)))
)

(case 3 then (modify ?pRP(weight (+ ?RPweight 1)))
(modify ?pH(weight (+ ?Hweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 4) (inputnum 3) (flag 1)))
)

)
)

(defrule RULE-5-rule10
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 5) (inputnum ?ans)(flag 0))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 5) (inputnum 1) (flag 1)))
)

(case 2 then (modify ?pH(weight (+ ?Hweight 1)))
(modify ?pL(weight (+ ?Lweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 5) (inputnum 2) (flag 1)))
)

(case 3 then (modify ?pH(weight (+ ?Hweight 1)))
(modify ?pL(weight (+ ?Lweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 5) (inputnum 3) (flag 1)))
)

)
)

(defrule RULE-6-rule11
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 6) (inputnum ?ans)(flag 0))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pH(weight (+ ?Hweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 6) (inputnum 1) (flag 1)))
)

(case 2 then (modify ?pRP(weight (+ ?RPweight 1)))
(modify ?pL(weight (+ ?Lweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 6) (inputnum 2) (flag 1)))
)

(case 3 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pRP(weight (+ ?RPweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 6) (inputnum 3) (flag 1)))
)

(case 4 then (modify ?pL(weight (+ ?Lweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 6) (inputnum 4) (flag 1)))
)

)
)

(defrule RULE-7-rule12
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 7) (inputnum ?ans)(flag 0))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pL(weight (+ ?Lweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 7) (inputnum 1) (flag 1)))
)

(case 2 then (modify ?pH(weight (+ ?Hweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 7) (inputnum 2) (flag 1)))
)

(case 3 then (modify ?pC(weight (+ ?Cweight 1)))
(modify ?pL(weight (+ ?Lweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 7) (inputnum 3) (flag 1)))
)

(case 4 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pRP(weight (+ ?RPweight 1)))
(modify ?pH(weight (+ ?Hweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 7) (inputnum 4) (flag 1)))
)

)
)

(defrule RULE-8-rule13
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 8) (inputnum ?ans)(flag 0))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pH(weight (+ ?Hweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 8) (inputnum 1) (flag 1)))
)

(case 2 then (modify ?pRP(weight (+ ?RPweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 8) (inputnum 2) (flag 1)))
)

(case 3 then (modify ?pC(weight (+ ?Cweight 1)))
(modify ?pL(weight (+ ?Lweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 8) (inputnum 3) (flag 1)))
)

)
)

(defrule RULE-9-rule14
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 9) (inputnum ?ans)(flag 0))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pL(weight (+ ?Lweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 9) (inputnum 1) (flag 1)))
)

(case 2 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pH(weight (+ ?Hweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 9) (inputnum 2) (flag 1)))
)

(case 3 then (modify ?pC(weight (+ ?Cweight 1)))
(modify ?pH(weight (+ ?Hweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 9) (inputnum 3) (flag 1)))
)

)
)

(defrule RULE-10-rule15
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 10) (inputnum ?ans)(flag 0))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pL(weight (+ ?Lweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 10) (inputnum 1) (flag 1)))
)

(case 2 then (modify ?pC(weight (+ ?Cweight 1)))
(modify ?pH(weight (+ ?Hweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 10) (inputnum 2) (flag 1)))
)

(case 3 then (modify ?pH(weight (+ ?Hweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 10) (inputnum 3) (flag 1)))
)

(case 4 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 10) (inputnum 4) (flag 1)))
)

)
)

(defrule RULE-12-rule16
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 12) (inputnum ?ans)(flag 0))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pL(weight (+ ?Lweight 1)))
(modify ?pC(weight (+ ?Cweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 12) (inputnum 1) (flag 1)))
)

(case 2 then (modify ?pC(weight (+ ?Cweight 1)))
(modify ?pH(weight (+ ?Hweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 12) (inputnum 2) (flag 1)))
)

(case 3 then (modify ?pRB(weight (+ ?RBweight 1)))
(modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
(assert (input (questionNum 12) (inputnum 3) (flag 1)))
)

)
)


(defrule RULE-14-rule17
?pQ<-(type (name QuestionNUM)(weight 10))
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
=>
(assert (working_characters (name RelationshipBuilders)(certainty (/ ?RBweight 10)))
(working_characters (name ReactiveProblemSolvers)(certainty (/ ?RPweight 10)))
(working_characters (name HardWorkers)(certainty (/ ?Hweight 10)))
(working_characters (name LoneWolves)(certainty (/ ?Lweight 10)))
(working_characters (name Challengers)(certainty (/ ?Cweight 10)))
)
(retract ?pQ)
)


;;(modify ?cRB(certainty (/ ?RBweight 10)))
;;(modify ?cRP(certainty (/ ?RPweight 10)))
;;(modify ?cH(certainty (/ ?Hweight 10)))
;;(modify ?cL(certainty (/ ?Lweight 10)))
;;(modify ?cC(certainty (/ ?Cweight 10)))



(defrule RULE-15-rule18
?u<-(input (questionNum 15) (inputnum ?ans)(flag 0))
=>(assert (lcharacters (name RelationshipBuilders) (certainty (/ (* ?ans 20) 100)))
(input (questionNum 15) (inputnum ?ans)(flag 1))
)
(retract ?u)
)

(defrule RULE-16-rule19
?u<-(input (questionNum 16) (inputnum ?ans)(flag 0))
=>(assert (lcharacters (name ReactiveProblemSolvers) (certainty (/ (* ?ans 20) 100)))
(input (questionNum 16) (inputnum ?ans)(flag 1))
)
(retract ?u)
)

(defrule RULE-17-rule20
?u<-(input (questionNum 17) (inputnum ?ans)(flag 0))
=>(assert (lcharacters (name HardWorkers) (certainty (/ (* ?ans 20) 100)))
(input (questionNum 17) (inputnum ?ans)(flag 1))
)
(retract ?u)
)

(defrule RULE-18-rule21
?u<-(input (questionNum 18) (inputnum ?ans)(flag 0))
=>(assert (lcharacters (name LoneWolves) (certainty (/ (* ?ans 20) 100)))
(input (questionNum 18) (inputnum ?ans)(flag 1))
)
(retract ?u)
)

(defrule RULE-19-rule22
?u<-(input (questionNum 19) (inputnum ?ans)(flag 0))
=>(assert (lcharacters (name Challengers) (certainty (/ (* ?ans 20) 100)))
(input (questionNum 19) (inputnum ?ans)(flag 1))
)
(retract ?u)
)








(defrule questions-certification-high-rule30
(input (questionNum 21)(inputnum ?ans-21))
(input (questionNum 22)(inputnum ?ans-22))
(input (questionNum 23)(inputnum ?ans-23))
=>
(if (> (+ ?ans-21 ?ans-22 ?ans-23) 6) then
(assert (subgoal_certification (degree high)(certainty 0.5))
)
)
)

(defrule questions-certification-median-rule31
(input (questionNum 21)(inputnum ?ans-21))
(input (questionNum 22)(inputnum ?ans-22))
(input (questionNum 23)(inputnum ?ans-23))
=>
(if (eq (+ ?ans-21 ?ans-22 ?ans-23) 6) then
(assert (subgoal_certification (degree median)(certainty 0))
)
)
)

(defrule questions-certification-low-rule32
(input (questionNum 21)(inputnum ?ans-21))
(input (questionNum 22)(inputnum ?ans-22))
(input (questionNum 23)(inputnum ?ans-23))
=>
(if (< (+ ?ans-21 ?ans-22 ?ans-23) 6) then
(assert (subgoal_certification (degree low)(certainty -0.5))
)
)
)



(defrule questions-subject-matter-expertise-lessbenificial-rule33
(input (questionNum 24)(inputnum ?ans))
(subgoal_certification (degree ?degree)(certainty ?cert))
=>
(if (<= (+ ?ans ?cert) 1.5) then
(assert (subgoal_subject-matter-expertise (evaluation lessbenificial)(certainty (+ ?ans ?cert))))
)
)
)

(defrule questions-subject-matter-expertise-moderatelybenificial-1-rule34
(input (questionNum 24)(inputnum 3))
(subgoal_certification (degree low) (certainty ?cert))
=>
(assert (subgoal_subject-matter-expertise (evaluation moderatelybenificial)(certainty (+ ?cert 3))))
)

(defrule questions-subject-matter-expertise-moderatelybenificial-2-rule35
(input (questionNum 24)(inputnum 2))
(subgoal_certification (degree median) (certainty ?cert))
=>
(assert (subgoal_subject-matter-expertise (evaluation moderatelybenificial)(certainty (+ ?cert 2))))
)

(defrule questions-subject-matter-expertise-moderatelybenificial-3-rule36
(input (questionNum 24)(inputnum 3))
(subgoal_certification (degree median) (certainty ?cert))
=>
(assert (subgoal_subject-matter-expertise (evaluation moderatelybenificial)(certainty (+ ?cert 3))))
)

(defrule questions-subject-matter-expertise-moderatelybenificial-4-rule37
(input (questionNum 24)(inputnum 2))
(subgoal_certification (degree high) (certainty ?cert))
=>
(assert (subgoal_subject-matter-expertise (evaluation moderatelybenificial)(certainty (+ ?cert 2))))
)

(defrule questions-subject-matter-expertise-highlybenificial-rule38
(input (questionNum 24)(inputnum ?ans))
(subgoal_certification (degree ?degree)(certainty ?cert))
=>
(if (>= (+ ?ans ?cert) 3.5) then
(assert (subgoal_subject-matter-expertise (evaluation highlybenificial)(certainty (+ ?ans ?cert))))
)
)
)

(defrule questions-capability-rule39
(or (input (questionNum 25) (inputnum 1)) (input (questionNum 25)(inputnum 2)))
(or (subgoal_subject-matter-expertise (evaluation highlybenificial)) (subgoal_subject-matter-expertise (evaluation moderatelybenificial)))
=>
(assert (subgoal_capability (assessment proficient))
)
)

(defrule questions-capability-rule40
(input (questionNum 25) (inputnum 3))
(subgoal_subject-matter-expertise (evaluation highlybenificial))
=>
(assert (subgoal_capability (assessment proficient))
)
)

(defrule questions-capability-rule41
(or (input (questionNum 25) (inputnum 1)) (input (questionNum 25)(inputnum 2)) (input (questionNum 25)(inputnum 3)))
(subgoal_subject-matter-expertise (evaluation lessbenificial))
=>
(assert (subgoal_capability (assessment apprentice))
)
)

(defrule questions-capability-rule42
(input (questionNum 25) (inputnum 3))
(subgoal_subject-matter-expertise (evaluation moderatelybenificial))
=>
(assert (subgoal_capability (assessment apprentice))
)
)

(defrule ZFinal_goals-rule43
;;(or (mostcharacters (name RelationshipBuilders)) (mostcharacters (name ReactiveProblemSolvers)))
(lcharacters (name RelationshipBuilders)(certainty ?rb))
(lcharacters (name ReactiveProblemSolvers)(certainty ?rp))
(lcharacters (name HardWorkers)(certainty ?h))
(lcharacters (name LoneWolves)(certainty ?l))
(lcharacters (name Challengers)(certainty ?c))
(subgoal_capability (assessment proficient))
=>
(bind ?max (max ?rb ?rp ?h ?l ?c))
(if (eq ?max ?rb) then
(assert (trainproject (name train1)(certainty 1))
(characters (name RelationshipBuilders)(certainty ?rb))
)
)
)

(defrule ZFinal_goals-rule44
;;(or (mostcharacters (name RelationshipBuilders)) (mostcharacters (name ReactiveProblemSolvers)))
(lcharacters (name RelationshipBuilders)(certainty ?rb))
(lcharacters (name ReactiveProblemSolvers)(certainty ?rp))
(lcharacters (name HardWorkers)(certainty ?h))
(lcharacters (name LoneWolves)(certainty ?l))
(lcharacters (name Challengers)(certainty ?c))
(subgoal_capability (assessment proficient))
=>
(bind ?max (max ?rb ?rp ?h ?l ?c))
(if (eq ?max ?rp) then
(assert (trainproject (name train1)(certainty 1))
(characters (name ReactiveProblemSolvers)(certainty ?rp))
)
)
)

(defrule ZFinal_goals-rule45
;;(or (mostcharacters (name RelationshipBuilders)) (mostcharacters (name ReactiveProblemSolvers)))
(lcharacters (name RelationshipBuilders)(certainty ?rb))
(lcharacters (name ReactiveProblemSolvers)(certainty ?rp))
(lcharacters (name HardWorkers)(certainty ?h))
(lcharacters (name LoneWolves)(certainty ?l))
(lcharacters (name Challengers)(certainty ?c))
(subgoal_capability (assessment apprentice))
=>
(bind ?max (max ?rb ?rp ?h ?l ?c))
(if (eq ?max ?rb) then
(assert (trainproject (name train1)(certainty 1))
(trainproject (name train3)(certainty 1))
(characters (name RelationshipBuilders)(certainty ?rb))
)
)
)

(defrule ZFinal_goals-rule46
;;(or (mostcharacters (name RelationshipBuilders)) (mostcharacters (name ReactiveProblemSolvers)))
(lcharacters (name RelationshipBuilders)(certainty ?rb))
(lcharacters (name ReactiveProblemSolvers)(certainty ?rp))
(lcharacters (name HardWorkers)(certainty ?h))
(lcharacters (name LoneWolves)(certainty ?l))
(lcharacters (name Challengers)(certainty ?c))
(subgoal_capability (assessment apprentice))
=>
(bind ?max (max ?rb ?rp ?h ?l ?c))
(if (eq ?max ?rp) then
(assert (trainproject (name train1)(certainty 1))
(trainproject (name train3)(certainty 1))
(characters (name ReactiveProblemSolvers)(certainty ?rp))
)
)
)

(defrule ZFinal_goals-rule47
;;(mostcharacters (name Challengers))
(lcharacters (name RelationshipBuilders)(certainty ?rb))
(lcharacters (name ReactiveProblemSolvers)(certainty ?rp))
(lcharacters (name HardWorkers)(certainty ?h))
(lcharacters (name LoneWolves)(certainty ?l))
(lcharacters (name Challengers)(certainty ?c))
(subgoal_capability (assessment proficient))
=>
(bind ?max (max ?rb ?rp ?h ?l ?c))
(if (eq ?max ?c) then
(assert (trainproject (name train2)(certainty 1))
(characters (name Challengers)(certainty ?c))
)
)
)

(defrule ZFinal_goals-rule48
;;(mostcharacters (name Challengers))
(lcharacters (name RelationshipBuilders)(certainty ?rb))
(lcharacters (name ReactiveProblemSolvers)(certainty ?rp))
(lcharacters (name HardWorkers)(certainty ?h))
(lcharacters (name LoneWolves)(certainty ?l))
(lcharacters (name Challengers)(certainty ?c))
(subgoal_capability (assessment apprentice))
=>
(bind ?max (max ?rb ?rp ?h ?l ?c))
(if (eq ?max ?c) then
(assert (trainproject (name train3)(certainty 1))
(characters (name Challengers)(certainty ?c))
)
)
)

(defrule ZFinal_goals-rule49
;;(mostcharacters (name LoneWolves))
(lcharacters (name RelationshipBuilders)(certainty ?rb))
(lcharacters (name ReactiveProblemSolvers)(certainty ?rp))
(lcharacters (name HardWorkers)(certainty ?h))
(lcharacters (name LoneWolves)(certainty ?l))
(lcharacters (name Challengers)(certainty ?c))
(subgoal_capability (assessment proficient))
=>
(bind ?max (max ?rb ?rp ?h ?l ?c))
(if (eq ?max ?l) then
(assert (trainproject (name train2)(certainty 1))
(characters (name LoneWolves)(certainty ?l))
)
)
)

(defrule ZFinal_goals-rule50
;;(mostcharacters (name LoneWolves))
(lcharacters (name RelationshipBuilders)(certainty ?rb))
(lcharacters (name ReactiveProblemSolvers)(certainty ?rp))
(lcharacters (name HardWorkers)(certainty ?h))
(lcharacters (name LoneWolves)(certainty ?l))
(lcharacters (name Challengers)(certainty ?c))
(subgoal_capability (assessment apprentice))
=>
(bind ?max (max ?rb ?rp ?h ?l ?c))
(if (eq ?max ?l) then
(assert (trainproject (name train4)(certainty 1))
(characters (name LoneWolves)(certainty ?l))
)
)
)

(defrule ZFinal_goals-rule51
;;(mostcharacters (name HardWorkers))
(lcharacters (name RelationshipBuilders)(certainty ?rb))
(lcharacters (name ReactiveProblemSolvers)(certainty ?rp))
(lcharacters (name HardWorkers)(certainty ?h))
(lcharacters (name LoneWolves)(certainty ?l))
(lcharacters (name Challengers)(certainty ?c))
(subgoal_capability (assessment proficient))
=>
(bind ?max (max ?rb ?rp ?h ?l ?c))
(if (eq ?max ?h) then
(assert (trainproject (name train1)(certainty 1))
(trainproject (name train2)(certainty 1))
(characters (name HardWorkers)(certainty ?h))
)
)
)

(defrule ZFinal_goals-rule52
;;(mostcharacters (name HardWorkers))
(lcharacters (name RelationshipBuilders)(certainty ?rb))
(lcharacters (name ReactiveProblemSolvers)(certainty ?rp))
(lcharacters (name HardWorkers)(certainty ?h))
(lcharacters (name LoneWolves)(certainty ?l))
(lcharacters (name Challengers)(certainty ?c))
(subgoal_capability (assessment apprentice))
=>
(bind ?max (max ?rb ?rp ?h ?l ?c))
(if (eq ?max ?h) then
(assert (trainproject (name train1)(certainty 1))
(trainproject (name train2)(certainty 1))
(trainproject (name train3)(certainty 1))
(characters (name HardWorkers)(certainty ?h))
)
)
)


;;************************
;;* export module        *
;;************************

(defmodule SALESMAN (import MAIN ?ALL)
(export deffunction get-characters-list)
(export deffunction get-train-list))












;;************************
;;* export functions     *
;;************************
(deffunction SALESMAN::characters-sort (?w1 ?w2)
(< (fact-slot-value ?w1 certainty)
(fact-slot-value ?w2 certainty)))

(deffunction SALESMAN::get-characters-list ()
(bind ?facts (find-all-facts ((?f lcharacters))
(>= ?f:certainty 0.2)))
(sort characters-sort ?facts))

(deffunction SALESMAN::get-train-list ()
(bind ?facts (find-all-facts ((?f trainproject))
(>= ?f:certainty 0)))
(sort characters-sort ?facts))
