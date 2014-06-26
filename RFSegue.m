
#import "RFSegue.h"

@implementation RFSegue

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p; sourceViewController: %@; destinationViewController: %@; identifier:%@; userInfo:%@>",
            NSStringFromClass([self class]),
            self,
            self.sourceViewController,
            self.destinationViewController,
            self.identifier,
            self.userInfo];
}

- (BOOL)shouldPerform {
    BOOL shouldPerform = YES;
    if ([self.sourceViewController respondsToSelector:@selector(RFSegueShouldPerform:)]) {
        shouldPerform = [self.sourceViewController RFSegueShouldPerform:self];
    }
    return shouldPerform;
}

- (void)perform {
    if (![self shouldPerform]) return;

    [self RFPerform];
}

- (void)RFPerform {
    [self noticeDelegateWillPerform];
    RFAssert(false, @"You should subclass RFSegue and override RFPerform.");
    [self noticeDelegateDidPerformed];
}

- (void)noticeDelegateWillPerform {
    if ([self.sourceViewController respondsToSelector:@selector(RFSegueWillPerform:)]) {
        [self.sourceViewController RFSegueWillPerform:self];
    }
    if ([self.destinationViewController respondsToSelector:@selector(RFSegueWillAppear:)]) {
        [self.destinationViewController RFSegueWillAppear:self];
    }
}

- (void)noticeDelegateDidPerformed {
    if ([self.sourceViewController respondsToSelector:@selector(RFSegueDidPerform:)]) {
        [self.sourceViewController RFSegueDidPerform:self];
    }
    if ([self.destinationViewController respondsToSelector:@selector(RFSegueDidAppear:)]) {
        [self.destinationViewController RFSegueDidAppear:self];
    }
}

@end
