#import <SpringBoard/SBApplication.h>

%hook SBApplication

%new(v@:@)
- (NSString *)bundleIdentifier
{
	return MSHookIvar<NSString *>(self, "_bundleIdentifier");
}

-(BOOL)showLaunchAlertForType:(int)type
{
    BOOL enable = NO;
    NSString *filePath = @"/var/mobile/Library/Preferences/com.mkn0dat.nolaunchalert.plist";
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    for (NSString *key in [dictionary keyEnumerator]) {
        if([[self bundleIdentifier] isEqualToString:key]){
            enable = (BOOL)[[dictionary objectForKey:key] boolValue];
        }
    }
    if (enable && (type == 1)){
        return NO;
    }
    return %orig(type);
}

%end