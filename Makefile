# Makefile

VOLUME_NAME=tradenote_db
BACKUP_FILE=tradenote_db_backup.tar.gz
BACKUP_DIR=./backup
TN_USER=tn@tn

.PHONY: backup restore clean

start:
	docker compose up -d
	while ! curl -s --head http://localhost:8080 | head -n 1 | grep -q "200 OK"; do echo; sleep 5; done;
	$(MAKE) create-user
	docker compose logs -f

stop:
	docker compose down

reset:
	$(MAKE) stop
	$(MAKE) docker-image-clean
	$(MAKE) docker-vol-clean
	

create-user:
	curl 'http://localhost:8080/parse/users' -H 'content-type: text/json' \
  		--data-raw '{"username":"$(TN_USER)","password":"$(TN_USER)","email":"$(TN_USER)","timeZone":"America/New_York","_ApplicationId":"123456","_ClientVersion":"js5.3.0"}'

docker-image-clean:
	docker rm -f $$(docker ps -a)

docker-vol-clean:
	docker volume rm -f $$(docker volume ls -q)

backup:
	mkdir -p $(BACKUP_DIR)
	@echo "Backing up volume: $(VOLUME_NAME) to $(BACKUP_DIR)/$(BACKUP_FILE)"
	docker compose down
	@mkdir -p $(BACKUP_DIR)
	docker run --rm \
	  -v $(VOLUME_NAME):/volume \
	  -v $(shell pwd)/$(BACKUP_DIR):/backup \
	  alpine \
	  tar czf /backup/$(BACKUP_FILE) -C /volume .
	
	git lfs install
	git lfs track "*.tar.gz"
	@echo "Backup complete!"
	docker compose up -d

restore:
	@test -f "$(BACKUP_DIR)/$(BACKUP_FILE)" || (echo "Error: $(BACKUP_DIR)/$(BACKUP_FILE) does not exist" && exit 1)
	@echo "Restoring volume: $(VOLUME_NAME) from $(BACKUP_DIR)/$(BACKUP_FILE)"
	docker compose down
	docker run --rm \
	  -v $(VOLUME_NAME):/volume \
	  -v $(shell pwd)/$(BACKUP_DIR):/backup \
	  alpine \
	  sh -c "cd /volume && tar xzf /backup/$(BACKUP_FILE)"
	@echo "Restore complete!"
	docker compose up -d


clean:
	@echo "Removing backup file..."
	rm -f $(BACKUP_DIR)/$(BACKUP_FILE)
	@echo "Done."