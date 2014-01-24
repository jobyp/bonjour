/* -*- mode: promela -*- */

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

#define p (critical <= 1)

byte sem = 1;
int critical;

active [3] proctype P()
{
  do
    :: wait(sem);
       critical++;
       critical--;
       signal(sem)
  od
}

