.PHONY: run
run:
	mix phx.server

.PHONY: repl
repl:
	iex -S mix phx.server

