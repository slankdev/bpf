
#include <stdio.h>
#include <stdint.h>
#include <bpf.h>
#include <bpf_asm.h>
#include <bpf_insn.h>



#define DISSASM(p) bpf::dissas(p, sizeof(p)/sizeof(p[0]))
int main()
{
    using namespace bpf;
    DISSASM(pgm_tcp_port_80);
}
