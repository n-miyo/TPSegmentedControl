// -*- mode:objc -*-
//
// Copyright (c) 2013 MIYOKAWA, Nobuyoshi (http://www.tempus.org/)
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

#import "TPSegmentedControl.h"

@interface TPSegmentedControl ()
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
@property (nonatomic) BOOL legacyUI;
#endif
@end

@implementation TPSegmentedControl

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
- (BOOL)legacyUI
{
  static BOOL b = NO;
  static dispatch_once_t o;
  dispatch_once(&o, ^{
    NSArray *v =
      [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[v objectAtIndex:0] intValue] < 7) {
      b = YES;
    }
  });
  return b;
}
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
/*
 In iOS6 and earier, UISegmented control sends UIControlEventValueChanged
 in touchDown state.  In iOS7, this behavior is changed and the event is
 sent in touchUp state.
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  NSInteger i = self.selectedSegmentIndex;
  [super touchesBegan:touches withEvent:event];
  if (!self.momentary && self.legacyUI) {
    if (self.selectedSegmentIndex == i) {
      [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
  }
}
#endif

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  NSInteger i = self.selectedSegmentIndex;
  [super touchesEnded:touches withEvent:event];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
  if (!self.legacyUI) {
#endif
    if (!self.momentary && self.selectedSegmentIndex == i) {
      [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
  }
#endif
}

@end

// EOF
