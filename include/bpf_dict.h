
#pragma once
#include <stdint.h>
#include <bpf_insn.h>
#include <string>
#include <map>

namespace bpf {

struct raw_dict {
    uint16_t    hex;
    char mnemonic[256];
    char op      [256];
    char dsc     [256];
    char ck      [256];
    char comment [256];
    char fmt     [256];
};
struct val {
    std::string mn  ;
    std::string op  ;
    std::string dsc ;
    std::string ck  ;
    std::string cmnt;
    std::string fmt ;
    val() {}
    val(const raw_dict& d) :
        mn  (d.mnemonic),
        op  (d.op      ),
        dsc (d.dsc     ),
        ck  (d.ck      ),
        cmnt(d.comment ),
        fmt (d.fmt     ) {}
};
using dict = std::map<uint16_t, val>;


void read_dict(dict& m, raw_dict dic[], size_t dic_len)
{
    for (size_t i=0; i<dic_len; i++) {
        m.insert(std::make_pair(dic[i].hex, val(dic[i])));
    }
}


raw_dict raw_dict_org[] = {
    { NOP       ,"nop" , "NOP"         , "no operation"     , "", "", "nop"    },
    { INT       ,"int" , "INT"         , "interrupt"        , "", "", "int  %u" },
};


raw_dict raw_dict_bpf[] = {
    { RET|K     ,"ret" , "RET|K"       , "return k"         , "", "", "ret  #%u"},
    { RET|A     ,"ret" , "RET|A"       , "return A"         , "", "", "ret"    },

    {
        LD|W|ABS
        , "ld"
        , "LD|W|ABS"
        , "A=ntohl(*(i32*)(p+k))"
        , "[k>buflen]or[size_i32>buflen-k]"
        , "SIGSEGV"
        , "ld   [%u]"
    },

    {
        LD|H|ABS
        , "ldh"
        , "LD|H|ABS"
        , "A=EXTRACT_SHORT(&p[k])"
        , "[k>buflen]or[size_i16>buflen-k]"
        , "SIGSEGV"
        , "ldh  [%u]"
    },

    {
        LD|B|ABS
        , "ldb"
        , "LD|B|ABS"
        , "A=p[k]"
        , "k>=buflen"
        , "SIGSEGV"
        , "ldb  [%u]"
    },

    { LD|W|LEN  ,"ld"  , "LD|W|LEN"    , "A=wirelen"        , "", "", "ld   #pktlen"},
    { LDX|W|LEN ,"ldx" , "LDX|W|LEN"   , "X=wirelen"        , "", "", "(n/a)"     },

    {
        LD|W|IND
        , "ld"
        , "LD|W|IND"
        , "A=ntohl(*(i32*)(p+k))"
        , "[k>buflen] or [X>buflen-k] or [size_i32>buflen-k]"
        , "SIGSEGV"
        , "ld   [%u]"
    },

    {
        LD|H|IND
        , "ldh"
        , "LD|H|IND"
        , "A=EXTRACT_SHORT(&p[k])"
        , "[X>buflen] or [k>buflen-X]or[size_i16>buflen-k]"
        , "SIGSEGV"
        , "ldh  [%u]"
    },

    {
        LD|B|IND
        , "ldb"
        , "LD|B|IND"
        , "A=p[k]"
        , "[k>=buflen]or[X>=buflen-k]"
        , "SIGSEGV"
        , "ldb  [%u]"
    },

    {
        LDX|MSH|B
        , "ldxb"
        , "LDX|MSH|B"
        , "X=(p[k]&0xf)<<2"
        , "k>=buflen"
        , "SIGSEGV"
        , "ldxb 4*([%u]&0xf)"
    },

    { LD|IMM    ,"ld"  , "LD|IMM"      , "A=k"              , "", "", "ld   #0x%-8x" },
    { LDX|IMM   ,"ldx" , "LDX|IMM"     , "X=k"              , "", "", "ldx  #0x%-8x" },
    { LD|MEM    ,"ld"  , "LD|MEM"      , "A=mem[k]"         , "", "", "ld   M[%u]" },
    { LDX|MEM   ,"ldx" , "LDX|MEM"     , "X=mem[k]"         , "", "", "ldx  M[%u]" },
    { ST        ,"st"  , "ST"          , "mem[k]=A"         , "", "", "st   M[%u]" },
    { STX       ,"stx" , "STX"         , "mem[k]=X"         , "", "", "stx  M[%u]" },

    { JMP|JA    ,"ja"  , "JMP|JA"      , "pc+=k"            , "", "", "ja   %u"    },

    {
        JMP|JGT|K
        ,"jgt"
        , "JMP|JGT|K"
        , "pc+=(A>k)?jt:jf"
        , ""
        , ""
        , "jgt  #0x%-8x jt %-3u  jf %-3u"
    },

    {
        JMP|JGE|K
        ,"jge"
        , "JMP|JGE|K"
        , "pc+=(A>=k)?jt:jf"
        , ""
        , ""
        , "jge  #0x%-8x jt %-3u  jf %-3u"
    },

    {
        JMP|JEQ|K
        ,"jeq"
        , "JMP|JEQ|K"
        , "pc+=(A==k)?jt:jf"
        , ""
        , ""
        , "jeq  #0x%-8x jt %-3u  jf %-3u"
    },

    {
        JMP|JSET|K
        ,"jset"
        , "JMP|JSET|K"
        , "pc+=(A&k)?jt:jf"
        , ""
        , ""
        , "jset #0x%-8x jt %-3u  jf %-3u"
    },

    {
        JMP|JGT|X
        ,"jgt"
        , "JMP|JGT|X"
        , "pc+=(A>X)?jt:jf"
        , ""
        , ""
        , "jgt  x jt %-3u  jf %-3u"
    },

    {
        JMP|JGE|X
        ,"jge"
        , "JMP|JGE|X"
        , "pc+=(A>=X)?jt:jf"
        , ""
        , ""
        , "jge  x jt %-3u  jt %-3u"
    },

    {
        JMP|JEQ|X
        ,"jeq"
        , "JMP|JEQ|X"
        , "pc+=(A==X)?jt:jf"
        , ""
        , ""
        , "jeq  x jt %-3u  jt %-3u"
    },

    {
        JMP|JSET|X,
        "jset", "JMP|JSET|X"
        , "pc+=(A&X)?jt:jf"
        , ""
        , ""
        , "jset x jt %-3u  jt %-3u"
    },

    { ALU|ADD|X ,"add" , "ALU|ADD|X"   , "A+=X"             , "", "", "add  x"},
    { ALU|SUB|X ,"sub" , "ALU|SUB|X"   , "A-=X"             , "", "", "sub  x"},
    { ALU|MUL|X ,"mul" , "ALU|MUL|X"   , "A*=X"             , "", "", "mul  x"},

    {
        ALU|DIV|X
        ,"div"
        , "ALU|DIV|X"
        , "A/=X"
        , "div 0"
        , "SIGFPE"
        , "div  x"
    },

    { ALU|AND|X ,"and" , "ALU|AND|X"   , "A&=X"             , "", "", "and  x"},
    { ALU|OR|X  ,"or"  , "ALU|OR|X"    , "A|=X"             , "", "", "or   x"},
    { ALU|LSH|X ,"lsh" , "ALU|LSH|X"   , "A<<=X"            , "", "", "lsh  x"},
    { ALU|RSH|X ,"rsh" , "ALU|RSH|X"   , "A>>=X"            , "", "", "rsh  x"},

    { ALU|ADD|K ,"add" , "ALU|ADD|K"   , "A+=k"             , "", "", "add  #%u"},
    { ALU|SUB|K ,"sub" , "ALU|SUB|K"   , "A-=k"             , "", "", "sub  #%u"},
    { ALU|MUL|K ,"mul" , "ALU|MUL|K"   , "A*=k"             , "", "", "mul  #%u"},

    {
        ALU|DIV|K
        ,"div"
        , "ALU|DIV|K"
        , "A/=k"
        , "div 0"
        , "SIGFPE"
        , "div  #%u"
    },

    { ALU|AND|K ,"and" , "ALU|AND|K"   , "A&=k"             , "", "", "and  #0x%-8x" },
    { ALU|OR|K  ,"or"  , "ALU|OR|K"    , "A|=k"             , "", "", "or   #0x%-8x" },
    { ALU|LSH|K ,"lsh" , "ALU|LSH|K"   , "A<<=k"            , "", "", "lsh  #%u"   },
    { ALU|RSH|K ,"rsh" , "ALU|RSH|K"   , "A>>=k"            , "", "", "rsh  #%u"   },
    { ALU|NEG   ,"neg" , "ALU|NEG"     , "A=-A"             , "", "", "neg"},
    { MISC|TAX  ,"tax" , "MISC|TAX"    , "X=A"              , "", "", "tax"},
    { MISC|TXA  ,"txa" , "MISC|TXA"    , "A=X"              , "", "", "txa"},
};


} /* namespace bpf */
