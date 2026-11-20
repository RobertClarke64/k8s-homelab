.PHONY: diff
diff :
	@if [ -z "$${chart}" ]; then echo "Usage: make diff chart=<chart-name> [base=<branch>]"; exit 1; fi; \
	./scripts/helm-diff "$${chart}" "$${base:-main}"
