
#include <stdio.h>
#include <string.h>
#include "bpf_insn.h"

using namespace bpf;
struct {
    char op[256];
    uint16_t    hex;
    char dsc[256];
    char ck[256];
    char comment[256];
} ds[] = {
    {"RET|K"       , RET|K     , "return k"         , "", ""},
    {"RET|A"       , RET|A     , "return A"         , "", ""},

    {
        "LD|W|ABS"
        , LD|W|ABS
        , "A=ntohl(*(i32*)(p+k))"
        , "[k>buflen]or[size_i32>buflen-k]"
        , "SIGSEGV"
    },

    {
        "LD|H|ABS"
        , LD|H|ABS
        , "A=EXTRACT_SHORT(&p[k])"
        , "[k>buflen]or[size_i16>buflen-k]"
        , "SIGSEGV" },

    {
        "LD|B|ABS"
        , LD|B|ABS
        , "A=p[k]"
        , "k>=buflen"
        , "SIGSEGV"
    },

    {"LD|W|LEN"    , LD|W|LEN  , "A=wirelen"        , "", ""},
    {"LDX|W|LEN"   , LDX|W|LEN , "X=wirelen"        , "", ""},

    {
        "LD|W|IND"
        , LD|W|IND
        , "A=ntohl(*(i32*)(p+k))"
        , "[k>buflen] or [X>buflen-k] or [size_i32>buflen-k]"
        , "SIGSEGV"
    },

    {
        "LD|H|IND"
        , LD|H|IND
        , "A=EXTRACT_SHORT(&p[k])"
        , "[X>buflen] or [k>buflen-X]or[size_i16>buflen-k]"
        , "SIGSEGV"
    },

    {
        "LD|B|IND"
        , LD|B|IND
        , "A=p[k]"
        , "[k>=buflen]or[X>=buflen-k]"
        , "SIGSEGV"
    },

    {
        "LDX|MSH|B"
        , LDX|MSH|B
        , "X=(p[k]&0xf)<<2"
        , "k>=buflen"
        , "SIGSEGV"
    },

    {"LD|IMM"      , LD|IMM    , "A=k"              , "", ""},
    {"LDX|IMM"     , LDX|IMM   , "X=k"              , "", ""},
    {"LD|MEM"      , LD|MEM    , "A=mem[k]"         , "", ""},
    {"LDX|MEM"     , LDX|MEM   , "X=mem[k]"         , "", ""},
    {"ST"          , ST        , "mem[k]=A"         , "", ""},
    {"STX"         , STX       , "mem[k]=X"         , "", ""},
    {"JMP|JA"      , JMP|JA    , "pc+=k"            , "", ""},
    {"JMP|JGT|K"   , JMP|JGT|K , "pc+=(A>k)?jt:jf"  , "", ""},
    {"JMP|JGE|K"   , JMP|JGE|K , "pc+=(A>=k)?jt:jf" , "", ""},
    {"JMP|JEQ|K"   , JMP|JEQ|K , "pc+=(A==k)?jt:jf" , "", ""},
    {"JMP|JSET|K"  , JMP|JSET|K, "pc+=(A&k)?jt:jf"  , "", ""},
    {"JMP|JGT|X"   , JMP|JGT|X , "pc+=(A>X)?jt:jf"  , "", ""},
    {"JMP|JGE|X"   , JMP|JGE|X , "pc+=(A>=X)?jt:jf" , "", ""},
    {"JMP|JEQ|X"   , JMP|JEQ|X , "pc+=(A==X)?jt:jf" , "", ""},
    {"JMP|JSET|X"  , JMP|JSET|X, "pc+=(A&X)?jt:jf"  , "", ""},
    {"ALU|ADD|X"   , ALU|ADD|X , "A+=X"             , "", ""},
    {"ALU|SUB|X"   , ALU|SUB|X , "A-=X"             , "", ""},
    {"ALU|MUL|X"   , ALU|MUL|X , "A*=X"             , "", ""},

    {
        "ALU|DIV|X"
        , ALU|DIV|X
        , "A/=X"
        , "division by 0"
        , "SIGFPE"
    },

    {"ALU|AND|X"   , ALU|AND|X , "A&=X"             , "", ""},
    {"ALU|OR|X"    , ALU|OR|X  , "A|=X"             , "", ""},
    {"ALU|LSH|X"   , ALU|LSH|X , "A<<=X"            , "", ""},
    {"ALU|RSH|X"   , ALU|RSH|X , "A>>=X"            , "", ""},
    {"ALU|ADD|K"   , ALU|ADD|K , "A+=k"             , "", ""},
    {"ALU|SUB|K"   , ALU|SUB|K , "A-=k"             , "", ""},
    {"ALU|MUL|K"   , ALU|MUL|K , "A*=k"             , "", ""},
    {"ALU|DIV|K"   , ALU|DIV|K , "A/=k"             , "", ""},
    {"ALU|AND|K"   , ALU|AND|K , "A&=k"             , "", ""},
    {"ALU|OR|K"    , ALU|OR|K  , "A|=k"             , "", ""},
    {"ALU|LSH|K"   , ALU|LSH|K , "A<<=k"            , "", ""},
    {"ALU|RSH|K"   , ALU|RSH|K , "A>>=k"            , "", ""},
    {"ALU|NEG"     , ALU|NEG   , "A=-A"             , "", ""},
    {"MISC|TAX"    , MISC|TAX  , "X=A"              , "", ""},
    {"MISC|TXA"    , MISC|TXA  , "A=X"              , "", ""},
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

    printf("+---------------------------------");
    printf("----------------------------------");
    printf("---------------------------------+\n");
    printf("| %-10s | 0x%04x | %-25s| %-50s|\n",
            "OPCODE", 0, "DESCRIPTION", "EXCEPT CONDITION");
    printf("+---------------------------------");
    printf("----------------------------------");
    printf("---------------------------------+\n");
    for (size_t i=0; i<len; i++) {
        printf("| %-10s | 0x%04x | %-25s| %-50s|",
                ds[i].op, ds[i].hex, ds[i].dsc, ds[i].ck);
        if (strlen(ds[i].comment) >= 1) {
            printf("%s", ds[i].comment);
        }printf("\n");
    }
    printf("+---------------------------------");
    printf("----------------------------------");
    printf("---------------------------------+\n");
}

