// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: Copyright (c) 2025 JanSimplify

extern "C"
{
    void print_hello_in_c();
}

void print_hello_in_cxx();

int main()
{
    print_hello_in_c();
    print_hello_in_cxx();
}
