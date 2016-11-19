# bpf: BSD(Berkeley?) Packet Filter



 - シミュレータ状態ではプリンストンアーキテクチャを想定
 - BPFの外部仕様を守ること
 - 最終目標としてFPGA-NIC上で実装することとする

## 仕様

 - 64bit RISC
 - 記憶情報
     - packet pointer (パケット格納用)
	 - buflen (パケット長)
	 - メモリ (パケットフィルタの場合はつかわなくね...)
	 - PC (uint64_t*) プログラムカウンタ
	 - A (32bit) アキュムレータ
	 - X (32bit) インデックスレジスタ
 - 戻り値==0の場合パケットは破棄される

プログラムカウンタはポインタなため、今回は64bitレジスタとする


## 命令フォーマット

 - 1命令は64bit固定長
 - 各ブロックはリトルエンディアンで格納

```
 +----------------+--------+--------+
 |   opcode:16    |  jt:8  |  jf:8  |
 +----------------+--------+--------+
 |              k:32                |
 +----------------------------------+

```

## CPU例外

 - TRAP  soft-int
 - FAULT normal error
 - ABORT fatal error


## 命令セット


```
+--------------------------------------------------------------------------------------------------------------+
| OPCODE     | 0x0000 | DESCRIPTION              | EXCEPT CONDITION                                            |
+--------------------------------------------------------------------------------------------------------------+
| RET|K      | 0x0006 | return k                 |                                                             |
| RET|A      | 0x0016 | return A                 |                                                             |
| LD|W|ABS   | 0x0020 | A=ntohl(*(i32*)(p+k))    | [k>buflen]or[size_i32>buflen-k]                             |SIGSEGV
| LD|H|ABS   | 0x0028 | A=EXTRACT_SHORT(&p[k])   | [k>buflen]or[size_i16>buflen-k]                             |SIGSEGV
| LD|B|ABS   | 0x0030 | A=p[k]                   | k>=buflen                                                   |SIGSEGV
| LD|W|LEN   | 0x0080 | A=wirelen                |                                                             |
| LDX|W|LEN  | 0x0081 | X=wirelen                |                                                             |
| LD|W|IND   | 0x0040 | A=ntohl(*(i32*)(p+k))    | [k>buflen] or [X>buflen-k] or [size_i32>buflen-k]           |SIGSEGV
| LD|H|IND   | 0x0048 | A=EXTRACT_SHORT(&p[k])   | [X>buflen] or [k>buflen-X]or[size_i16>buflen-k]             |SIGSEGV
| LD|B|IND   | 0x0050 | A=p[k]                   | [k>=buflen]or[X>=buflen-k]                                  |SIGSEGV
| LDX|MSH|B  | 0x00b1 | X=(p[k]&0xf)<<2          | k>=buflen                                                   |SIGSEGV
| LD|IMM     | 0x0000 | A=k                      |                                                             |
| LDX|IMM    | 0x0001 | X=k                      |                                                             |
| LD|MEM     | 0x0060 | A=mem[k]                 |                                                             |
| LDX|MEM    | 0x0061 | X=mem[k]                 |                                                             |
| ST         | 0x0002 | mem[k]=A                 |                                                             |
| STX        | 0x0003 | mem[k]=X                 |                                                             |
| JMP|JA     | 0x0005 | pc+=k                    |                                                             |
| JMP|JGT|K  | 0x0025 | pc+=(A>k)?jt:jf          |                                                             |
| JMP|JGE|K  | 0x0035 | pc+=(A>=k)?jt:jf         |                                                             |
| JMP|JEQ|K  | 0x0015 | pc+=(A==k)?jt:jf         |                                                             |
| JMP|JSET|K | 0x0045 | pc+=(A&k)?jt:jf          |                                                             |
| JMP|JGT|X  | 0x002d | pc+=(A>X)?jt:jf          |                                                             |
| JMP|JGE|X  | 0x003d | pc+=(A>=X)?jt:jf         |                                                             |
| JMP|JEQ|X  | 0x001d | pc+=(A==X)?jt:jf         |                                                             |
| JMP|JSET|X | 0x004d | pc+=(A&X)?jt:jf          |                                                             |
| ALU|ADD|X  | 0x000c | A+=X                     |                                                             |
| ALU|SUB|X  | 0x001c | A-=X                     |                                                             |
| ALU|MUL|X  | 0x002c | A*=X                     |                                                             |
| ALU|DIV|X  | 0x003c | A/=X                     | division by 0                                               |SIGFPE
| ALU|AND|X  | 0x005c | A&=X                     |                                                             |
| ALU|OR|X   | 0x004c | A|=X                     |                                                             |
| ALU|LSH|X  | 0x006c | A<<=X                    |                                                             |
| ALU|RSH|X  | 0x007c | A>>=X                    |                                                             |
| ALU|ADD|K  | 0x0004 | A+=k                     |                                                             |
| ALU|SUB|K  | 0x0014 | A-=k                     |                                                             |
| ALU|MUL|K  | 0x0024 | A*=k                     |                                                             |
| ALU|DIV|K  | 0x0034 | A/=k                     |                                                             |
| ALU|AND|K  | 0x0054 | A&=k                     |                                                             |
| ALU|OR|K   | 0x0044 | A|=k                     |                                                             |
| ALU|LSH|K  | 0x0064 | A<<=k                    |                                                             |
| ALU|RSH|K  | 0x0074 | A>>=k                    |                                                             |
| ALU|NEG    | 0x0084 | A=-A                     |                                                             |
| MISC|TAX   | 0x0007 | X=A                      |                                                             |
| MISC|TXA   | 0x0087 | A=X                      |                                                             |
+--------------------------------------------------------------------------------------------------------------+
```


## 定数値

```
enum bpf_code : uint16_t {
    LD   = 0x0000,
    LDX  = 0x0001,
    ST   = 0x0002,
    STX  = 0x0003,

    /* ld/ldx fields */
    W    = 0x0000,
    H    = 0x0008,
    B    = 0x0010,
    IMM  = 0x0000,
    ABS  = 0x0020,
    IND  = 0x0040,
    MEM  = 0x0060,
    LEN  = 0x0080,
    MSH  = 0x00a0,

    ALU  = 0x0004,
    JMP  = 0x0005,

    /* alu/jmp fields */
    ADD  = 0x0000,
    SUB  = 0x0010,
    MUL  = 0x0020,
    DIV  = 0x0030,
    OR   = 0x0040,
    AND  = 0x0050,
    LSH  = 0x0060,
    RSH  = 0x0070,
    NEG  = 0x0080,
    JA   = 0x0000,
    JEQ  = 0x0010,
    JGT  = 0x0020,
    JGE  = 0x0030,
    JSET = 0x0040,
    K    = 0x0000,
    X    = 0x0008,

    RET  = 0x0006,

    /* ret - BPF_K and BPF_X also apply */
    A    = 0x0010,

    MISC = 0x0007,

    /* misc */
    TAX  = 0x0000,
    TXA  = 0x0080,

    NOP  = 0xffff,
};
```


