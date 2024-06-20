---- MODULE Simple_Election_Ind ----
EXTENDS simple_election

IndAuto ==
    /\ \A VARS \in Acceptor : \A VART \in Acceptor : 
      \A VARPA \in Proposer : \A VARPB \in Proposer : \E VARQ \in Quorum :  
        (ChosenAt(VARQ,VARPB)) \/ ~(VARPB \in leader)
    /\ \A VARS \in Acceptor : \A VART \in Acceptor : 
      \A VARPA \in Proposer : \A VARPB \in Proposer : \E VARQ \in Quorum :  
        \/ (<<VART,VARPA>> \in promise) 
        \/ ~(<<VARS,VARPA>> \in promise) 
        \/ ~(ChosenAt(VARQ,VARPB))
    /\ \A VARS \in Acceptor : \A VART \in Acceptor : 
      \A VARPA \in Proposer : \A VARPB \in Proposer : \E VARQ \in Quorum :  
        (VARPA \in start) \/ ~(ChosenAt(VARQ,VARPA))
    /\ \A VARS \in Acceptor : \A VART \in Acceptor : 
      \A VARPA \in Proposer : \A VARPB \in Proposer : \E VARQ \in Quorum :  
        \/ ((VARPA=VARPB) /\ promise = promise) 
        \/ ~(ChosenAt(VARQ,VARPA)) 
        \/ ~(ChosenAt(VARQ,VARPB))
    /\ \A VARS \in Acceptor : \A VART \in Acceptor : 
      \A VARPA \in Proposer : \A VARPB \in Proposer : \E VARQ \in Quorum :  
        (VARPA \in start) \/ ~(<<VART,VARPA>> \in promise)
    /\ \A VARS \in Acceptor : \A VART \in Acceptor : 
      \A VARPA \in Proposer : \A VARPB \in Proposer : \E VARQ \in Quorum :  
        \/ ((VARPA=VARPB) /\ promise = promise) 
        \/ ~(<<VART,VARPA>> \in promise) 
        \/ ~(<<VART,VARPB>> \in promise)
==== 