
#pragma once
#include <stdint.h>

namespace bpf {

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

} /* namespace bpf */
