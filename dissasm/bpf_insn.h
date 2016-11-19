
#pragma once
#include <stdint.h>

namespace bpf {

enum bpf_code : uint16_t {
#if 0 /* Original */
    BPF_LD   = 0x0000,
    BPF_LDX  = 0x0001,
    BPF_ST   = 0x0002,
    BPF_STX  = 0x0003,

    /* ld/ldx fields */
    BPF_W   = 0x00,
    BPF_H   = 0x08,
    BPF_B   = 0x10,
    BPF_IMM = 0x00,
    BPF_ABS = 0x20,
    BPF_IND = 0x40,
    BPF_MEM = 0x60,
    BPF_LEN = 0x80,
    BPF_MSH = 0xa0,

    BPF_ALU  = 0x0004,
    BPF_JMP  = 0x0005,

    /* alu/jmp fields */
    BPF_ADD  = 0x00,
    BPF_SUB  = 0x10,
    BPF_MUL  = 0x20,
    BPF_DIV  = 0x30,
    BPF_OR   = 0x40,
    BPF_AND  = 0x50,
    BPF_LSH  = 0x60,
    BPF_RSH  = 0x70,
    BPF_NEG  = 0x80,
    BPF_JA   = 0x00,
    BPF_JEQ  = 0x10,
    BPF_JGT  = 0x20,
    BPF_JGE  = 0x30,
    BPF_JSET = 0x40,
    BPF_K    = 0x00,
    BPF_X    = 0x08,

    BPF_RET  = 0x0006,

    /* ret - BPF_K and BPF_X also apply */
    BPF_A    = 0x10,

    BPF_MISC = 0x0007,

    /* misc */
    BPF_TAX  = 0x00,
    BPF_TXA  = 0x80,

    BPF_NOP  = 0xffff,
#else
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
#endif
};



} /* namespace slank */
