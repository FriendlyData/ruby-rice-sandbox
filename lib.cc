// Header code.
// NOTE(@dkorolev): This is the shortest way I know to include Rice.
namespace Rice {}
using namespace Rice;
#include "rice/Class.hpp"

// User code.
#include <string>
std::string run(std::string parameter) { return "<passed>" + parameter + "</passed>"; }
extern "C" void Init_lib() {
  Class test_ = define_class("RiceTest").define_method("run", &run);
}
