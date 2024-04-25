---- MODULE Client_Server ----

EXTENDS Server, Client
VARIABLE locked, held

Init ==
    /\ locked = [i \in Server |-> TRUE]
    /\ held = [i \in Client |-> {}]

Connect(client, server) == 
    /\ locked[server] = TRUE
    /\ held' = [held EXCEPT ![client] = held[client] \cup {server}]
    /\ locked' = [locked EXCEPT ![server] = FALSE]

Disconnect(client, server) ==
    /\ server \in held[client]
    /\ held' = [held EXCEPT ![client] = held[client] \ {server}]
    /\ locked' = [locked EXCEPT ![server] = TRUE]

Next ==
    \/ \E client \in Client, server \in Server: Connect(client, server)
    \/ \E client \in Client, server \in Server: Disconnect(client, server)

Spec == Init /\ [][Next]_<<locked, held>>

Safe == 
    \A client_i, client_j \in Client:
    (held[client_i] \cap held[client_j] # {}) \/ (client_i = client_j)

=============================================================================