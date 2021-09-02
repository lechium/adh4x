
#import "NSObject+Extras.h"
#import <objc/runtime.h>

@implementation NSObject (Extras)

- (NSTimer *)adTimer {
    return objc_getAssociatedObject(self, @selector(adTimer));
}

- (void)setAdTimer:(NSTimer *)val {
    objc_setAssociatedObject(self, @selector(adTimer), val, OBJC_ASSOCIATION_RETAIN);
}

@end
