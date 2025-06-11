# Makefile to set up EmulatorJS static site with roms directory

EMULATORJS_REPO = https://github.com/EmulatorJS/EmulatorJS.git
EMULATORJS_DIR = emulatorjs
STATIC_DIRS = css js roms
INDEX_TEMPLATE_URL = https://raw.githubusercontent.com/EmulatorJS/EmulatorJS/main/template/index.html
ROMS_README = roms/README.md
# Example free NES homebrew ROM (replace with others as needed)
SAMPLE_ROM_URL = https://github.com/binji/nes-tests/raw/master/other/1k/hello.nes
SAMPLE_ROM_NAME = roms/hello.nes

.PHONY: all setup clean

all: setup

setup: $(EMULATORJS_DIR) $(STATIC_DIRS) index.html $(ROMS_README) $(SAMPLE_ROM_NAME)
	@echo "Setup complete! EmulatorJS, static site directories, and sample ROM are ready."

$(EMULATORJS_DIR):
	git clone --depth=1 $(EMULATORJS_REPO) $(EMULATORJS_DIR)

css js roms:
	mkdir -p $@

index.html:
	curl -fsSL $(INDEX_TEMPLATE_URL) -o index.html

$(ROMS_README): roms
	echo "Place public domain or homebrew ROMs here for demo purposes." > $(ROMS_README)

$(SAMPLE_ROM_NAME): roms
	curl -fsSL $(SAMPLE_ROM_URL) -o $(SAMPLE_ROM_NAME)

clean:
	rm -rf $(EMULATORJS_DIR) css js roms index.html
