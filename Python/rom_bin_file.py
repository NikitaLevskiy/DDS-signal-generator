import math
import numpy as np

# Address width variable
MemoryAddressWidth = 8

# Data width variable (DAC data bus width)
OutputDataWidth = 8

# Mask
Mask = 0b11111111

# Calculation of phase increment
Step = (2.0 * math.pi) / float(2 ** MemoryAddressWidth)

# Create sin wave array
Phase = np.arange(0, 2.0 * math.pi, Step)
Phase = np.sin(Phase)

# Convert the array to binary form
i = 0
while i < len(Phase):
    if Phase[i] <= 0:
        Phase[i] = Phase[i] * (2 ** (OutputDataWidth - 1))
    elif Phase[i] > 0:
        Phase[i] = Phase[i] * (2 ** (OutputDataWidth - 1)) - 1
    i += 1

# Rounding
Phase = np.int_(np.trunc(Phase))

# Write sin wave samples to a file
file = open("rom_data_file_bin.txt", "w")
for value in Phase:
    convTobin = bin(value & Mask).replace("0b", "")
    if value >= 0:
        while len(convTobin) < OutputDataWidth:
            convTobin = '0' + convTobin
    file.write(convTobin + "\n")

# Close the file
file.close()

# Output frequency (fo).
fo = 10**3

# Sampling frequency (fs).
fs = 10**6

# Frequency word
word = (2**32 * fo) / fs
print(f"Generator frequency word = { word } for output frequency fo = { fo } and sampling frequency fs = { fs }.")