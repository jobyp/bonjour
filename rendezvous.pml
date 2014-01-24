/* -*- mode: promela -*- */

/*
 Problem statement: Generalize a signal pattern so that
 thread P has to wait for thread Q and vice versa.
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

#define p (!((P@c0 && Q@c1) || (P@c1 && Q@c0)))


int p_arrived = 0;
int q_arrived = 0;

active proctype P()
{
c0:
  printf("P stmt 1\n");
  signal(p_arrived);
  wait(q_arrived);
c1:
  printf("P stmt 2\n")
}

active proctype Q()
{
c0:
  printf("Q stmt 1\n");
  signal(q_arrived);
  wait(p_arrived);
c1:
  printf("Q stmt 2\n")
}