#include "rice/Class.hpp"
using namespace Rice;

#include <string>

std::string run(std::string parameter) { return "<passed>" + parameter + "</passed>"; }

extern "C" void Init_lib() {
  Class test_ = define_class("RiceTest").define_method("run", &run);
}
