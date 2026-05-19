#import "MALoad.h"

static UIView *_loadView = nil;

@implementation MALoad

+ (void)show {
    [self hide];
    
    UIWindow *window = [self mainWindow];
    if (!window) return;
    
    _loadView = [[UIView alloc] initWithFrame:window.bounds];
    _loadView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _loadView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.center = _loadView.center;
    [indicator startAnimating];
    [_loadView addSubview:indicator];
    
    [window addSubview:_loadView];
}

+ (void)hide {
    if (_loadView) {
        [_loadView removeFromSuperview];
        _loadView = nil;
    }
}

+ (UIWindow *)mainWindow {
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                return windowScene.windows.firstObject;
            }
        }
        UIWindowScene *windowScene = (UIWindowScene *)[[UIApplication sharedApplication].connectedScenes allObjects].firstObject;
        return windowScene.windows.firstObject;
    } else {
#if TARGET_OS_IOS
        return [[[UIApplication sharedApplication] delegate] window];
#else
        return [UIApplication sharedApplication].keyWindow;
#endif
    }
}

@end
