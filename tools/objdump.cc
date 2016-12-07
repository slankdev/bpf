
#include <stdio.h>
#include <bpf_insn.h>
#include <bpf_asm.h>
#include <slankdev/filefd.h>
#include <slankdev/util.h>


int main(int argc, char** argv)
{
    if (argc < 2) {
        fprintf(stderr, "Usage: %s file\n", argv[0]);
        return -1;
    }

    slankdev::filefd fd;
    fd.fopen(argv[1], "rb");

    for (size_t i=0; ; i++) {
        struct bpf::insn ins;
        size_t ret = fd.fread(&ins, sizeof(ins), 1);
        if (ret != 1) {
            break;
        }

        printf("%03x: %04x %02x %02x %08x   (%03zd) ",
                i*8, ins.code, ins.jt, ins.jf, ins.k, i);
        bpf::dissas_line(&ins, i);
        printf("\n");
    }

    fd.fclose();
}
