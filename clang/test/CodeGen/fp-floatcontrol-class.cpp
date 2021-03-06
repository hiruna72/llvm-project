// RUN: %clang_cc1 -ffp-contract=on -triple %itanium_abi_triple -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -ffp-contract=on -triple x86_64-linux-gnu -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -ffp-contract=on -triple x86_64-unknown-unknown -emit-llvm -o - %s | FileCheck %s
// Verify that float_control does not pertain to initializer expressions

float y();
float z();
#pragma float_control(except, on)
class ON {
  float w = 2 + y() * z();
  // CHECK-LABEL: define {{.*}} void @_ZN2ONC2Ev{{.*}}
  //CHECK: call contract float {{.*}}llvm.fmuladd
};
ON on;
#pragma float_control(except, off)
class OFF {
  float w = 2 + y() * z();
  // CHECK-LABEL: define {{.*}} void @_ZN3OFFC2Ev{{.*}}
  //CHECK: call contract float {{.*}}llvm.fmuladd
};
OFF off;
