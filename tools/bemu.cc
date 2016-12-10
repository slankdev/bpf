
#include <bpf_pgm.h>
#include <bpf_pack.h>
#include <bpf_emu.h>


int main(int argc, char** argv)
{
    if (argc < 2) {
        fprintf(stderr, "Usage: %s program\n", argv[0]);
        return -1;
    }

    bpf::vm TAKAHITO(argv[1]);
    uint32_t ret = TAKAHITO.run(bpf::pack_tcp, sizeof(bpf::pack_tcp));
}

