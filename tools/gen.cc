
#include <stdio.h>
#include <bpf_insn.h>
#include <bpf_dict.h>
using namespace bpf;


const char* fmt = "| 0x%04x | %-4s | %-10s | %-25s| %-50s| %-10s | %-30s |\n";
void printline()
{
    printf("+--------------------------------------");
    printf("---------------------------------------");
    printf("---------------------------------------");
    printf("-------------------------------------+\n");
}
void printstat()
{
    printf(fmt,
            0, "MNNC", "OPCODE", "DESCRIPTION", "EXCEPT CONDITION",
            "SIG", "FORMAT");
}
void print_dict(std::map<uint16_t, val>& m)
{
    for(auto it=m.begin(); it!=m.end(); ++it) {
    printf(fmt,
                it->first,
                it->second.mn.c_str(),
                it->second.op.c_str(),
                it->second.dsc.c_str(),
                it->second.ck.c_str(),
                it->second.cmnt.c_str(),
                it->second.fmt.c_str()
                );
    }
}

int main()
{
    dict m_bpf;
    dict m_org;
    read_dict(m_org, raw_dict_org, sizeof(raw_dict_org)/sizeof(raw_dict_org[0]));
    read_dict(m_bpf, raw_dict_bpf, sizeof(raw_dict_bpf)/sizeof(raw_dict_bpf[0]));

    printline();
    printstat();
    printline();
    print_dict(m_bpf);
    printline();

    printf("\n");

    printline();
    printstat();
    printline();
    print_dict(m_org);
    printline();
}

