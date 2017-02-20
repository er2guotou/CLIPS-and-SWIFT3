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
)
(deffacts answer-input
;;example below:
;;(input (questionNum 0)(questionDescription "R U lone wolf")(inputnum 1))

)

;;************************
;;* final answer facts   *
;;************************
;;character type definition,in order to caculate percentage of each character
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

(deftemplate characters
(slot name)
;;(slot description)
(slot certainty (default 100.0)))

(deftemplate working_characters
(slot name)
;;(slot description)
(slot certainty (default 100.0)))

(deffacts answer-characters
;;example below:
;;(characters (name lonewolf)(certainty 70) (description description..))
;;(characters (name relationship) (certainty 60) (description description...))
(working_characters (name RelationshipBuilders) (certainty 0.5))
(working_characters (name ReactiveProblemSolvers) (certainty 0.5))
(working_characters (name HardWorkers) (certainty 0.5))
(working_characters (name LoneWolves) (certainty 0.5))
(working_characters (name Challengers) (certainty 0.5))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Conclusion-combining - refer to coursenotes (slide35)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defrule combine-positive-cf
  ?f1 <- (characters (name ?name)(certainty ?certainty1&:(>= ?certainty1 0)))
  ?f2 <- (working_characters (name ?name)(certainty ?certainty2&:(>= ?certainty2 0)))
  =>
  (retract ?f2)
  (modify ?f1 (certainty =(+ ?certainty1 (* ?certainty2 (- 1 ?certainty1)))))
)



;;************************
;;* rules for fire       *
;;************************

(defrule RULE-Certainty
?pQ<-(type (name QuestionNUM)(weight 10))
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?cRB<-(working_characters (name RelationshipBuilders) (certainty ?RBcertainty))
?cRP<-(working_characters (name ReactiveProblemSolvers) (certainty ?RPcertainty))
?cH<-(working_characters (name HardWorkers) (certainty ?Hcertainty))
?cL<-(working_characters (name LoneWolves) (certainty ?Lcertainty))
?cC<-(working_characters (name Challengers) (certainty ?Ccertainty))
=>
(modify ?cRB(certainty (/ ?RBweight 10)))
(modify ?cRP(certainty (/ ?RPweight 10)))
(modify ?cH(certainty (/ ?Hweight 10)))
(modify ?cL(certainty (/ ?Lweight 10)))
(modify ?cC(certainty (/ ?Cweight 10)))
(retract ?pQ)
)



(defrule RULE-2
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 2) (inputnum ?ans))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pRP(weight (+ ?RPweight 1)))
             (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 2 then (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 3 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pRP(weight (+ ?RPweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 4 then (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

)
)     

(defrule RULE-3
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 3) (inputnum ?ans))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pRP(weight (+ ?RPweight 1)))
             (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 2 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pRP(weight (+ ?RPweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 3 then (modify ?pRP(weight (+ ?RPweight 1)))
             (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

)
)

(defrule RULE-4
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 4) (inputnum ?ans))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 2 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 3 then (modify ?pRP(weight (+ ?RPweight 1)))
             (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

)
)

(defrule RULE-5
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 5) (inputnum ?ans))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 2 then (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 3 then (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

)
)

(defrule RULE-6
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 6) (inputnum ?ans))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 2 then (modify ?pRP(weight (+ ?RPweight 1)))
             (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 3 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pRP(weight (+ ?RPweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 4 then (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

)
)

(defrule RULE-7
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 7) (inputnum ?ans))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 2 then (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 3 then (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 4 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pRP(weight (+ ?RPweight 1)))
             (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

)
)

(defrule RULE-8
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 8) (inputnum ?ans))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 2 then (modify ?pRP(weight (+ ?RPweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 3 then (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

)
)

(defrule RULE-9
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 9) (inputnum ?ans))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 2 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 3 then (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

)
)

(defrule RULE-10
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 10) (inputnum ?ans))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 2 then (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 3 then (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 4 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

)
)

(defrule RULE-12
?pRB<-(type (name RB)(weight ?RBweight))
?pRP<-(type (name RP)(weight ?RPweight))
?pH<-(type (name H)(weight ?Hweight))
?pL<-(type (name L)(weight ?Lweight))
?pC<-(type (name C)(weight ?Cweight))
?pQ<-(type (name QuestionNUM)(weight ?Qweight))
?u<-(input (questionNum 12) (inputnum ?ans))
=>
;;(printout t ?ans)
(switch ?ans

(case 1 then (modify ?pL(weight (+ ?Lweight 1)))
             (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 2 then (modify ?pC(weight (+ ?Cweight 1)))
             (modify ?pH(weight (+ ?Hweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

(case 3 then (modify ?pRB(weight (+ ?RBweight 1)))
             (modify ?pQ(weight (+ ?Qweight 1)))
(retract ?u)
)

)
)

(defrule RULE-15
?u<-(input (questionNum 15) (inputnum ?ans))
=>(assert (characters (name RelationshipBuilders) (certainty (/ (* ?ans 20) 100))))
(retract ?u)
)

(defrule RULE-16
?u<-(input (questionNum 16) (inputnum ?ans))
=>(assert (characters (name ReactiveProblemSolvers) (certainty (/ (* ?ans 20) 100))))
(retract ?u)
)

(defrule RULE-17
?u<-(input (questionNum 17) (inputnum ?ans))
=>(assert (characters (name HardWorkers) (certainty (/ (* ?ans 20) 100))))
(retract ?u)
)

(defrule RULE-18
?u<-(input (questionNum 18) (inputnum ?ans))
=>(assert (characters (name LoneWolves) (certainty (/ (* ?ans 20) 100))))
(retract ?u)
)

(defrule RULE-19
?u<-(input (questionNum 19) (inputnum ?ans))
=>(assert (characters (name Challengers) (certainty (/ (* ?ans 20) 100))))
(retract ?u)
)

;;************************
;;* export module        *
;;************************

(defmodule SALESMAN (import MAIN ?ALL)
(export deffunction get-characters-list))












;;************************
;;* export functions     *
;;************************
(deffunction SALESMAN::characters-sort (?w1 ?w2)
(< (fact-slot-value ?w1 certainty)
(fact-slot-value ?w2 certainty)))

(deffunction SALESMAN::get-characters-list ()
(bind ?facts (find-all-facts ((?f characters))
(>= ?f:certainty 0.2)))
(sort characters-sort ?facts))

