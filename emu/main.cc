
#include <bpf_pgm.h>
#include <bpf_pack.h>
#include <bpf_emu.h>


int main()
{
    using namespace bpf;

    // dict m_bpf;
    // dict m_org;
    // dict m_all;
    // read_dict(m_org, dict_org, sizeof(dict_org)/sizeof(dict_org[0]));
    // read_dict(m_bpf, dict_bpf, sizeof(dict_bpf)/sizeof(dict_bpf[0]));
    // m_all.insert(m_bpf.begin(), m_bpf.end());
    // m_all.insert(m_org.begin(), m_org.end());

    // vm TAKAHITO(pgm_tcp, sizeof(pgm_tcp)/sizeof(pgm_tcp[0]), m_all, NORMAL);
    vm TAKAHITO(pgm_tcp, sizeof(pgm_tcp)/sizeof(pgm_tcp[0]), NORMAL);
    uint32_t ret = TAKAHITO.run(pack_tcp, sizeof(pack_tcp));
}

