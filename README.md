# bpf: BSD(Berkeley?) Packet Filter



 - シミュレータ状態ではプリンストンアーキテクチャを想定
 - BPFの外部仕様を守ること
 - 最終目標としてFPGA-NIC上で実装することとする


## Tools

 - bas BPF Assembler
 - objdump
 - gen


## 仕様

 - 64bit RISC
 - 記憶情報
     - packet pointer (パケット格納用)
	 - buflen (パケット長)
	 - wirelen (オリジナルパケット長)
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
+---------------------------------------------------------------------------------------------------------------------------------------------------------+
| 0x0000 | MNNC | OPCODE     | DESCRIPTION              | EXCEPT CONDITION                                  | SIG        | FORMAT                         |
+---------------------------------------------------------------------------------------------------------------------------------------------------------+
| 0x0000 | ld   | LD|IMM     | A=k                      |                                                   |            | ld   #0x%-8x                   |
| 0x0001 | ldx  | LDX|IMM    | X=k                      |                                                   |            | ldx  #0x%-8x                   |
| 0x0002 | st   | ST         | mem[k]=A                 |                                                   |            | st   M[%u]                     |
| 0x0003 | stx  | STX        | mem[k]=X                 |                                                   |            | stx  M[%u]                     |
| 0x0004 | add  | ALU|ADD|K  | A+=k                     |                                                   |            | add  #%u                       |
| 0x0005 | ja   | JMP|JA     | pc+=k                    |                                                   |            | ja   %u                        |
| 0x0006 | ret  | RET|K      | return k                 |                                                   |            | ret  #%u                       |
| 0x0007 | tax  | MISC|TAX   | X=A                      |                                                   |            | tax                            |
| 0x000c | add  | ALU|ADD|X  | A+=X                     |                                                   |            | add  x                         |
| 0x0014 | sub  | ALU|SUB|K  | A-=k                     |                                                   |            | sub  #%u                       |
| 0x0015 | jeq  | JMP|JEQ|K  | pc+=(A==k)?jt:jf         |                                                   |            | jeq  #0x%-8x jt %-3u  jf %-3u  |
| 0x0016 | ret  | RET|A      | return A                 |                                                   |            | ret                            |
| 0x001c | sub  | ALU|SUB|X  | A-=X                     |                                                   |            | sub  x                         |
| 0x001d | jeq  | JMP|JEQ|X  | pc+=(A==X)?jt:jf         |                                                   |            | jeq  x jt %-3u  jt %-3u        |
| 0x0020 | ld   | LD|W|ABS   | A=ntohl(*(i32*)(p+k))    | [k>buflen]or[size_i32>buflen-k]                   | SIGSEGV    | ld   [%u]                      |
| 0x0024 | mul  | ALU|MUL|K  | A*=k                     |                                                   |            | mul  #%u                       |
| 0x0025 | jgt  | JMP|JGT|K  | pc+=(A>k)?jt:jf          |                                                   |            | jgt  #0x%-8x jt %-3u  jf %-3u  |
| 0x0028 | ldh  | LD|H|ABS   | A=EXTRACT_SHORT(&p[k])   | [k>buflen]or[size_i16>buflen-k]                   | SIGSEGV    | ldh  [%u]                      |
| 0x002c | mul  | ALU|MUL|X  | A*=X                     |                                                   |            | mul  x                         |
| 0x002d | jgt  | JMP|JGT|X  | pc+=(A>X)?jt:jf          |                                                   |            | jgt  x jt %-3u  jf %-3u        |
| 0x0030 | ldb  | LD|B|ABS   | A=p[k]                   | k>=buflen                                         | SIGSEGV    | ldb  [%u]                      |
| 0x0034 | div  | ALU|DIV|K  | A/=k                     | div 0                                             | SIGFPE     | div  #%u                       |
| 0x0035 | jge  | JMP|JGE|K  | pc+=(A>=k)?jt:jf         |                                                   |            | jge  #0x%-8x jt %-3u  jf %-3u  |
| 0x003c | div  | ALU|DIV|X  | A/=X                     | div 0                                             | SIGFPE     | div  x                         |
| 0x003d | jge  | JMP|JGE|X  | pc+=(A>=X)?jt:jf         |                                                   |            | jge  x jt %-3u  jt %-3u        |
| 0x0040 | ld   | LD|W|IND   | A=ntohl(*(i32*)(p+k))    | [k>buflen] or [X>buflen-k] or [size_i32>buflen-k] | SIGSEGV    | ld   [%u]                      |
| 0x0044 | or   | ALU|OR|K   | A|=k                     |                                                   |            | or   #0x%-8x                   |
| 0x0045 | jset | JMP|JSET|K | pc+=(A&k)?jt:jf          |                                                   |            | jset #0x%-8x jt %-3u  jf %-3u  |
| 0x0048 | ldh  | LD|H|IND   | A=EXTRACT_SHORT(&p[k])   | [X>buflen] or [k>buflen-X]or[size_i16>buflen-k]   | SIGSEGV    | ldh  [%u]                      |
| 0x004c | or   | ALU|OR|X   | A|=X                     |                                                   |            | or   x                         |
| 0x004d | jset | JMP|JSET|X | pc+=(A&X)?jt:jf          |                                                   |            | jset x jt %-3u  jt %-3u        |
| 0x0050 | ldb  | LD|B|IND   | A=p[k]                   | [k>=buflen]or[X>=buflen-k]                        | SIGSEGV    | ldb  [%u]                      |
| 0x0054 | and  | ALU|AND|K  | A&=k                     |                                                   |            | and  #0x%-8x                   |
| 0x005c | and  | ALU|AND|X  | A&=X                     |                                                   |            | and  x                         |
| 0x0060 | ld   | LD|MEM     | A=mem[k]                 |                                                   |            | ld   M[%u]                     |
| 0x0061 | ldx  | LDX|MEM    | X=mem[k]                 |                                                   |            | ldx  M[%u]                     |
| 0x0064 | lsh  | ALU|LSH|K  | A<<=k                    |                                                   |            | lsh  #%u                       |
| 0x006c | lsh  | ALU|LSH|X  | A<<=X                    |                                                   |            | lsh  x                         |
| 0x0074 | rsh  | ALU|RSH|K  | A>>=k                    |                                                   |            | rsh  #%u                       |
| 0x007c | rsh  | ALU|RSH|X  | A>>=X                    |                                                   |            | rsh  x                         |
| 0x0080 | ld   | LD|W|LEN   | A=wirelen                |                                                   |            | ld   #pktlen                   |
| 0x0081 | ldx  | LDX|W|LEN  | X=wirelen                |                                                   |            | (n/a)                          |
| 0x0084 | neg  | ALU|NEG    | A=-A                     |                                                   |            | neg                            |
| 0x0087 | txa  | MISC|TXA   | A=X                      |                                                   |            | txa                            |
| 0x00b1 | ldxb | LDX|MSH|B  | X=(p[k]&0xf)<<2          | k>=buflen                                         | SIGSEGV    | ldxb 4*([%u]&0xf)              |
+---------------------------------------------------------------------------------------------------------------------------------------------------------+

+---------------------------------------------------------------------------------------------------------------------------------------------------------+
| 0x0000 | MNNC | OPCODE     | DESCRIPTION              | EXCEPT CONDITION                                  | SIG        | FORMAT                         |
+---------------------------------------------------------------------------------------------------------------------------------------------------------+
| 0xfffe | int  | INT        | interrupt                |                                                   |            | int  %u                        |
| 0xffff | nop  | NOP        | no operation             |                                                   |            | nop                            |
+---------------------------------------------------------------------------------------------------------------------------------------------------------+
```


## 独自追加命令

