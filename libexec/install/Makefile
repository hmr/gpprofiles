# Makefile for managing launchd plist files
# Directory: /Users/hmr/src/gpprofiles/libexec/install

# Part of GPP

SHELL := /bin/bash

# Service definitions
# Each service maps to com.github.hmr.gpp.<service_id>
SERVICES := ipv6route ipv6route_debug jedid jedid_debug netlocd netlocd_debug setenv setenv_debug ssh_agent

# Directories
CONFIG_DIR    := $(HOME)/.config/launchd
AGENTS_DIR    := $(HOME)/Library/LaunchAgents

# Plist naming convention: dots replace underscores in service names
# e.g., jedid_debug -> com.github.hmr.gpp.jedid.debug
svc_to_label = $(subst _,.,$(1))

# Derive filenames from service name
plist_base   = com.github.hmr.gpp.$(call svc_to_label,$(1))
tmpl_path    = $(CONFIG_DIR)/$(call plist_base,$(1)).plist.tmpl
plist_path   = $(CONFIG_DIR)/$(call plist_base,$(1)).plist
agents_path  = $(AGENTS_DIR)/$(call plist_base,$(1)).plist
# $$$$ -> eval eats one layer -> $$ in recipe -> shell sees $(id -u)
launchd_id   = gui/$$$$(id -u)/$(call plist_base,$(1))
GUI_DOMAIN   = gui/$$$$(id -u)

# Generate all target names
ALL_TARGETS     := $(SERVICES)
INSTALL_TARGETS := $(addsuffix -install,$(SERVICES))
UNINSTALL_TARGETS := $(addsuffix -uninstall,$(SERVICES))
BOOTSTRAP_TARGETS := $(addsuffix -bootstrap,$(SERVICES))
KICKSTART_TARGETS := $(addsuffix -kickstart,$(SERVICES))
PRINT_TARGETS   := $(addsuffix -print,$(SERVICES))
BOOTOUT_TARGETS := $(addsuffix -bootout,$(SERVICES))

.PHONY: help all install uninstall bootstrap kickstart print bootout \
        $(ALL_TARGETS) $(INSTALL_TARGETS) $(UNINSTALL_TARGETS) \
        $(BOOTSTRAP_TARGETS) $(KICKSTART_TARGETS) $(PRINT_TARGETS) \
        $(BOOTOUT_TARGETS)

# Default target
help:
	@echo "Usage: make <service>[-action]"
	@echo ""
	@echo "Services: $(SERVICES)"
	@echo ""
	@echo "Actions per service:"
	@echo "  <service>            - Generate plist from template"
	@echo "  <service>-install    - Install plist to ~/Library/LaunchAgents"
	@echo "  <service>-uninstall  - Bootout (if running) and remove plist"
	@echo "  <service>-bootstrap  - Bootstrap(=start) service via launchctl"
	@echo "  <service>-kickstart  - Kickstart(=restart) service via launchctl"
	@echo "  <service>-print      - Print service info via launchctl"
	@echo "  <service>-bootout    - Bootout(=stop) service via launchctl"
	@echo ""
	@echo "Batch actions (apply to all services):"
	@echo "  all                  - Generate all plists from templates"
	@echo "  install              - Install all plists"
	@echo "  uninstall            - Uninstall all services"
	@echo "  bootstrap            - Bootstrap all services"
	@echo "  kickstart            - Kickstart all services"
	@echo "  print                - Print all services"
	@echo "  bootout              - Bootout all services"
	@echo ""
	@echo "Standalone targets (subst-only):"
	@echo "  git_config           - Generate ~/.config/git/config"
	@echo "  gpp_config           - Generate ~/.config/gpprofiles/gpprofiles"
	@echo "  launchd_setenv       - Generate ~/.config/launchd/launchd_setenv"

# Batch targets
all:       $(ALL_TARGETS)
install:   $(INSTALL_TARGETS)
uninstall: $(UNINSTALL_TARGETS)
bootstrap: $(BOOTSTRAP_TARGETS)
kickstart: $(KICKSTART_TARGETS)
print:     $(PRINT_TARGETS)
bootout:   $(BOOTOUT_TARGETS)

# Pattern rules using secondary expansion
# GNU make doesn't support functions in static pattern rules directly,
# so we generate rules via foreach/eval.

define SERVICE_RULES

# Generate plist from template
$(1):
	./gpp_subst.sh "$(call tmpl_path,$(1))" "$(call plist_path,$(1))"

# Install plist to LaunchAgents
# -d creates the directory first; explicit dest path avoids treating a
# missing LaunchAgents dir as the destination filename
$(1)-install:
	install -d -m 755 "$(AGENTS_DIR)"
	install -m 644 "$(call plist_path,$(1))" "$(call agents_path,$(1))"

# Bootstrap service
$(1)-bootstrap:
	launchctl bootstrap $(GUI_DOMAIN) "$(call agents_path,$(1))"

# Kickstart service
$(1)-kickstart:
	launchctl kickstart -k $(call launchd_id,$(1))

# Print service info
$(1)-print:
	launchctl print $(call launchd_id,$(1))

# Bootout service
$(1)-bootout:
	launchctl bootout $(call launchd_id,$(1))

# Uninstall: bootout if running, then remove plist
$(1)-uninstall:
	@if launchctl print $(call launchd_id,$(1)) &> /dev/null; then \
		echo "Booting out $(call plist_base,$(1))..."; \
		launchctl bootout $(call launchd_id,$(1)); \
	else \
		echo "$(call plist_base,$(1)) is not bootstrapped, skipping bootout."; \
	fi
	rm -f "$(call agents_path,$(1))"

endef

# Generate rules for all services
$(foreach svc,$(SERVICES),$(eval $(call SERVICE_RULES,$(svc))))

# ==============================================================================
# Standalone targets (non-launchd, generate only)
# ==============================================================================

STANDALONE_TARGETS := git_config gpp_config launchd_setenv

.PHONY: $(STANDALONE_TARGETS)

# Generate git config
git_config:
	./gpp_subst.sh "$(HOME)/.config/git/dot-gitconfig.tmpl" "$(HOME)/.config/git/config"

# Generate gpprofiles config
gpp_config:
	./gpp_subst.sh "$(HOME)/.config/gpprofiles/gpprofiles.tmpl" "$(HOME)/.config/gpprofiles/gpprofiles"

# Generate launchd_setenv script
launchd_setenv:
	./gpp_subst.sh "$(HOME)/.config/launchd/launchd_setenv.tmpl" "$(HOME)/.config/launchd/launchd_setenv"
	chmod 755 "$(HOME)/.config/launchd/launchd_setenv"
