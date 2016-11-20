
#pragma oance

#include <stdio.h>
#include <stdint.h>

#include <stdlib.h>
#include <string>
#include <exception>
#include <sstream>
#include <ostream>
#include <iostream>

namespace bpf {


class excptn : public ::std::exception {
    private:
        std::string str;
    public:
        explicit excptn(const char* s)
        {
            str = s;
        }
        template<class T>
        exception& operator<<(const T& t) noexcept {
            std::ostringstream os;
            os << " " << t ;
            str += os.str();
            return *this;
        }
        const char* what() const noexcept {
            return str.c_str();
        }
};


void printline()
{
    printf("--------------------------------------");
    printf("------------------------------------\n");
}

void hexdump(const void *buffer, size_t bufferlen)
{
    const uint8_t *data = reinterpret_cast<const uint8_t*>(buffer);
    size_t row = 0;
    while (bufferlen > 0) {
        printf("%04x:   ", data+row);

        size_t n;
        if (bufferlen < 16) n = bufferlen;
        else                n = 16;

        for (size_t i = 0; i < n; i++) {
            if (i == 8) printf(" ");
            printf(" %02x", data[i]);
        }
        for (size_t i = n; i < 16; i++) {
            printf("   ");
        }
        printf("   ");
        for (size_t i = 0; i < n; i++) {
            if (i == 8) printf("  ");
            uint8_t c = data[i];
            if (!(0x20 <= c && c <= 0x7e)) c = '.';
            printf("%c", c);
        }
        printf("\n");
        bufferlen -= n;
        data += n;
        row  += n;
    }
}

} /* namespace bpf */
