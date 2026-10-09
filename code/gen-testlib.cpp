#include "testlib.h"

int main(int argc, char* argv[]) {
    registerGen(argc, argv, 1);

    // 格式: n=... m=... seed=...
    int n = opt<int>("n", 5);
    long long m = opt<long long>("m", 20);
    long long seed =
        opt<unsigned long long>("seed", 0);

    rnd.setSeed(seed);

    cout << n << " " << m << endl;
    // ...
}
