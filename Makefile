PMLs:=$(wildcard *.pml)
PANs:=$(patsubst %.pml,%,$(PMLs))

.NOTPARALLEL:

.PHONY: all
all: $(PANs)

% : %.pml
	./gen_$@

.PHONY: clean
clean:
	@rm -f *.trail *~ $(PANs)


