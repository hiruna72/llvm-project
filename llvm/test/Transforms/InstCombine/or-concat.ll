; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

;
; Tests for combining concat-able ops:
; or(zext(OP(x)), shl(zext(OP(y)),bw/2))
; -->
; OP(or(zext(x), shl(zext(y),bw/2)))
;

; BSWAP

; PR45715
define i64 @concat_bswap32_unary_split(i64 %a0) {
; CHECK-LABEL: @concat_bswap32_unary_split(
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i64 [[A0:%.*]], 32
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i64 [[A0]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = tail call i32 @llvm.bswap.i32(i32 [[TMP2]])
; CHECK-NEXT:    [[TMP5:%.*]] = tail call i32 @llvm.bswap.i32(i32 [[TMP3]])
; CHECK-NEXT:    [[TMP6:%.*]] = zext i32 [[TMP4]] to i64
; CHECK-NEXT:    [[TMP7:%.*]] = zext i32 [[TMP5]] to i64
; CHECK-NEXT:    [[TMP8:%.*]] = shl nuw i64 [[TMP7]], 32
; CHECK-NEXT:    [[TMP9:%.*]] = or i64 [[TMP8]], [[TMP6]]
; CHECK-NEXT:    ret i64 [[TMP9]]
;
  %1 = lshr i64 %a0, 32
  %2 = trunc i64 %1 to i32
  %3 = trunc i64 %a0 to i32
  %4 = tail call i32 @llvm.bswap.i32(i32 %2)
  %5 = tail call i32 @llvm.bswap.i32(i32 %3)
  %6 = zext i32 %4 to i64
  %7 = zext i32 %5 to i64
  %8 = shl nuw i64 %7, 32
  %9 = or i64 %6, %8
  ret i64 %9
}

define i64 @concat_bswap32_unary_flip(i64 %a0) {
; CHECK-LABEL: @concat_bswap32_unary_flip(
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i64 [[A0:%.*]], 32
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i64 [[A0]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = tail call i32 @llvm.bswap.i32(i32 [[TMP2]])
; CHECK-NEXT:    [[TMP5:%.*]] = tail call i32 @llvm.bswap.i32(i32 [[TMP3]])
; CHECK-NEXT:    [[TMP6:%.*]] = zext i32 [[TMP4]] to i64
; CHECK-NEXT:    [[TMP7:%.*]] = zext i32 [[TMP5]] to i64
; CHECK-NEXT:    [[TMP8:%.*]] = shl nuw i64 [[TMP6]], 32
; CHECK-NEXT:    [[TMP9:%.*]] = or i64 [[TMP8]], [[TMP7]]
; CHECK-NEXT:    ret i64 [[TMP9]]
;
  %1 = lshr i64 %a0, 32
  %2 = trunc i64 %1 to i32
  %3 = trunc i64 %a0 to i32
  %4 = tail call i32 @llvm.bswap.i32(i32 %2)
  %5 = tail call i32 @llvm.bswap.i32(i32 %3)
  %6 = zext i32 %4 to i64
  %7 = zext i32 %5 to i64
  %8 = shl nuw i64 %6, 32
  %9 = or i64 %7, %8
  ret i64 %9
}

define i64 @concat_bswap32_binary(i32 %a0, i32 %a1) {
; CHECK-LABEL: @concat_bswap32_binary(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call i32 @llvm.bswap.i32(i32 [[A0:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = tail call i32 @llvm.bswap.i32(i32 [[A1:%.*]])
; CHECK-NEXT:    [[TMP3:%.*]] = zext i32 [[TMP1]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = zext i32 [[TMP2]] to i64
; CHECK-NEXT:    [[TMP5:%.*]] = shl nuw i64 [[TMP4]], 32
; CHECK-NEXT:    [[TMP6:%.*]] = or i64 [[TMP5]], [[TMP3]]
; CHECK-NEXT:    ret i64 [[TMP6]]
;
  %1 = tail call i32 @llvm.bswap.i32(i32 %a0)
  %2 = tail call i32 @llvm.bswap.i32(i32 %a1)
  %3 = zext i32 %1 to i64
  %4 = zext i32 %2 to i64
  %5 = shl nuw i64 %4, 32
  %6 = or i64 %3, %5
  ret i64 %6
}

declare i32 @llvm.bswap.i32(i32)

; BITREVERSE

define i64 @concat_bitreverse32_unary_split(i64 %a0) {
; CHECK-LABEL: @concat_bitreverse32_unary_split(
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i64 [[A0:%.*]], 32
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i64 [[A0]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = tail call i32 @llvm.bitreverse.i32(i32 [[TMP2]])
; CHECK-NEXT:    [[TMP5:%.*]] = tail call i32 @llvm.bitreverse.i32(i32 [[TMP3]])
; CHECK-NEXT:    [[TMP6:%.*]] = zext i32 [[TMP4]] to i64
; CHECK-NEXT:    [[TMP7:%.*]] = zext i32 [[TMP5]] to i64
; CHECK-NEXT:    [[TMP8:%.*]] = shl nuw i64 [[TMP7]], 32
; CHECK-NEXT:    [[TMP9:%.*]] = or i64 [[TMP8]], [[TMP6]]
; CHECK-NEXT:    ret i64 [[TMP9]]
;
  %1 = lshr i64 %a0, 32
  %2 = trunc i64 %1 to i32
  %3 = trunc i64 %a0 to i32
  %4 = tail call i32 @llvm.bitreverse.i32(i32 %2)
  %5 = tail call i32 @llvm.bitreverse.i32(i32 %3)
  %6 = zext i32 %4 to i64
  %7 = zext i32 %5 to i64
  %8 = shl nuw i64 %7, 32
  %9 = or i64 %6, %8
  ret i64 %9
}

define i64 @concat_bitreverse32_unary_flip(i64 %a0) {
; CHECK-LABEL: @concat_bitreverse32_unary_flip(
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i64 [[A0:%.*]], 32
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i64 [[A0]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = tail call i32 @llvm.bitreverse.i32(i32 [[TMP2]])
; CHECK-NEXT:    [[TMP5:%.*]] = tail call i32 @llvm.bitreverse.i32(i32 [[TMP3]])
; CHECK-NEXT:    [[TMP6:%.*]] = zext i32 [[TMP4]] to i64
; CHECK-NEXT:    [[TMP7:%.*]] = zext i32 [[TMP5]] to i64
; CHECK-NEXT:    [[TMP8:%.*]] = shl nuw i64 [[TMP6]], 32
; CHECK-NEXT:    [[TMP9:%.*]] = or i64 [[TMP8]], [[TMP7]]
; CHECK-NEXT:    ret i64 [[TMP9]]
;
  %1 = lshr i64 %a0, 32
  %2 = trunc i64 %1 to i32
  %3 = trunc i64 %a0 to i32
  %4 = tail call i32 @llvm.bitreverse.i32(i32 %2)
  %5 = tail call i32 @llvm.bitreverse.i32(i32 %3)
  %6 = zext i32 %4 to i64
  %7 = zext i32 %5 to i64
  %8 = shl nuw i64 %6, 32
  %9 = or i64 %7, %8
  ret i64 %9
}

define i64 @concat_bitreverse32_binary(i32 %a0, i32 %a1) {
; CHECK-LABEL: @concat_bitreverse32_binary(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call i32 @llvm.bitreverse.i32(i32 [[A0:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = tail call i32 @llvm.bitreverse.i32(i32 [[A1:%.*]])
; CHECK-NEXT:    [[TMP3:%.*]] = zext i32 [[TMP1]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = zext i32 [[TMP2]] to i64
; CHECK-NEXT:    [[TMP5:%.*]] = shl nuw i64 [[TMP4]], 32
; CHECK-NEXT:    [[TMP6:%.*]] = or i64 [[TMP5]], [[TMP3]]
; CHECK-NEXT:    ret i64 [[TMP6]]
;
  %1 = tail call i32 @llvm.bitreverse.i32(i32 %a0)
  %2 = tail call i32 @llvm.bitreverse.i32(i32 %a1)
  %3 = zext i32 %1 to i64
  %4 = zext i32 %2 to i64
  %5 = shl nuw i64 %4, 32
  %6 = or i64 %3, %5
  ret i64 %6
}

declare i32 @llvm.bitreverse.i32(i32)
