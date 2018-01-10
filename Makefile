.DEFAULT_GOAL: up-connect

.PHONY: up-connect
up-connect: up connect

.PHONY: up
up:
	docker stack deploy workspace --compose-file docker-compose.yml

.PHONY: down
down:
	docker stack rm workspace

.PHONY: connect
connect:
	@for id in $(shell docker network ls --filter "name=_default" --format "{{.Name}}"); do \
		echo "Connecting $$id to workspace_proxy_1"; \
		docker network connect $$id workspace_proxy_1; \
		echo "Done"; \
	done
