"""
This snippet generates randomly sized messages (within the given bound)
and their hash strings using SHA-256 algorithm in hashlib standard library.
The messages and their hash, both in hex format, are inserted in two separate
files in separate lines.

Inputs:
    - min_char: minimum number of message characters
    - max_char: maximum number of message characters
    - number_of_samples: number of samples to be generated
    
Output:
    - hex_messages.txt
    - sha2_hex_digests.txt
    - log in terminal
    
"""
import hashlib
import string
from random import *

min_char = int(input("Enter the minimum number of message characters: "))
max_char = int(input("Enter the maximum number of message characters: "))
number_of_samples = int(input("Enter the number of samples that you want: "))

hex_messages_file = open("hex_messages.txt", "w")
sha2_hex_digests_file = open("sha2_hex_digests.txt", "w")

for i in range(10):
    sha256 = hashlib.sha256()
    all_char = string.ascii_letters + string.punctuation + string.digits
    inp = "".join(choice(all_char) for x in range(randint(min_char, max_char)))
    sha256.update(inp.encode())
    hex_inp = "".join("{:0x}".format(ord(c)) for c in inp)
    hex_messages_file.write(hex_inp + "\n")
    sha2_hex_digests_file.write(sha256.hexdigest() + "\n")
    print("input string:", inp)
    print("input hex:", hex_inp)
    print("SHA-2 hex digest:", sha256.hexdigest(), "\n")

hex_messages_file.close()
sha2_hex_digests_file.close()
