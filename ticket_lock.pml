/* -*- mode: promela -*- */

/* ticket lock (http://lwn.net/Articles/267968/) */
unsigned owner : 3;
unsigned next : 3;

byte critical;

#define p (critical <= 1)

inline lock(x) {
  atomic {
    x = next;
    next = (next + 1) % 8
  }

  (x == owner)
}


inline release() {
  owner = (owner + 1) % 8
}

active proctype P()
{
  unsigned tmp : 3;
  do
    :: lock(tmp);
       critical++;
       critical--;
       release()
  od
}

active proctype Q()
{
  unsigned tmp : 3;
  do
    :: lock(tmp);
       critical++;
       critical--;
       release()
  od
}

active proctype R()
{
  unsigned tmp : 3;
  do
    :: lock(tmp);
       critical++;
progress:
       printf("Critical section of R\n");
       critical--;
       release()
  od
}

