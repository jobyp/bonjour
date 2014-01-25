/* -*- mode: promela -*- */

/*
 Rendezvous problem: Generalize a signal pattern so that
 thread P has to wait for thread Q and vice versa.

 Barrier problem: Generalise the rendezvous problem for
 multiple threads.

*/


inline wait(s)
{
  atomic {
    s > 0;
    s--
  }
}


inline signal(s)
{
  s++
}

#define N 2



#define p (!(P@c0 && Q@c1))

int mutex = 1;
int enter_barrier = 0;
int exit_barrier = 1;


int threads_arrived;
int csp;

active proctype P()
{


  do
    :: true;
c0:    /* Rendezvous 1*/
       skip;
       wait(mutex);
       threads_arrived++;
       if
	 :: (threads_arrived == N) ->
	    wait(exit_barrier);
	    signal(enter_barrier);
	 :: else ->
	    skip
       fi;
       signal(mutex);
  
       wait(enter_barrier);
       signal(enter_barrier);

  /******* DO WORK ***********/
  
c1:    /* Rendezvous 2 */
       skip;

       wait(mutex);
       threads_arrived--;
       if
	 :: (threads_arrived == 0) ->
	    wait(enter_barrier)
	    signal(exit_barrier);

	 :: else ->
	    skip
       fi;
       signal(mutex);
  
       wait(exit_barrier);
       signal(exit_barrier);
c2:
       skip
  od

}



active proctype Q()
{


  do
    :: true;
c0:    /* Rendezvous 1*/
       skip;
       wait(mutex);
       threads_arrived++;
       if
	 :: (threads_arrived == N) ->
	    wait(exit_barrier);
	    signal(enter_barrier);

	 :: else ->
	    skip
       fi;
       signal(mutex);
  
       wait(enter_barrier);
       signal(enter_barrier);

  /******* DO WORK ***********/
  
c1:    /* Rendezvous 2 */
       skip;

       wait(mutex);
       threads_arrived--;
       if
	 :: (threads_arrived == 0) ->
	    wait(enter_barrier)
	    signal(exit_barrier);

	 :: else ->
	    skip
       fi;
       signal(mutex);
  
       wait(exit_barrier);
       signal(exit_barrier);
c2:
       skip
  od

}