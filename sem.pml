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

int sem = 1;
byte critical;

#define p (critical <= 1)

active [3] proctype P()
{
  do
    :: wait(sem);
       critical++;
       critical--;
       signal(sem)
  od
}
