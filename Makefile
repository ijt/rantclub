.PHONY: run
run:
	mix phx.server

.PHONY: repl
repl:
	iex -S mix phx.server

.PHONY: debug
debug:
	iex -S mix phx.server

