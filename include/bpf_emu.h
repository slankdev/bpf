
#pragma oance

#include <stdio.h>
#include <stdint.h>
#include <arpa/inet.h>

#include <bpf.h>
#include <bpf_insn.h>

/* for excptn class */
#include <stdlib.h>
#include <string>
#include <exception>
#include <sstream>
#include <ostream>
#include <iostream>

namespace bpf {


void hexdump(const void *buffer, size_t bufferlen)
{
    const uint8_t *data = reinterpret_cast<const uint8_t*>(buffer);
    size_t row = 0;
    while (bufferlen > 0) {
        printf("%04x:   ", data+row);

        size_t n;
        if (bufferlen < 16) n = bufferlen;
        else                n = 16;

        for (size_t i = 0; i < n; i++) {
            if (i == 8) printf(" ");
            printf(" %02x", data[i]);
        }
        for (size_t i = n; i < 16; i++) {
            printf("   ");
        }
        printf("   ");
        for (size_t i = 0; i < n; i++) {
            if (i == 8) printf("  ");
            uint8_t c = data[i];
            if (!(0x20 <= c && c <= 0x7e)) c = '.';
            printf("%c", c);
        }
        printf("\n");
        bufferlen -= n;
        data += n;
        row  += n;
    }
}



enum excptn_type {
    /*
     * software interuption occured by INT
     * when returned by INT, it does not re-exec operation.
     */
    ET_TRAP ,

    /*
     * error signal while operation
     * when returned by INT, it re-exec operation.
     */
    ET_FAULT,

    /*
     * fatal error signal while operation
     * when returned by INT, it exit operation.
     */
    ET_ABORT,
};
const char* type2str(excptn_type t)
{
    switch (t) {
        case ET_TRAP : return "TRAP"  ;
        case ET_FAULT: return "FAULT" ;
        case ET_ABORT: return "ABORT" ;

        default:
            exit(-1);
            break;
    }
}
class excptn : public ::std::exception {
    private:
        std::string str;
    public:
        excptn(excptn_type t, const char* s)
        {
            str =  type2str(t);
            str += ": ";
            str += s;
        }
        template<class T>
        exception& operator<<(const T& t) noexcept {
            std::ostringstream os;
            os << " " << t ;
            str += os.str();
            return *this;
        }
        const char* what() const noexcept {
            return str.c_str();
        }
};


const char* op2str(uint16_t op)
{
    using namespace bpf;
    switch (op) {
        case NOP       : return "NOP       ";
        case RET|K     : return "RET|K     ";
        case RET|A     : return "RET|A     ";
        case LD|W|ABS  : return "LD|W|ABS  ";
        case LD|H|ABS  : return "LD|H|ABS  ";
        case LD|B|ABS  : return "LD|B|ABS  ";
        case LD|W|LEN  : return "LD|W|LEN  ";
        case LDX|W|LEN : return "LDX|W|LEN ";
        case LD|W|IND  : return "LD|W|IND  ";
        case LD|H|IND  : return "LD|H|IND  ";
        case LD|B|IND  : return "LD|B|IND  ";
        case LDX|MSH|B : return "LDX|MSH|B ";
        case LD|IMM    : return "LD|IMM    ";
        case LDX|IMM   : return "LDX|IMM   ";
        case LD|MEM    : return "LD|MEM    ";
        case LDX|MEM   : return "LDX|MEM   ";
        case ST        : return "ST        ";
        case STX       : return "STX       ";
        case JMP|JA    : return "JMP|JA    ";
        case JMP|JGT|K : return "JMP|JGT|K ";
        case JMP|JGE|K : return "JMP|JGE|K ";
        case JMP|JEQ|K : return "JMP|JEQ|K ";
        case JMP|JSET|K: return "JMP|JSET|K";
        case JMP|JGT|X : return "JMP|JGT|X ";
        case JMP|JGE|X : return "JMP|JGE|X ";
        case JMP|JEQ|X : return "JMP|JEQ|X ";
        case JMP|JSET|X: return "JMP|JSET|X";
        case ALU|ADD|X : return "ALU|ADD|X ";
        case ALU|SUB|X : return "ALU|SUB|X ";
        case ALU|MUL|X : return "ALU|MUL|X ";
        case ALU|DIV|X : return "ALU|DIV|X ";
        case ALU|AND|X : return "ALU|AND|X ";
        case ALU|OR|X  : return "ALU|OR|X  ";
        case ALU|LSH|X : return "ALU|LSH|X ";
        case ALU|RSH|X : return "ALU|RSH|X ";
        case ALU|ADD|K : return "ALU|ADD|K ";
        case ALU|SUB|K : return "ALU|SUB|K ";
        case ALU|MUL|K : return "ALU|MUL|K ";
        case ALU|DIV|K : return "ALU|DIV|K ";
        case ALU|AND|K : return "ALU|AND|K ";
        case ALU|OR|K  : return "ALU|OR|K  ";
        case ALU|LSH|K : return "ALU|LSH|K ";
        case ALU|RSH|K : return "ALU|RSH|K ";
        case ALU|NEG   : return "ALU|NEG   ";
        case MISC|TAX  : return "MISC|TAX  ";
        case MISC|TXA  : return "MISC|TXA  ";
        default        : return "UNKNOWN   ";
    }
}




class vm {
    /* Basic Blocks for CPU */
    uint32_t  rA;
    uint32_t  rX;
    insn*     PC;  /* Little Endian */

    /* for Emurator */
    insn*     inst_ptr;
    size_t    inst_len;
    uint32_t  ret_code;

public:
    vm(void* inst, size_t len) :
        rA(0),
        rX(0),
        PC      (reinterpret_cast<insn*>(inst)),
        inst_ptr(reinterpret_cast<insn*>(inst)),
        inst_len(len),
        ret_code(0xffffffff)
    {
        printf("\n\n");
        printf("Construct VM\n");
        print_registers();
        printf(" * Instructions: len=%zd\n", inst_len);
        printf("  -------------------------------------------------\n");
        for (size_t i=0; i<len; i++) {
            printf("%p ", inst_ptr+i);
            printf("(%03u) %04x %02x %02x %08x        ",
                    i, inst_ptr[i].code, inst_ptr[i].jt,
                    inst_ptr[i].jf, inst_ptr[i].k);
            dissas_line(&inst_ptr[i]);
            printf("\n");
        }
        printf("  -------------------------------------------------\n");
        printf("\n\n");
    }
    ~vm()
    {
        printf("Destruct VM\n");
        print_registers();
        printf("\n\n");
    }


public:
    void print_registers() const
    {
        printf(" * Registers\n");
        printf("    - A : 0x%08x %u\n", rA , rA );
        printf("    - X : 0x%08x %u\n", rX , rX );
        printf("    - PC: %p\n", PC);
    }
    void run(uint8_t* p, size_t buflen, bool debug_mode=false)
    {
        try {
            printf("Packet length=%zd\n", buflen);
            hexdump(p, buflen);
            printf("\n\n");

            printf("Start CPU\n");
            printf("  -------------------------------------------------\n");
            uint8_t* mem = 0;
            bool running = true;
            while (running) {
                using namespace bpf;
                insn* inst = reinterpret_cast<insn*>(PC);

                printf("    execute: %04x %02x %02x %08x   %s  ",
                                     inst->code,
                                     inst->jt, inst->jf, inst->k,
                                     op2str(inst->code));

                PC++;
                uint16_t code = inst->code;
                uint16_t jt   = inst->jt  ;
                uint16_t jf   = inst->jf  ;
                uint16_t k    = inst->k   ;
                switch (inst->code) {
                    /*
                     * Original Opcode
                     */
                    case NOP:
                        break;

                    /*
                     * BPF Opcode
                     */
                    case RET|K:
                        ret_code = inst->k;
                        running = false;
                        break;
                    case RET|A:
                        ret_code = A;
                        running = false;
                        break;

                    case LD|W|ABS:
                        if (k > buflen || sizeof(uint32_t) > buflen-k)
                            throw excptn(ET_ABORT, "ld");
                        rA = ntohl(*reinterpret_cast<uint32_t*>(p+k));
                        break;
                    case LD|H|ABS:
                        if (k > buflen || sizeof(uint16_t) > buflen-k)
                            throw excptn(ET_ABORT, "ldh");
                        rA = ntohs(*reinterpret_cast<uint16_t*>(p+k));
                        break;
                    case LD|B|ABS:
                        if (k > buflen || sizeof(uint16_t) > buflen-k)
                            throw excptn(ET_ABORT, "ldh");
                    case LD|W|LEN:
                        rA = buflen;
                        break;
                    case LDX|W|LEN:
                        rX = buflen;
                        break;

                    /*
                     * TODO not implement
                     */
                    case LD|W|IND:
                    case LD|H|IND:
                    case LD|B|IND:
                        throw excptn(ET_ABORT, "NOT IMPLEMENT");
                        break;

                    case LDX|MSH|B:
                        if (k >= buflen)
                            throw excptn(ET_ABORT, "ldxb");
                        rX = (p[k] & 0x0f) << 2;
                    case LD|IMM:
                        rA = k;
                        break;
                    case LDX|IMM:
                        rX = k;
                        break;
                    case LD|MEM:
                        rA = mem[k];
                        break;
                    case LDX|MEM:
                        rX = mem[k];
                        break;
                    case ST:
                        mem[k] = rA;
                        break;
                    case STX:
                        mem[k] = rX;
                        break;
                    case JMP|JA:
                        PC += k;
                        break;
                    case JMP|JGT|K:
                        PC += (rA > k)   ? jt : jf;
                        break;
                    case JMP|JGE|K:
                        PC += (rA >= k)  ? jt : jf;
                        break;
                    case JMP|JEQ|K:
                        PC += (rA == k)  ? jt : jf;
                        break;
                    case JMP|JSET|K:
                        PC += (rA & k)   ? jt : jf;
                        break;
                    case JMP|JGT|X:
                        PC += (rA > rX)  ? jt : jf;
                        break;
                    case JMP|JGE|X:
                        PC += (rA >= rX) ? jt : jf;
                        break;
                    case JMP|JEQ|X:
                        PC += (rA == rX) ? jt : jf;
                        break;
                    case JMP|JSET|X:
                        PC += (rA & rX)  ? jt : jf;
                        break;

                    case ALU|ADD|X:
                        rA += rX;
                        break;
                    case ALU|SUB|X:
                        rA -= rX;
                        break;
                    case ALU|MUL|X:
                        rA *= rX;
                        break;
                    case ALU|DIV|X:
                        if (X == 0)
                            throw excptn(ET_ABORT, "div");
                        rA /= rX;
                        break;
                    case ALU|AND|X:
                        rA &= X;
                        break;
                    case ALU|OR|X:
                        rA |= X;
                        break;
                    case ALU|LSH|X:
                        rA <<= X;
                        break;
                    case ALU|RSH|X:
                        rA >>= X;
                        break;
                    case ALU|ADD|K:
                        rA += k;
                        break;
                    case ALU|SUB|K:
                        rA -= k;
                        break;
                    case ALU|MUL|K:
                        rA *= k;
                        break;
                    case ALU|DIV|K:
                        if (k == 0)
                            throw excptn(ET_ABORT, "div");
                        rA /= k;
                        break;
                    case ALU|AND|K:
                        rA &= k;
                        break;
                    case ALU|OR|K:
                        rA |= k;
                        break;
                    case ALU|LSH|K:
                        rA <<= k;
                        break;
                    case ALU|RSH|K:
                        rA >>= k;
                        break;
                    case ALU|NEG:
                        rA = rA;
                        break;
                    case MISC|TAX:
                        rX = rA;
                        break;
                    case MISC|TXA:
                        rA = rX;
                        break;
                    default:
                        throw excptn(ET_ABORT, "UNKNOWN OPCODE");
                        break;
                }
                dissas_line(inst);
                printf("\n");

                if (debug_mode) {
                    print_registers();
                    getchar();
                }
            }
            printf("  -------------------------------------------------\n");
            printf("End CPU ret=0x%08x(%u) [%s]\n",
                    ret_code, ret_code, (ret_code==0)?"REFUSED":"ACCEPTED");
            printf("\n\n");
        } catch (excptn& e) {
            printf("\n");
            printf("%s\n", e.what());
        }
    }
};


} /* namespace bpf */

