// val/val.cpp
#include "testlib.h"

int main(int argc, char* argv[]) {
  registerValidation(argc, argv);

  int n = inf.readInt(1, 100000, "n");
  inf.readEoln();
  inf.readEof();
  return 0;
}
