SHELL=/bin/bash

ifndef AZUL_HOME
$(error Please run "source environment" in the data-store repo root directory before running make commands)
endif

ifneq ($(shell python -c "import sys; print(sys.version_info >= (3,6))"),True)
$(error Looks like Python 3.6 is not installed)
endif

ifneq ($(shell python -c "import sys; print(hasattr(sys, 'real_prefix'))"),True)
$(error Looks like no virtualenv is active)
endif

ifneq ($(shell python -c "exec('try: import chalice\nexcept: print(False)\nelse: print(True)')"),True)
$(error Looks like some or all requirements is missing. Please run 'pip install -r requirements.txt')
endif

ifeq ($(shell which terraform),)
$(warning Looks like TerraForm is not installed. `make deploy` should still work but `make terraform` will not.)
endif

%: %.template.py
	PYTHONPATH=$(AZUL_HOME) python $<
