
#pragma oance

#include <stdio.h>
#include <stdint.h>
#include <arpa/inet.h>

#include <bpf_insn.h>
#include <bpf_util.h>
#include <bpf_asm.h>
#include <bpf_dict.h>


namespace bpf {


enum debug_level {
    NONE   = 0,
    NORMAL = 1,
    MOST   = 2,
};

class vm {

    /* Basic Blocks for CPU */
    uint32_t  A_;
    uint32_t  X_;
    insn*     PC_;

    /* for Emurator */
    insn*       inst_ptr_;
    size_t      inst_len_;
    uint32_t    ret_code_;
    debug_level debug_;
public:
    vm(void* inst, size_t len) :
        A_       (0x00000000),
        X_       (0x00000000),
        PC_      (reinterpret_cast<insn*>(inst)),
        inst_ptr_(reinterpret_cast<insn*>(inst)),
        inst_len_(len),
        ret_code_(0xffffffff),
        debug_   (NORMAL)
    {
        if (debug_ >= NORMAL) {
            printf("\n\n");
            printf("Construct VM\n");
            print_registers();
            printf("Instructions: len=%zd\n", inst_len_);
            for (size_t i=0; i<len; i++) {
                printf("%p ", inst_ptr_ + i);
                printf("%04x %02x %02x %08x     (%03u)    ",
                        inst_ptr_[i].code,
                        inst_ptr_[i].jt,
                        inst_ptr_[i].jf,
                        inst_ptr_[i].k, i);
                dissas_line(&inst_ptr_[i]);
                printf("\n");
            }
            printf("\n\n");
        }
    }
    vm(void* inst, size_t len, debug_level lev) : vm(inst, len)
    {
        debug_ = lev;
    }
    ~vm()
    {
        if (debug_ >= NORMAL) {
            printf("Destruct VM\n");
            print_registers();
            printf("\n\n");
        }
    }


public:
    void print_registers() const
    {
        printf(" * Registers\n");
        printf("  - A : 0x%08x %u\n", A_ , A_ );
        printf("  - X : 0x%08x %u\n", X_ , X_ );
        printf("  - PC: %p\n", PC_);
    }
    uint32_t run(uint8_t* p, size_t buflen)
    {
        try {
            if (debug_ >= NORMAL) {
                printf("Packet length=%zd\n", buflen);
                hexdump(p, buflen);
                printf("\n\n");

                printf("Start CPU\n");
            }

            uint8_t* mem = 0;
            bool running = true;
            while (running) {
                using namespace bpf;
                insn* inst = reinterpret_cast<insn*>(PC_);

                if (debug_ >= NORMAL) {
                    printf("execute: %04x %02x %02x %08x   %s  (%03u)   ",
                        inst->code,
                        inst->jt,
                        inst->jf,
                        inst->k,
                        op2str(inst->code),
                        inst - inst_ptr_);

                    dissas_line(inst);
                }

                PC_++;
                uint16_t code = inst->code;
                uint16_t jt   = inst->jt  ;
                uint16_t jf   = inst->jf  ;
                uint16_t k    = inst->k   ;
                switch (code) {
                    /*
                     * Original Opcode
                     */
                    case NOP:
                        break;
                    case INT:
                        throw excptn("NOT IMPLEMENT");
                        break;

                    /*
                     * BPF Opcode
                     */
                    case RET|K:
                        ret_code_ = inst->k;
                        running = false;
                        break;
                    case RET|A:
                        ret_code_ = A_;
                        running = false;
                        break;
                    case LD|W|ABS:
                        if (k > buflen || sizeof(uint32_t) > buflen-k)
                            throw excptn("ld");
                        A_ = ntohl(*reinterpret_cast<uint32_t*>(p+k));
                        break;
                    case LD|H|ABS:
                        if (k > buflen || sizeof(uint16_t) > buflen-k)
                            throw excptn("ldh");
                        A_ = ntohs(*reinterpret_cast<uint16_t*>(p+k));
                        break;
                    case LD|B|ABS:
                        if (k > buflen || sizeof(uint16_t) > buflen-k)
                            throw excptn("ldh");
                        A_ = p[k];
                        break;
                    case LD|W|LEN:
                        A_ = buflen;
                        break;
                    case LDX|W|LEN:
                        X_ = buflen;
                        break;

                    /*
                     * TODO not implement
                     */
                    case LD|W|IND:
                    case LD|H|IND:
                    case LD|B|IND:
                        throw excptn("NOT IMPLEMENT");
                        break;

                    case LDX|MSH|B:
                        if (k >= buflen)
                            throw excptn("ldxb");
                        X_ = (p[k] & 0x0f) << 2;
                        break;
                    case LD|IMM:
                        A_ = k;
                        break;
                    case LDX|IMM:
                        X_ = k;
                        break;
                    case LD|MEM:
                        A_ = mem[k];
                        break;
                    case LDX|MEM:
                        X_ = mem[k];
                        break;
                    case ST:
                        mem[k] = A_;
                        break;
                    case STX:
                        mem[k] = X_;
                        break;
                    case JMP|JA:
                        PC_ += k;
                        break;
                    case JMP|JGT|K:
                        PC_ += (A_ > k)   ? jt : jf;
                        break;
                    case JMP|JGE|K:
                        PC_ += (A_ >= k)  ? jt : jf;
                        break;
                    case JMP|JEQ|K:
                        PC_ += (A_ == k)  ? jt : jf;
                        break;
                    case JMP|JSET|K:
                        PC_ += (A_ & k)   ? jt : jf;
                        break;
                    case JMP|JGT|X:
                        PC_ += (A_ > X_)  ? jt : jf;
                        break;
                    case JMP|JGE|X:
                        PC_ += (A_ >= X_) ? jt : jf;
                        break;
                    case JMP|JEQ|X:
                        PC_ += (A_ == X_) ? jt : jf;
                        break;
                    case JMP|JSET|X:
                        PC_ += (A_ & X_)  ? jt : jf;
                        break;
                    case ALU|ADD|X:
                        A_ += X_;
                        break;
                    case ALU|SUB|X:
                        A_ -= X_;
                        break;
                    case ALU|MUL|X:
                        A_ *= X_;
                        break;
                    case ALU|DIV|X:
                        if (X == 0)
                            throw excptn("div");
                        A_ /= X_;
                        break;
                    case ALU|AND|X:
                        A_ &= X;
                        break;
                    case ALU|OR|X:
                        A_ |= X;
                        break;
                    case ALU|LSH|X:
                        A_ <<= X;
                        break;
                    case ALU|RSH|X:
                        A_ >>= X;
                        break;
                    case ALU|ADD|K:
                        A_ += k;
                        break;
                    case ALU|SUB|K:
                        A_ -= k;
                        break;
                    case ALU|MUL|K:
                        A_ *= k;
                        break;
                    case ALU|DIV|K:
                        if (k == 0)
                            throw excptn("div");
                        A_ /= k;
                        break;
                    case ALU|AND|K:
                        A_ &= k;
                        break;
                    case ALU|OR|K:
                        A_ |= k;
                        break;
                    case ALU|LSH|K:
                        A_ <<= k;
                        break;
                    case ALU|RSH|K:
                        A_ >>= k;
                        break;
                    case ALU|NEG:
                        A_ = A_;
                        break;
                    case MISC|TAX:
                        X_ = A_;
                        break;
                    case MISC|TXA:
                        A_ = X_;
                        break;
                    default:
                        throw excptn("UNKNOWN OPCODE");
                        break;
                }

                if (debug_ >= NORMAL) {
                    printf("\n");
                }
                if (debug_ >= MOST) {
                    print_registers();
                    getchar();
                }
            }

            if (debug_ >= NORMAL) {
                printf("End CPU ret=0x%08x(%u) [%s]\n",
                        ret_code_, ret_code_, (ret_code_==0)?"REFUSED":"ACCEPTED");
                printf("\n\n");
            }
        } catch (excptn& e) {
            printf("\n");
            printf("%s\n", e.what());
        }
        return ret_code_;
    }
};


} /* namespace bpf */

