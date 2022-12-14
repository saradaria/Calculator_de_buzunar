#run the program with command python assembler1.py file.asm in the terminal and get the results from the binary file rom.bin
import sys
import re
from bitarray import bitarray

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
	with open("rom.bin", "wb") as binary_file:
		binary_file.close()

def writebin(fn, b1, b2):
	with open("rom.bin", "ab") as binary_file:
			binary_file.write(b1)
			binary_file.write(b2)

def Convert(string):
    list1 = []
    list1[:0] = string
    return list1


if len(sys.argv) != 2:
	print ("Usage: vASM file.asm")
	sys.exit()

zerobin("rom.bin")

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
		
		if tok[0].upper() == "LDR" or tok[0].upper() == "STR" or tok[0].upper() == "ADD" or tok[0].upper() == "SUB" or tok[0].upper() == "MOV" or tok[0].upper() == "MUL" or tok[0].upper() == "DIV" or tok[0].upper() == "MOD" or tok[0].upper() == "CMP"  : 
			op = tok[0].upper()
			r = tok[1]
			imm = tok[2]
			v = int(imm, 0) #conversie nr string in nr int
			bin(v)[2:] #conversie nr int in nr binar + scoatem 0b de la inceput
			vbin = f'{v:09b}' #il facem pe 9 biti dar automat s a facut string
			#print(vbin)
			#int(vbin)
			vbin_StringList = Convert(vbin) #facem nr binar string in lista de stringuri de biti
			vbin_IntList = [eval(i) for i in vbin_StringList] #facem lista anterioara in lista de intregi de biti
			bimm = bitarray(vbin_IntList)
   			#print(vbin_IntList)
			if r == "X": #0
				if op == "LDR": #0
					bopr = bitarray([0, 0, 0, 0, 0, 0, 0])#LDR X, imm   000 000 0 bbbbbbbbb   opcode + register x
				elif op == "STR": #1
					bopr = bitarray([0, 0, 0, 0, 0, 1, 0])#STR X, imm   000 001 0 bbbbbbbbb
				elif op == "ADD": #9
					bopr = bitarray([0, 0, 1, 0, 0, 1, 0])#ADD X, imm   001 001 0 bbbbbbbbb
				elif op == "SUB": #10
					bopr = bitarray([0, 0, 1, 0, 1, 0, 0])#SUB X, imm   001 010 0 bbbbbbbbb
				elif op == "MOV": #15
					bopr = bitarray([0, 0, 1, 1, 1, 1, 0])#MOV X, imm   001 111 0 bbbbbbbbb
				elif op == "MUL": #16
					bopr = bitarray([0, 1, 0, 0, 0, 0, 0])#MUL X, imm   010 000 0 bbbbbbbbb
				elif op == "DIV": #17
					bopr = bitarray([0, 1, 0, 0, 0, 1, 0])#DIV X, imm   010 001 0 bbbbbbbbb
				elif op == "MOD": #18
					bopr = bitarray([0, 1, 0, 0, 1, 0, 0])#MOD X, imm   010 010 0 bbbbbbbbb
				elif op == "CMP": #23
					bopr = bitarray([0, 1, 0, 1, 1, 1, 0])#CMP X, imm   010 111 0 bbbbbbbbb
				writebin("rom.bin", bopr, bimm) 
			elif r == "Y": #1
				if op == "LDR": #0
					bopr = bitarray([0, 0, 0, 0, 0, 0, 1])#LDR Y, imm   000 000 1 bbbbbbbbb   opcode + register y
				elif op == "STR": #1
					bopr = bitarray([0, 0, 0, 0, 0, 1, 1])#STR Y, imm   000 001 1 bbbbbbbbb
				elif op == "ADD": #9
					bopr = bitarray([0, 0, 1, 0, 0, 1, 1])#ADD Y, imm   001 001 1 bbbbbbbbb
				elif op == "SUB": #10
					bopr = bitarray([0, 0, 1, 0, 1, 0, 1])#SUB Y, imm   001 010 1 bbbbbbbbb
				elif op == "MOV": #15
					bopr = bitarray([0, 0, 1, 1, 1, 1, 1])#MOV Y, imm   001 111 1 bbbbbbbbb
				elif op == "MUL": #16
					bopr = bitarray([0, 1, 0, 0, 0, 0, 1])#MUL Y, imm   010 000 1 bbbbbbbbb
				elif op == "DIV": #17
					bopr = bitarray([0, 1, 0, 0, 0, 1, 1])#DIV Y, imm   010 001 1 bbbbbbbbb
				elif op == "MOD": #18
					bopr = bitarray([0, 1, 0, 0, 1, 0, 1])#MOD Y, imm   010 010 1 bbbbbbbbb
				elif op == "CMP": #23
					bopr = bitarray([0, 1, 0, 1, 1, 1, 1])#CMP Y, imm   010 111 1 bbbbbbbbb
				writebin("rom.bin", bopr, bimm) 
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
				vbin_StringList = Convert(vbin)
				vbin_IntList = [eval(i) for i in vbin_StringList]
				#print(vbin)
				if op == "BRZ": #2
					bop = bitarray([0, 0, 0, 0, 1, 0]) #opcode
				elif op == "BRN": #3
					bop = bitarray([0, 0, 0, 0, 1, 1]) 
				elif op == "BRC": #4
					bop = bitarray([0, 0, 0, 1, 0, 0]) 
				elif op == "BRO": #5
					bop = bitarray([0, 0, 0, 1, 0, 1]) 
				elif op == "BRA": #6
					bop = bitarray([0, 0, 0, 1, 1, 0]) 
				elif op == "JMP": #7
					bop = bitarray([0, 0, 0, 1, 1, 1])
				elif op == "RET": #8
					bop = bitarray([0, 0, 1, 0, 0, 0])
				baddr = bitarray(vbin_IntList)
				writebin("rom.bin", bop, baddr)
			else:
				print ("Unknown label")
				print (tok[1])
				sys.exit()
		else:
			print ("Unknown operand")
			print (tok[0])
			sys.exit()