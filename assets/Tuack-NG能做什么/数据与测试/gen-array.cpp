#include <bits/stdc++.h>
using namespace std;
const int T = 6;
int N[] = { 1, 2, 2, 10, 100, 100000 };
long long M[] = { 10, 20, 20, 100, 1000, 1000000000000000000LL };

int main() {
    srand(time(0));
    for (int i = 0; i < T; ++i) {
        freopen((to_string(i + 1) + ".in").c_str(),
                "w", stdout);
        // ...
    }
}
