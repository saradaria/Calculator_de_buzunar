#run the program with command python assembler1.py file.asm in the terminal and get the results from the text file rom.txt
import sys
import re

labels = {}

def parselabels(fn):
	linenum = 0
	with open(sys.argv[1]) as f:
		for line in f:
			line = line.replace('\n', '').replace('\r', '')
			if line[0]=='#':
				# Note that linenum won't be increased, so the address
				# remains correct
				continue

			if line[0]=='.':
				labels[line[1:]] = linenum*2
				print ("Label: " + line[1:] + " @ " + format(linenum*2, '#02x'))
			else:
				linenum = linenum + 1

def zerobin(fn):
	with open("rom.txt", "w") as file:
		file.close()

def writetofile(fn, b1, b2):
	with open("rom.txt", "a") as file:
			file.write(b1)
			file.write(b2)

def Convert(string):
    list1 = []
    list1[:0] = string
    return list1


if len(sys.argv) != 2:
	print ("Usage: vASM file.asm")
	sys.exit()

zerobin("rom.txt")

parselabels(sys.argv[1])

with open(sys.argv[1]) as f:
	for line in f:

		# Ignore labels
		if line[0]=='.':
			continue

		# Ignore comments
		if line[0]=='#':
			continue

		line = line.replace('\n', '').replace('\r', '')
		tok = re.split(r'[, ]',line)

		if '' in tok:
			tok.remove('')

		print(str(tok))
		
		if tok[0].upper() == "LDR" or tok[0].upper() == "STR" or tok[0].upper() == "ADD" or tok[0].upper() == "SUB" or tok[0].upper() == "MOV" or tok[0].upper() == "MUL" or tok[0].upper() == "DIV" or tok[0].upper() == "MOD" or tok[0].upper() == "CMP" or tok[0].upper() == "PUSH" or tok[0].upper() == "POP"  :
			r = tok[1]
			if tok[0].upper() == "PUSH" : #27
				bopr = "011011"
				if r == 'X':
					writetofile("rom.txt", bopr, " 0\n")
				elif r == 'Y' :
					writetofile("rom.txt", bopr, " 1\n")
				else :
					print ("Invalid register name")
					print (tok[1].upper())
					sys.exit()
			elif tok[0].upper() == "POP" : #28
				bopr = "011100"
				if r == 'X':
					writetofile("rom.txt", bopr, " 0\n")
				elif r == 'Y' :
					writetofile("rom.txt", bopr, " 0\n")
				else :
					print ("Invalid register name")
					print (tok[1].upper())
					sys.exit()
			else :
				op = tok[0].upper()
				imm = tok[2]
				v = int(imm, 0) #conversie nr string in nr int
				bin(v)[2:] #conversie nr int in nr binar + scoatem 0b de la inceput
				vbin = f'{v:09b}' #il facem pe 9 biti si string
				vbin = vbin + "\n"
				print(vbin)
				if op == "LDR": #0
					bopr = "000000"
				elif op == "STR": #1
					bopr = "000001"
				elif op == "ADD": #9
					bopr = "001001"
				elif op == "SUB": #10
					bopr = "001010"
				elif op == "MOV": #15
					bopr = "001111"
				elif op == "MUL": #16
					bopr = "010000"
				elif op == "DIV": #17
					bopr = "010001"
				elif op == "MOD": #18
					bopr = "010010"
				elif op == "CMP": #23
					bopr = "010111"
				if r == "X": #0
					bopr = bopr + " 0 "
					writetofile("rom.txt", bopr, vbin) 
				elif r == "Y": #1
					bopr = bopr + " 1 "
					writetofile("rom.txt", bopr, vbin)
				else:
					print ("Invalid register name")
					print (tok[1].upper())
					sys.exit()
		elif tok[0].upper() == "BRZ" or tok[0].upper() == "BRN" or tok[0].upper() == "BRC" or tok[0].upper() == "BRO" or tok[0].upper() == "BRA" or tok[0].upper() == "JMP" or tok[0].upper() == "RET":
			op = tok[0].upper()
			if tok[1] in labels:
				addr = labels[tok[1]]
				v = addr
				bin(v)[2:]
				vbin = f'{v:010b}'
				vbin = " " + vbin + "\n"
				#print(vbin)
				if op == "BRZ": #2
					bop = "000010" #opcode
				elif op == "BRN": #3
					bop = "000011" 
				elif op == "BRC": #4
					bop = "000100"
				elif op == "BRO": #5
					bop = "000101"
				elif op == "BRA": #6
					bop = "000110" 
				elif op == "JMP": #7
					bop = "000111"
				elif op == "RET": #8
					bop = "001000"
				writetofile("rom.txt", bop, vbin)
			else:
				print ("Unknown label")
				print (tok[1])
				sys.exit()
		else:
			print ("Unknown operand")
			print (tok[0])
			sys.exit()