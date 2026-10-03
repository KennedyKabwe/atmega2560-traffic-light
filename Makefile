# MCU and toolchain settings
MCU     = atmega2560
F_CPU   = 16000000UL
CC      = avr-gcc
OBJCOPY = avr-objcopy
CFLAGS  = -mmcu=$(MCU) -DF_CPU=$(F_CPU) -Os -Wall

# Project files
SRC     = src/main.c
OBJ     = $(SRC:.c=.o)
TARGET  = traffic.elf
HEX     = traffic.hex

# Default target
all: $(HEX)

# Compile source into object
%.o: %.c
    $(CC) $(CFLAGS) -c $< -o $@

# Link objects into ELF
$(TARGET): $(OBJ)
    $(CC) $(CFLAGS) $^ -o $@

# Convert ELF to HEX
$(HEX): $(TARGET)
    $(OBJCOPY) -O ihex -R .eeprom $< $@

# Flash to board (adjust programmer if needed)
flash: $(HEX)
    avrdude -p $(MCU) -c usbasp -U flash:w:$(HEX):i

# Clean build artifacts
clean:
    rm -f $(OBJ) $(TARGET) $(HEX)
