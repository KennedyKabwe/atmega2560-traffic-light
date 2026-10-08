# ==========================================
# Traffic Light Controller - ATmega2560
# ==========================================

# MCU
MCU = atmega2560

# Toolchain
CC = avr-gcc
OBJCOPY = avr-objcopy
AVRDUDE = avrdude

# Directories
SRC_DIR = src
BUILD_DIR = build

# Project name
TARGET = traffic_light

# Source files
SRC = $(SRC_DIR)/main.c

# Output files
ELF = $(BUILD_DIR)/$(TARGET).elf
HEX = $(BUILD_DIR)/$(TARGET).hex

# Compiler flags
CFLAGS = -mmcu=$(MCU) -Os -Wall -Wextra -std=c11


# ==========================================
# Default target
# ==========================================

all: $(HEX)


# ==========================================
# Create build directory
# ==========================================

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)


# ==========================================
# Compile and link
# ==========================================

$(ELF): $(SRC) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $@ $<


# ==========================================
# Convert ELF to HEX
# ==========================================

$(HEX): $(ELF)
	$(OBJCOPY) -O ihex -R .eeprom $< $@


# ==========================================
# Flash firmware
# ==========================================

flash: $(HEX)
	$(AVRDUDE) -p $(MCU) -c wiring -P COM6 -b 115200 -D -U flash:w:$(HEX):i


# ==========================================
# Clean build files
# ==========================================

clean:
	rm -rf $(BUILD_DIR)


# ==========================================
# Help
# ==========================================

help:
	@echo "Available targets:"
	@echo "  make        - Build firmware"
	@echo "  make flash  - Build and flash firmware"
	@echo "  make clean  - Remove build files"
	@echo "  make help  - Show available commands"


# ==========================================
# Phony targets
# ==========================================

.PHONY: all flash clean help