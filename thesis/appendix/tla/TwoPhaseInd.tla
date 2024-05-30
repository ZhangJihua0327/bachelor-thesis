---- MODULE TwoPhaseInd ----
EXTENDS TwoPhase

IndAuto ==
  /\ TCConsistent
  /\ \A rmi \in RM : \A rmj \in RM :  
    \/ ([type |-> "Commit"] \in msgs) 
    \/ ~(rmState[rmi] = "committed") 
  /\ \A rmi \in RM : \A rmj \in RM :  
    \/ (tmPrepared = tmPrepared \cup {rmi}) 
    \/ ~([type |-> "Commit"] \in msgs) 
  /\ \A rmi \in RM : \A rmj \in RM :  
    \/ ~([type |-> "Commit"] \in msgs) 
    \/ ~(rmState[rmj] = "working") 
  /\ \A rmi \in RM : \A rmj \in RM :  
    \/ ([type |-> "Prepared", rm |-> rmi] \in msgs) 
    \/ ~([type |-> "Commit"] \in msgs) 
  /\ \A rmi \in RM : \A rmj \in RM :  
    \/ ([type |-> "Prepared", rm |-> rmi] \in msgs) 
    \/ ~(tmPrepared = tmPrepared \cup {rmi}) 
  /\ \A rmi \in RM : \A rmj \in RM :  
    \/ (rmState[rmj] = "committed") \/ (rmState[rmj] = "prepared") 
    \/ ~([type |-> "Commit"] \in msgs) 
  /\ \A rmi \in RM : \A rmj \in RM :  
    \/ ~([type |-> "Abort"] \in msgs) 
    \/ ~([type |-> "Commit"] \in msgs) 
  /\ \A rmi \in RM : \A rmj \in RM :  
    \/~([type |-> "Abort"] \in msgs) 
    \/ ~(tmState = "init") 
  /\ \A rmi \in RM : \A rmj \in RM :  
    \/~([type |-> "Commit"] \in msgs) 
    \/ ~(tmState = "init") 
  /\ \A rmi \in RM : \A rmj \in RM :  
    \/ (rmState[rmj] = "prepared") 
    \/ ~([type |-> "Prepared", rm |-> rmj] \in msgs) 
    \/ ~(tmState = "init")
==== 