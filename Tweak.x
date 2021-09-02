#import "NSObject+Extras.h"

@interface GAMBannerView: UIView
@end

@interface GADBannerView: UIView
@end

@interface GADInternalBannerView: UIView
@end

@interface UIViewController (extras)
- (void)killGoogleAdGarbage; 
@end
@interface UIView (extras)
- (UIView *)_h4xFindFirstSubviewWithClass:(Class)theClass;
@end

%hook GADInternalBannerView

- (BOOL)userInteractionEnabled {
	return false;
}

- (BOOL)hidden {
	return true;
}

- (CGFloat)alpha {
	return 0;
}
%end

%hook GAMBannerView

- (BOOL)userInteractionEnabled {
	return false;
}

- (BOOL)hidden {
	return true;
}

- (CGFloat)alpha {
	return 0;
}
%end

%hook GADBannerView

- (BOOL)userInteractionEnabled {
	return false;
}

- (BOOL)hidden {
	return true;
}

- (CGFloat)alpha {
	return 0;
}

%end

%hook UIViewController

%new
- (void)killGoogleAdGarbage {
    //%log;
    NSArray *verboten = @[@"GADBannerView", @"GADInternalBannerView", @"GAMBannerView"];
    [verboten enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
	Class current = NSClassFromString(obj);
	UIView *found = [[self view] _h4xFindFirstSubviewWithClass:current];
	if (found) {
	    HBLogDebug(@"die google scum: %@", found);
	    found.alpha = 0;
	    found.hidden = true;
	    found.userInteractionEnabled = false;
	    //[found removeFromSuperview];
	}
       }];

}

- (void)viewWillDisappear:(BOOL)animated {
    //%log;
    %orig;
    NSTimer *timer = [self adTimer];
    if (timer) {
	//HBLogDebug(@"### found timer: %@ kill it!", timer);
	[timer invalidate];
	timer = nil;
	self.adTimer = nil;
    }
   
}

- (void)viewDidAppear:(BOOL)animated {
    //%log;
    %orig;
    Class stupidFullScreenViewClass = NSClassFromString(@"GADFullScreenAdViewController");
    if (!stupidFullScreenViewClass) {
	//NSLog(@"doesnt have googles creepy garbage, don't do anything futher");
	return;
    }
    //return;
    [self killGoogleAdGarbage];
    if (![self adTimer]){
	self.adTimer = [NSTimer scheduledTimerWithTimeInterval:30 repeats:true block:^(NSTimer * _Nonnull timer) {
	   dispatch_async(dispatch_get_main_queue(), ^{ 
		[self killGoogleAdGarbage];  
	    }); 
	}];
    }

    if ([self isKindOfClass:stupidFullScreenViewClass]){
	HBLogDebug(@"stupid full screen bullshit, get out of here");
	[self dismissViewControllerAnimated:TRUE completion:nil];
    }
}

%end

%hook UIView

%new 
- (UIView *)_h4xFindFirstSubviewWithClass:(Class)theClass {
    if ([self isKindOfClass:theClass]) { //kind finds any kind of that class OR clases that inherit from it
            return self;
        }
    for (UIView *v in self.subviews) {
        UIView *theView = [v _h4xFindFirstSubviewWithClass:theClass];
        if (theView != nil){
            return theView;
        }
    }
    return nil;
}

%end
