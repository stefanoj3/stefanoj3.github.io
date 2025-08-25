# Variabile per il percorso della cartella. Imposta il percorso predefinito su quello attuale.
FOLDER ?= ./content/blog/


# Variabile per il nome del template da copiare.
TEMPLATE_FILE := ../../blog.template.md

.PHONY: blog.new

blog.new:
	@echo "Please provide a slug:"
	@read -r new_name; \
	cd "$(FOLDER)" && \
	last_number=$$(ls -1 | grep -E '^[0-9]{4}-' | sort -n | tail -1 | cut -d'-' -f1); \
	if [ -z "$$last_number" ]; then \
		last_number=0; \
	fi; \
	next_number=$$(printf "%04d" $$((10#$$last_number + 1))); \
	new_folder_name="$${next_number}-$${new_name}"; \
	if [ -d "$$new_folder_name" ]; then \
		echo "Error: The folder '$${new_folder_name}' exists already."; \
	else \
		mkdir "$$new_folder_name"; \
		cp "$(TEMPLATE_FILE)" "$$new_folder_name/index.md"; \
		echo "Folder '$${new_folder_name}' created in '$(FOLDER)'."; \
		echo "File 'index.md' created from template: 'blog.template.md'."; \
	fi