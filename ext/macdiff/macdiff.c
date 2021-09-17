#include "macdiff.h"

VALUE rb_mMacdiff;

void
Init_macdiff(void)
{
  rb_mMacdiff = rb_define_module("Macdiff");
}
