Basic sychronization patterns
-----------------------------

1. Signaling

   fred = sem(1)

   Thread A
   --------
   1. stmt 1
   2. signal(fred). 


   Thread B
   --------
   1. wait(fred).
   2. stmt 1

