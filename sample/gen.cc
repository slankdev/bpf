
#include <stdio.h>
#include <string.h>
#include <bpf_insn.h>

using namespace bpf;
struct {
    char mnemonic[256];
    char op[256];
    uint16_t    hex;
    char dsc[256];
    char ck[256];
    char comment[256];
} ds[] = {
    {"ret" , "RET|K"       , RET|K     , "return k"         , "", ""},
    {"ret" , "RET|A"       , RET|A     , "return A"         , "", ""},

    {
        "ld"
        , "LD|W|ABS"
        , LD|W|ABS
        , "A=ntohl(*(i32*)(p+k))"
        , "[k>buflen]or[size_i32>buflen-k]"
        , "SIGSEGV"
    },

    {
        "ldh"
        , "LD|H|ABS"
        , LD|H|ABS
        , "A=EXTRACT_SHORT(&p[k])"
        , "[k>buflen]or[size_i16>buflen-k]"
        , "SIGSEGV" },

    {
        "ldb"
        , "LD|B|ABS"
        , LD|B|ABS
        , "A=p[k]"
        , "k>=buflen"
        , "SIGSEGV"
    },

    {"ld"  , "LD|W|LEN"    , LD|W|LEN  , "A=wirelen"        , "", ""},
    {"ldx" , "LDX|W|LEN"   , LDX|W|LEN , "X=wirelen"        , "", ""},

    {
        "ld"
        , "LD|W|IND"
        , LD|W|IND
        , "A=ntohl(*(i32*)(p+k))"
        , "[k>buflen] or [X>buflen-k] or [size_i32>buflen-k]"
        , "SIGSEGV"
    },

    {
        "ldh"
        , "LD|H|IND"
        , LD|H|IND
        , "A=EXTRACT_SHORT(&p[k])"
        , "[X>buflen] or [k>buflen-X]or[size_i16>buflen-k]"
        , "SIGSEGV"
    },

    {
        "ldb"
        , "LD|B|IND"
        , LD|B|IND
        , "A=p[k]"
        , "[k>=buflen]or[X>=buflen-k]"
        , "SIGSEGV"
    },

    {
        "ldxb"
        , "LDX|MSH|B"
        , LDX|MSH|B
        , "X=(p[k]&0xf)<<2"
        , "k>=buflen"
        , "SIGSEGV"
    },

    {"ld"  , "LD|IMM"      , LD|IMM    , "A=k"              , "", ""},
    {"ldx" , "LDX|IMM"     , LDX|IMM   , "X=k"              , "", ""},
    {"ld"  , "LD|MEM"      , LD|MEM    , "A=mem[k]"         , "", ""},
    {"ldx" , "LDX|MEM"     , LDX|MEM   , "X=mem[k]"         , "", ""},
    {"st"  , "ST"          , ST        , "mem[k]=A"         , "", ""},
    {"stx" , "STX"         , STX       , "mem[k]=X"         , "", ""},
    {"ja"  , "JMP|JA"      , JMP|JA    , "pc+=k"            , "", ""},
    {"jgt" , "JMP|JGT|K"   , JMP|JGT|K , "pc+=(A>k)?jt:jf"  , "", ""},
    {"jge" , "JMP|JGE|K"   , JMP|JGE|K , "pc+=(A>=k)?jt:jf" , "", ""},
    {"jeq" , "JMP|JEQ|K"   , JMP|JEQ|K , "pc+=(A==k)?jt:jf" , "", ""},
    {"jset", "JMP|JSET|K"  , JMP|JSET|K, "pc+=(A&k)?jt:jf"  , "", ""},
    {"jgt" , "JMP|JGT|X"   , JMP|JGT|X , "pc+=(A>X)?jt:jf"  , "", ""},
    {"jge" , "JMP|JGE|X"   , JMP|JGE|X , "pc+=(A>=X)?jt:jf" , "", ""},
    {"jeq" , "JMP|JEQ|X"   , JMP|JEQ|X , "pc+=(A==X)?jt:jf" , "", ""},
    {"jset", "JMP|JSET|X"  , JMP|JSET|X, "pc+=(A&X)?jt:jf"  , "", ""},
    {"add" , "ALU|ADD|X"   , ALU|ADD|X , "A+=X"             , "", ""},
    {"sub" , "ALU|SUB|X"   , ALU|SUB|X , "A-=X"             , "", ""},
    {"mul" , "ALU|MUL|X"   , ALU|MUL|X , "A*=X"             , "", ""},
    {"div" , "ALU|DIV|X"   , ALU|DIV|X , "A/=X"             , "div 0" , "SIGFPE" },
    {"and" , "ALU|AND|X"   , ALU|AND|X , "A&=X"             , "", ""},
    {"or"  , "ALU|OR|X"    , ALU|OR|X  , "A|=X"             , "", ""},
    {"lsh" , "ALU|LSH|X"   , ALU|LSH|X , "A<<=X"            , "", ""},
    {"rsh" , "ALU|RSH|X"   , ALU|RSH|X , "A>>=X"            , "", ""},
    {"add" , "ALU|ADD|K"   , ALU|ADD|K , "A+=k"             , "", ""},
    {"sub" , "ALU|SUB|K"   , ALU|SUB|K , "A-=k"             , "", ""},
    {"mul" , "ALU|MUL|K"   , ALU|MUL|K , "A*=k"             , "", ""},
    {"div" , "ALU|DIV|K"   , ALU|DIV|K , "A/=k"             , "div 0", "SIGFPE"},
    {"and" , "ALU|AND|K"   , ALU|AND|K , "A&=k"             , "", ""},
    {"or"  , "ALU|OR|K"    , ALU|OR|K  , "A|=k"             , "", ""},
    {"lsh" , "ALU|LSH|K"   , ALU|LSH|K , "A<<=k"            , "", ""},
    {"rsh" , "ALU|RSH|K"   , ALU|RSH|K , "A>>=k"            , "", ""},
    {"neg" , "ALU|NEG"     , ALU|NEG   , "A=-A"             , "", ""},
    {"tax" , "MISC|TAX"    , MISC|TAX  , "X=A"              , "", ""},
    {"txa" , "MISC|TXA"    , MISC|TXA  , "A=X"              , "", ""},
};


int main()
{
    size_t len = sizeof(ds)/sizeof(ds[0]);
    printf("Basic Infomation\n");
    printf(" A      : Register\n");
    printf(" X      : Register\n");
    printf(" p      : packet pointer\n");
    printf(" wirelen: original packet length\n");
    printf(" buflen : amount of data present\n");
    printf("\n");

    printf("+-----------------------------------");
    printf("------------------------------------");
    printf("------------------------------------+\n");
    printf("| %-4s | %-10s | 0x%04x | %-25s| %-50s|\n",
            "MNNC", "OPCODE", 0, "DESCRIPTION", "EXCEPT CONDITION");
    printf("+-----------------------------------");
    printf("------------------------------------");
    printf("------------------------------------+\n");
    for (size_t i=0; i<len; i++) {
        printf("| %-4s | %-10s | 0x%04x | %-25s| %-50s|",
                ds[i].mnemonic, ds[i].op, ds[i].hex, ds[i].dsc, ds[i].ck);
        if (strlen(ds[i].comment) >= 1) {
            printf("%s", ds[i].comment);
        }printf("\n");
    }
    printf("+-----------------------------------");
    printf("------------------------------------");
    printf("------------------------------------+\n");
}

