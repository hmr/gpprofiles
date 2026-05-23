# Makefile for generating Karabiner complex modifications JSON from Jsonnet
#
# Usage:
#   make        - Generate gpp_for_karabiner.json
#   make clean  - Remove generated JSON file
#   make check  - Validate the generated JSON

JSONNET := jsonnet
JSONNET_FLAGS := --ext-str GPP_HOME=$(GPP_HOME)

SRC := gpp_for_karabiner.jsonnet
TARGET := gpp_for_karabiner.json

.PHONY: all clean check

all: $(TARGET)

$(TARGET): $(SRC)
	$(JSONNET) $(JSONNET_FLAGS) $< -o $@

clean:
	$(RM) $(TARGET)

check: $(TARGET)
	@python3 -m json.tool $< > /dev/null && echo "JSON is valid: $<"
