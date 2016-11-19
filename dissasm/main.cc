
#include <stdio.h>
#include <stdint.h>
#include <slankdev/exception.h>
#include "bpf_insn.h"


namespace bpf {

struct insn {
    uint16_t  code; /* Operation Code of BPF */
    uint8_t   jt;   /* Jump If True          */
    uint8_t   jf;   /* Jump If False         */
    uint32_t  k;    /* Extra datas           */

    void print() const
    {
        printf("    bpf_insn::print: %04x %02x %02x %08x\n", code, jt, jf, k);
    }
};

void dissas(bpf::insn* inst, size_t len) {
    for (size_t i=0; i<len; i++) {
        printf("(%03u) %04x %02x %02x %08x        ", i,
            inst[i].code, inst[i].jt, inst[i].jf, inst[i].k);
        uint16_t code = inst[i].code;
        uint8_t  jt   = inst[i].jt  ;
        uint8_t  jf   = inst[i].jf  ;
        uint32_t k    = inst[i].k   ;
        switch (inst[i].code) {
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
        printf("\n");
    }
}

} /* namespace bpf */




int main()
{
    struct bpf::insn code[] = {
#if 0
    /* tcpdump -dd tcp */
    { 0x0028, 0, 0, 0x0000000c }, // (000) ldh   [12]
    { 0x0015, 0, 5, 0x000086dd }, // (001) jeq   #0x86dd  jt 2   jf 7
    { 0x0030, 0, 0, 0x00000014 }, // (002) ldb   [20]
    { 0x0015, 6, 0, 0x00000006 }, // (003) jeq   #0x6     jt 10  jf 4
    { 0x0015, 0, 6, 0x0000002c }, // (004) jeq   #0x2c    jt 5   jf 11
    { 0x0030, 0, 0, 0x00000036 }, // (005) ldb   [54]
    { 0x0015, 3, 4, 0x00000006 }, // (006) jeq   #0x6     jt 10  jf 11
    { 0x0015, 0, 3, 0x00000800 }, // (007) jeq   #0x800   jt 8   jf 11
    { 0x0030, 0, 0, 0x00000017 }, // (008) ldb   [23]
    { 0x0015, 0, 1, 0x00000006 }, // (009) jeq   #0x6     jt 10  jf 11
    { 0x0006, 0, 0, 0x00040000 }, // (010) ret   #262144
    { 0x0006, 0, 0, 0x00000000 }, // (011) ret   #0
#else
    /* tcpdump -dd "tcp port 80"*/
    { 0x28, 0 , 0 , 0x0000000c }, // (000) ldh   [12]
    { 0x15, 0 , 6 , 0x000086dd }, // (001) jeq   #0x86dd  jt 2   jf 8
    { 0x30, 0 , 0 , 0x00000014 }, // (002) ldb   [20]
    { 0x15, 0 , 15, 0x00000006 }, // (003) jeq   #0x6     jt 4   jf 19
    { 0x28, 0 , 0 , 0x00000036 }, // (004) ldh   [54]
    { 0x15, 12, 0 , 0x00000050 }, // (005) jeq   #0x50    jt 18  jf 6
    { 0x28, 0 , 0 , 0x00000038 }, // (006) ldh   [56]
    { 0x15, 10, 11, 0x00000050 }, // (007) jeq   #0x50    jt 18  jf 19
    { 0x15, 0 , 10, 0x00000800 }, // (008) jeq   #0x800   jt 9   jf 19
    { 0x30, 0 , 0 , 0x00000017 }, // (009) ldb   [23]
    { 0x15, 0 , 8 , 0x00000006 }, // (010) jeq   #0x6     jt 11  jf 19
    { 0x28, 0 , 0 , 0x00000014 }, // (011) ldh   [20]
    { 0x45, 6 , 0 , 0x00001fff }, // (012) jset  #0x1fff  jt 19  jf 13
    { 0xb1, 0 , 0 , 0x0000000e }, // (013) ldxb  4*([14]&0xf)
    { 0x48, 0 , 0 , 0x0000000e }, // (014) ldh   [x + 14]
    { 0x15, 2 , 0 , 0x00000050 }, // (015) jeq   #0x50    jt 18  jf 16
    { 0x48, 0 , 0 , 0x00000010 }, // (016) ldh   [x + 16]
    { 0x15, 0 , 1 , 0x00000050 }, // (017) jeq   #0x50    jt 18  jf 19
    { 0x6 , 0 , 0 , 0x00040000 }, // (018) ret   #262144
    { 0x6 , 0 , 0 , 0x00000000 }, // (019) ret   #0
#endif
    };

    bpf::dissas(code, sizeof(code)/sizeof(code[0]));
}
