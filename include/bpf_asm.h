
#pragma once
#include <bpf_dict.h>

namespace bpf {

void dissas_line(bpf::insn* inst, size_t r)
{
    dict d_org;
    dict d_bpf;
    dict dict;
    read_dict(d_org, raw_dict_org, sizeof(raw_dict_org)/sizeof(raw_dict_org[0]));
    read_dict(d_bpf, raw_dict_bpf, sizeof(raw_dict_bpf)/sizeof(raw_dict_bpf[0]));
    dict.insert(d_org.begin(), d_org.end());
    dict.insert(d_bpf.begin(), d_bpf.end());

    uint16_t code = inst->code;
    uint8_t  jt   = inst->jt  ;
    uint8_t  jf   = inst->jf  ;
    uint32_t k    = inst->k   ;

    const char* fmt = dict[code].fmt.c_str();
    switch (code) {
        case NOP       : printf(fmt   ); break;
        case RET|K     : printf(fmt, k); break;
        case RET|A     : printf(fmt   ); break;
        case LD|W|ABS  : printf(fmt, k); break;
        case LD|H|ABS  : printf(fmt, k); break;
        case LD|B|ABS  : printf(fmt, k); break;
        case LD|W|LEN  : printf(fmt   ); break;
        case LDX|W|LEN : printf(fmt   ); break;
        case LD|W|IND  : printf(fmt, k); break;
        case LD|H|IND  : printf(fmt, k); break;
        case LD|B|IND  : printf(fmt, k); break;
        case LDX|MSH|B : printf(fmt, k); break;
        case LD|IMM    : printf(fmt, k); break;
        case LDX|IMM   : printf(fmt, k); break;
        case LD|MEM    : printf(fmt, k); break;
        case LDX|MEM   : printf(fmt, k); break;
        case ST        : printf(fmt, k); break;
        case STX       : printf(fmt, k); break;
        case JMP|JA    : printf(fmt, k); break;
        case JMP|JGT|K : printf(fmt, k, jt+r, jf+r); break;
        case JMP|JGE|K : printf(fmt, k, jt+r, jf+r); break;
        case JMP|JEQ|K : printf(fmt, k, jt+r, jf+r); break;
        case JMP|JSET|K: printf(fmt, k, jt+r, jf+r); break;
        case JMP|JGT|X : printf(fmt,    jt+r, jf+r); break;
        case JMP|JGE|X : printf(fmt,    jt+r, jf+r); break;
        case JMP|JEQ|X : printf(fmt,    jt+r, jf+r); break;
        case JMP|JSET|X: printf(fmt,    jt+r, jf+r); break;
        case ALU|ADD|X : printf(fmt   ); break;
        case ALU|SUB|X : printf(fmt   ); break;
        case ALU|MUL|X : printf(fmt   ); break;
        case ALU|DIV|X : printf(fmt   ); break;
        case ALU|AND|X : printf(fmt   ); break;
        case ALU|OR|X  : printf(fmt   ); break;
        case ALU|LSH|X : printf(fmt   ); break;
        case ALU|RSH|X : printf(fmt   ); break;
        case ALU|ADD|K : printf(fmt, k); break;
        case ALU|SUB|K : printf(fmt, k); break;
        case ALU|MUL|K : printf(fmt, k); break;
        case ALU|DIV|K : printf(fmt, k); break;
        case ALU|AND|K : printf(fmt, k); break;
        case ALU|OR|K  : printf(fmt, k); break;
        case ALU|LSH|K : printf(fmt, k); break;
        case ALU|RSH|K : printf(fmt, k); break;
        case ALU|NEG   : printf(fmt   ); break;
        case MISC|TAX  : printf(fmt   ); break;
        case MISC|TXA  : printf(fmt   ); break;
        default        : printf("unknown"); break;
    }
}



void dissas(insn* inst, size_t len)
{
    for (size_t i=0; i<len; i++) {
        printf("(%03u) %04x %02x %02x %08x",
                i, inst[i].code, inst[i].jt, inst[i].jf, inst[i].k);
        printf("        ");
        dissas_line(&inst[i], i);
        printf("\n");
    }
}


} /* namespace bpf */
