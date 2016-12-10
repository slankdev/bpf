#!/usr/bin/env python


import re
import sys
import struct

def address2num(addr):
    try:
        return int(addr[1:-1])
    except ValueError:
        exit("address2num: not address syntax")


def memory2num(c):
    try:
        return int(c[2:-1])
    except ValueError:
        exit("address2num: not memory syntax")


def const2num(c):
    try:
        num = int(c[1:], 10)
        return num
    except ValueError:
        print("", end='')
    try:
        num = int(c[1:], 16)
        return num
    except ValueError:
        print("", end='')
    exit("const2num: not const syntax '{}'".format(c))


register_x = re.compile("X|x")
register_a = re.compile("A|a")
jumptrue   = re.compile("jt")
jumpfalse  = re.compile("jf")
jumpnum    = re.compile("[0-9]+")
const      = re.compile("#.*")
const_dec  = re.compile("#\d+")
const_hex  = re.compile("#(0[xX])?[\dA-Fa-f]+")
address    = re.compile("\[[0-9]+\]")
memory     = re.compile("M\[[0-9]+\]")
pktlen     = re.compile("#pktlen")
nimonic    = re.compile("[a-zA-Z][a-zA-Z0-9]*")
comment    = re.compile("//.*")
outfile    = open("a.out", "wb")

NOP  = 0xffff
INT  = 0xfffe

LD   = 0x0000
LDX  = 0x0001
ST   = 0x0002
STX  = 0x0003

W    = 0x0000
H    = 0x0008
B    = 0x0010
IMM  = 0x0000
ABS  = 0x0020
IND  = 0x0040
MEM  = 0x0060
LEN  = 0x0080
MSH  = 0x00a0

ALU  = 0x0004
JMP  = 0x0005

ADD  = 0x0000
SUB  = 0x0010
MUL  = 0x0020
DIV  = 0x0030
OR   = 0x0040
AND  = 0x0050
LSH  = 0x0060
RSH  = 0x0070
NEG  = 0x0080
JA   = 0x0000
JEQ  = 0x0010
JGT  = 0x0020
JGE  = 0x0030
JSET = 0x0040
K    = 0x0000
X    = 0x0008

RET  = 0x0006

A    = 0x0010

MISC = 0x0007

TAX  = 0x0000
TXA  = 0x0080




def get_line(argv):
    code = []
    filename = argv[1]
    f =  open(filename, 'r')
    for line in f:
        line = line.split("\n")[0]
        code.append(line)
    f.close()
    return code




def get_bin(line, count):
    token = line.split()
    if (nimonic.match(token[0]) != None):
        if   (token[0] == "ret" ): decode(ret (token))

        elif (token[0] == "ld"  ): decode(ld  (token))
        elif (token[0] == "ldb" ): decode(ldb (token))
        elif (token[0] == "ldh" ): decode(ldh (token))
        elif (token[0] == "ldx" ): decode(ldx (token))
        elif (token[0] == "st"  ): decode(st  (token))
        elif (token[0] == "stx" ): decode(stx (token))

        elif (token[0] == "ja"  ): decode(ja  (token, count))
        elif (token[0] == "jeq" ): decode(jeq (token, count))
        elif (token[0] == "jgt" ): decode(jgt (token, count))
        elif (token[0] == "jge" ): decode(jge (token, count))
        elif (token[0] == "jset"): decode(jset(token, count))

        elif (token[0] == "add" ): decode(add (token))
        elif (token[0] == "sub" ): decode(sub (token))
        elif (token[0] == "mul" ): decode(mul (token))
        elif (token[0] == "div" ): decode(div (token))
        elif (token[0] == "and" ): decode(and_(token))
        elif (token[0] == "or"  ): decode(or_ (token))
        elif (token[0] == "lsh" ): decode(lsh (token))
        elif (token[0] == "rsh" ): decode(rsh (token))
        elif (token[0] == "neg" ): decode(neg (token))

        elif (token[0] == "tax" ): decode(tax (token))
        elif (token[0] == "txa" ): decode(txa (token))

        # NO SUPPORT
        elif (token[0] == "ldxb"): decode(ldxb(token))
        elif (token[0] == "int" ): decode(int_(token))
        elif (token[0] == "nop" ): decode(nop (token))

        else: exit("Error: Not Support Mnimonic '{0}'".format(token[0]))
    else:
        exit("Syntax Error 1")



def decode(state):
    if (state): return
    else      : exit("Syntax Error: decode miss")



def main():
    argv = sys.argv
    if (len(argv) < 2):
        print("Usage: %s inputfile" % argv[0])
        exit(-1)
    code = get_line(argv);
    count = 0
    for i in code:
        token = i.split()
        iscmt = comment.match(i)
        if (iscmt != None):
            continue # print("Comment")
        elif (len(token) == 0):
            continue # print("space line")
        else:
            get_bin(i, count)
            count = count + 1




def write_instruction(opcode, jt, jf, k):
    inst = struct.pack("HBBI", opcode, jt, jf, k)
    outfile.write(inst)
    # print("{0}".format(inst))


def printf(str):
    a = 0
    # print("{0:30}->    ".format(str), end="")




def ret(token):
    if (len(token) == 1):
        printf("ret".format(inst))
        write_instruction(RET|A, 0, 0, 0)
        return True
    else:
        if (const.match(token[1]) != None):
            k = const2num(token[1])
            printf("ret #{0}".format(k))
            write_instruction(RET|K, 0, 0, k)
            return True
    return False




def jmp_condition(token, op, OPNUM, c):
    if (len(token) >= 5):
        jt = int(token[3])
        jf = int(token[5])
        if ((const.match(token[1]) != None) and \
           (jumptrue.match(token[2])   != None) and \
           (jumpnum.match(token[3])    != None) and \
           (jumpfalse.match(token[4])  != None) and \
           (jumpnum.match(token[5])    != None)):
                k = const2num(token[1])
                printf("{0} #{1} jt {2} jf {3}".format(op, hex(k), jt, jf))
                write_instruction(JMP|OPNUM|K, jt-c-1, jf-c-1, k)
                return True
        if ((register_x.match(token[1]) != None) and \
           (jumptrue.match(token[2])    != None) and \
           (jumpnum.match(token[3])     != None) and \
           (jumpfalse.match(token[4])   != None) and \
           (jumpnum.match(token[5])     != None)):
                printf("{0} x jt {1} jf {2}".format(op, jt, jf))
                write_instruction(JMP|OPNUM|X, jt-c-1, jf-c-1, 0)
                return True
    return False

def jeq(token, c):
    op = "jeq"
    OPNUM = JEQ
    return jmp_condition(token, op, OPNUM, c)

def jgt (token, c):
    op = "jgt"
    OPNUM = JGT
    return jmp_condition(token, op, OPNUM, c)

def jge (token, c):
    op = "jge"
    OPNUM = JGE
    return jmp_condition(token, op, OPNUM, c)

def jset(token, c):
    op = "jset"
    OPNUM = JSET
    return jmp_condition(token, op, OPNUM, c)




def ldbh_operation(token, op, OPNUM):
    if (address.match(token[1]) != None):
        adr = address2num(token[1])
        printf("{0} [{1}]".format(op, adr))
        write_instruction(LD|OPNUM|ABS, 0, 0, adr)
        return True
    return False

def ldb(token):
    op = "ldb"
    OPNUM = B
    return ldbh_operation(token, op, OPNUM)

def ldh(token):
    op = "ldh"
    OPNUM = H
    return ldbh_operation(token, op, OPNUM)

def ldx(token):
    if (len(token) >= 2):
        if (memory.match(token[1]) != None):
            k = memory2num(token[1])
            printf("ldx M[{0}]".format(k))
            write_instruction(LDX|MEM, 0, 0, k)
            return True
        elif (const.match(token[1]) != None):
            k = const2num(token[1])
            printf("ldx #{0}".format(hex(k)))
            write_instruction(LDX|IMM, 0, 0, k)
            return True
    return False

def ld(token):
    if (len(token) >= 2):
        if (address.match(token[1]) != None):
            k = address2num(token[1])
            printf("ld [{0}]".format(k))
            write_instruction(LD|W|ABS, 0, 0, k)
            return True
        elif (pktlen.match(token[1]) != None):
            printf("ld #pktlen")
            write_instruction(LD|W|LEN, 0, 0, 0)
            return True
        elif (const.match(token[1]) != None):
            k = const2num(token[1])
            printf("ld #{0}".format(hex(k)))
            write_instruction(LD|IMM, 0, 0, k)
            return True
        elif (memory.match(token[1]) != None):
            k = memory2num(token[1])
            printf("ld M[{0}]".format(k))
            write_instruction(LD|MEM, 0, 0, k)
            return True
    return False

def st  (token): # ST
    if (len(token) >= 2):
        if (memory.match(token[1]) != None):
            k = memory2num(token[1])
            printf("st M[{0}]".format(k))
            write_instruction(ST, 0, 0, k)
            return True
    return False

def stx (token): # STX
    if (len(token) >= 2):
        if (memory.match(token[1]) != None):
            k = memory2num(token[1])
            printf("stx M[{0}]".format(k))
            write_instruction(STX, 0, 0, k)
            return True
    return False




def alu(token, op, OPNUM):
    if (len(token) >= 2):
        if (const.match(token[1]) != None):
            k = const2num(token[1])
            printf("{0} #{1}".format(op, k))
            write_instruction(ALU|OPNUM|K, 0, 0, k)
            return True
        elif (register_x.match(token[1]) != None):
            printf("{0} x".format(op))
            write_instruction(ALU|OPNUM|X, 0, 0, 0)
            return True
    return False

def add (token): # ALU|ADD|K
    op = "add"
    OPNUM = ADD
    return alu(token, op, OPNUM)

def sub (token):
    op = "sub"
    OPNUM = SUB
    return alu(token, op, OPNUM)

def mul (token): # ALU|MUL|K
    op = "mul"
    OPNUM = MUL
    return alu(token, op, OPNUM)

def div (token): # ALU|DIV|K
    op = "div"
    OPNUM = DIV
    return alu(token, op, OPNUM)

def and_(token): # ALU|AND|K
    op = "and"
    OPNUM = AND
    return alu(token, op, OPNUM)

def or_ (token): # ALU|OR|X
    op = "or"
    OPNUM = OR
    return alu(token, op, OPNUM)

def lsh (token): # ALU|LSH|X
    op = "lsh"
    OPNUM = LSH
    return alu(token, op, OPNUM)

def rsh (token): # ALU|RSH|X
    op = "rsh"
    OPNUM = RSH
    return alu(token, op, OPNUM)

def neg (token): # ALU|NEG
    if (len(token) >= 1):
        printf("neg")
        write_instruction(ALU|NEG, 0, 0, 0)
        return True
    return False




def misc(token, op, OPNUM):
    if (len(token) >= 1):
        printf("{}".format(op))
        write_instruction(MISC|OPNUM, 0, 0, 0)
        return True
    return False

def txa (token): # MISC|TXA
    op = "txa"
    OPNUM = TXA
    return misc(token, op, OPNUM)

def tax (token): # MISC|TAX
    op = "tax"
    OPNUM = TAX
    return misc(token, op, OPNUM)




# UNSUPPORT OPERATIONS
def ja  (token, c):
    exit("ldxb: not support yet")
    # if (len(token) >= 2):
    #     k = const2num(token[1])
    #     printf('ja  #{0}'.format(k+c))
    #     write_instruction(JMP|JA, 0, 0, k)
    #     return True
    # return False
def ldxb(token): # LDX|MSH|B
    exit("ldxb: not support yet")
def int_(token): # INT
    exit("not support")
def nop (token): # NOP
    exit("not support")




if __name__ == "__main__":
    main()


