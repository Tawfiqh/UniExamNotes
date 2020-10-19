all:
	for var in ADSA Lambda Databases Security Complexity CAFV; do \
		./makePage.sh $$var ; \
  done

# A makefile should only recompile
# the things that have changed.
# Edit this appropriately.
