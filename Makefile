
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[32m%-25s\033[m %s\n", $$1, $$2}'

.PHONY: update_swiftgen
update_swiftgen: # Update swiftgen
	@printf '\n\033[32m===== Update swiftgen files =====\033[0m\n'
	@echo "update swiftgen files"
	swiftgen

.PHONY: update_bartycrouch
update_bartycrouch: # Update barty crouch
	@printf '\n\033[32m===== Update bartycrouch files =====\033[0m\n'
	@echo "update localization files"
	bartycrouch update -x

.PHONY: update_resources
update_resources: # Update resources
	@printf '\n\033[32m===== Update resources =====\033[0m\n'
	@$(MAKE) update_swiftgen
	@$(MAKE) update_bartycrouch
	