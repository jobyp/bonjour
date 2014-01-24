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

#define p (!(P[0]@c0 && P[1]@c1))

#define N 3

int mutex = 1;
int barrier = 0;

int threads_arrived;
int csp;

active [N] proctype P()
{

c0: /* Rendezvous */
  skip;
  wait(mutex);
  threads_arrived++;
  if
    :: (threads_arrived == N) -> signal(barrier)
    :: else -> skip
  fi;
  signal(mutex);
  
  wait(barrier);
  signal(barrier);

c1:
  skip;
}