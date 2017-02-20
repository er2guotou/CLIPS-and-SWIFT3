;;*****************
;;* INITIAL STATE *
;;*****************
(defmodule MAIN (export ?ALL))
;;************************
;;* question input facts *
;;************************


(deftemplate input
(slot questionNum)
(slot questionDescription)
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

(deftemplate characters
(slot name)
(slot description)
(slot certainty (default 100.0)))

(deffacts answer-characters
;;example below:
;;(characters (name lonewolf)(certainty 70) (description description..))
;;(characters (name relationship) (certainty 60) (description description...))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Conclusion-combining - refer to coursenotes (slide35)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;************************
;;* rules for fire       *
;;************************










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
(>= ?f:certainty 20)))
(sort characters-sort ?facts))

