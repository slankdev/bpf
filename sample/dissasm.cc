
#include <bpf_pgm.h>
#include <bpf_asm.h>


int main()
{
    using namespace bpf;

    // dict m_bpf;
    // dict m_org;
    // dict m_all;
    // read_dict(m_org, raw_dict_org, sizeof(raw_dict_org)/sizeof(raw_dict_org[0]));
    // read_dict(m_bpf, raw_dict_bpf, sizeof(raw_dict_bpf)/sizeof(raw_dict_bpf[0]));
    // m_all.insert(m_bpf.begin(), m_bpf.end());
    // m_all.insert(m_org.begin(), m_org.end());

    // dissas(pgm_tcp, sizeof(pgm_tcp)/sizeof(pgm_tcp[0]), m_all);
    dissas(pgm_tcp, sizeof(pgm_tcp)/sizeof(pgm_tcp[0]));
}
