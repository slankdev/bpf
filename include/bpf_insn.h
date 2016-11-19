

#pragma once
#include <stdint.h>

namespace bpf {


struct insn {
    uint16_t  code; /* Operation Code of BPF */
    uint8_t   jt;   /* Jump If True          */
    uint8_t   jf;   /* Jump If False         */
    uint32_t  k;    /* Extra datas           */
};


enum bpf_code : uint16_t {
    LD   = 0x0000,
    LDX  = 0x0001,
    ST   = 0x0002,
    STX  = 0x0003,

    /* ld/ldx fields */
    W    = 0x0000,
    H    = 0x0008,
    B    = 0x0010,
    IMM  = 0x0000,
    ABS  = 0x0020,
    IND  = 0x0040,
    MEM  = 0x0060,
    LEN  = 0x0080,
    MSH  = 0x00a0,

    ALU  = 0x0004,
    JMP  = 0x0005,

    /* alu/jmp fields */
    ADD  = 0x0000,
    SUB  = 0x0010,
    MUL  = 0x0020,
    DIV  = 0x0030,
    OR   = 0x0040,
    AND  = 0x0050,
    LSH  = 0x0060,
    RSH  = 0x0070,
    NEG  = 0x0080,
    JA   = 0x0000,
    JEQ  = 0x0010,
    JGT  = 0x0020,
    JGE  = 0x0030,
    JSET = 0x0040,
    K    = 0x0000,
    X    = 0x0008,

    RET  = 0x0006,

    /* ret - BPF_K and BPF_X also apply */
    A    = 0x0010,

    MISC = 0x0007,

    /* misc */
    TAX  = 0x0000,
    TXA  = 0x0080,

    NOP  = 0xffff,
};




void dissas_line(bpf::insn* inst)
{
        uint16_t code = inst->code;
        uint8_t  jt   = inst->jt  ;
        uint8_t  jf   = inst->jf  ;
        uint32_t k    = inst->k   ;
        switch (code) {
            case NOP       : printf("nop"       ); break;

            case RET|K     : printf("ret #%u", k); break;
            case RET|A     : printf("ret"       ); break;

            case LD|W|ABS  : printf("ld [%u]"  , k        ); break;
            case LD|H|ABS  : printf("ldh [%u]" , k        ); break;
            case LD|B|ABS  : printf("ldb [%u]" , k        ); break;
            case LD|W|LEN  : printf("ld #pktlen"          ); break;
            case LDX|W|LEN : printf("(n/a)"               ); break;
            case LD|W|IND  : printf("ld [x + %u]" , k     ); break;
            case LD|H|IND  : printf("ldh [x + %u]", k     ); break;
            case LD|B|IND  : printf("ldb [x + %u]", k     ); break;
            case LDX|MSH|B : printf("ldxb 4*([%u]&0xf)", k); break;
            case LD|IMM    : printf("ld  #%u"  , k        ); break;
            case LDX|IMM   : printf("ldx #%u"  , k        ); break;
            case LD|MEM    : printf("ld  M[%u]", k        ); break;
            case LDX|MEM   : printf("ldx M[%u]", k        ); break;

            case ST        : printf("st  M[%u]", k        ); break;
            case STX       : printf("stx M[%u]", k        ); break;

            case JMP|JA    : printf("ja  %u", k                         ); break;
            case JMP|JGT|K : printf("jgt #0x%x  jt %u  jf %u", k, jt, jf); break;
            case JMP|JGE|K : printf("jge #0x%x  jt %u  jf %u", k, jt, jf); break;
            case JMP|JEQ|K : printf("jeq #0x%x  jt %u  jf %u", k, jt, jf); break;
            case JMP|JSET|K: printf("jset #0x%x jt %u  jf %u", k, jt, jf); break;
            case JMP|JGT|X : printf("jgt  x jt %u  jf %u", jt, jf       ); break;
            case JMP|JGE|X : printf("jge  x jt %u  jf %u", jt, jf       ); break;
            case JMP|JEQ|X : printf("jeq  x jt %u  jf %u", jt, jf       ); break;
            case JMP|JSET|X: printf("jset x jt %u  jf %u", jt, jf       ); break;

            case ALU|ADD|X : printf("add x"    ); break;
            case ALU|SUB|X : printf("sub x"    ); break;
            case ALU|MUL|X : printf("mul x"    ); break;
            case ALU|DIV|X : printf("div x"    ); break;
            case ALU|AND|X : printf("and x"    ); break;
            case ALU|OR|X  : printf("or  x"    ); break;
            case ALU|LSH|X : printf("lsh x"    ); break;
            case ALU|RSH|X : printf("rsh x"    ); break;
            case ALU|ADD|K : printf("add %u", k); break;
            case ALU|SUB|K : printf("sub %u", k); break;
            case ALU|MUL|K : printf("mul %u", k); break;
            case ALU|DIV|K : printf("div %u", k); break;
            case ALU|AND|K : printf("and %u", k); break;
            case ALU|OR|K  : printf("or  %u", k); break;
            case ALU|LSH|K : printf("lsh %u", k); break;
            case ALU|RSH|K : printf("rsh %u", k); break;
            case ALU|NEG   : printf("neg"      ); break;

            case MISC|TAX  : printf("tax"      ); break;
            case MISC|TXA  : printf("txa"      ); break;

            default        : printf("unknown"  ); break;
        }
}



void dissas(bpf::insn* inst, size_t len)
{
    for (size_t i=0; i<len; i++) {
        printf("(%03u) %04x %02x %02x %08x        ",
                i, inst[i].code, inst[i].jt, inst[i].jf, inst[i].k);
        uint16_t code = inst[i].code;
        uint8_t  jt   = inst[i].jt  ;
        uint8_t  jf   = inst[i].jf  ;
        uint32_t k    = inst[i].k   ;
        dissas_line(&inst[i]);
        printf("\n");
    }
}




} /* namespace bpf */
