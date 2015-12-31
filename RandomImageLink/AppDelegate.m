//
//  AppDelegate.m
//  RandomImageLink
//
//  Created by Le Thai Phuc Quang on 2/18/15.
//  Copyright (c) 2015 QuangLTP. All rights reserved.
//


#import "AppDelegate.h"
#import <ParseOSX/ParseOSX.h>
#import "PQOptionViewController.h"
#import "PQAboutViewController.h"
#import "PQCopiedViewController.h"
#import "PQImageCategory.h"
#import "PQImage.h"

@interface AppDelegate ()
@property (nonatomic) NSStatusItem *statusItem;

@property (nonatomic) NSWindowController *optionWC;
@property (nonatomic) NSWindowController *aboutWC;
@property (nonatomic) NSWindowController *copiedWC;

@property (nonatomic) NSMutableArray *imageCategories;
@property (nonatomic) NSMenuItem *launchOnLogInItem;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self setupParse];
    [self fetchImageCategories];
    
}

- (void)setupParse {
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/OSX
    //[Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"zHrCQLNtuBNRy2va57fGnxaVx2VbMD3oU0thUgi6"
                  clientKey:@"Wgw5cu7ljGgYZiYF2A8s2mzSXOEYndGxUr8SV5rE"];
    
    // [Optional] Track statistics around application opens.
    //[PFAnalytics trackAppOpenedWithLaunchOptions:nil];
    
    // ...
}

// Check whether the user has internet
- (bool)hasInternet {
    NSURL *url = [[NSURL alloc] initWithString:@"https://parse.com/"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    BOOL connectedToInternet = NO;
    if ([NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil]) {
        connectedToInternet = YES;
    }
    if (connectedToInternet)
    NSLog(@"We Have Internet!");
    return connectedToInternet;
}

- (void)fetchImageCategories {
    PFQuery *query = [PFQuery queryWithClassName:@"PQImageCategory"];
    [query includeKey:@"imageArray"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            _imageCategories = [[NSMutableArray alloc] init];
            // Do something with the found objects
            for (PFObject *object in objects) {
                [_imageCategories addObject:[[PQImageCategory alloc] initWithPFObject:object]];
            }
            [self setupStatusItem];
        } else {
            // Log details of the failure
            //NSLog(@"Error: %@ %@", error, [error userInfo]);
            NSString *errStatement = [[error userInfo] objectForKey:@"error"];
            if ([errStatement containsString:@"The Internet connection appears to be offline."]) {
                [self showErrorWithMessageText:@"Không kết nối được" andInformativeText:@"Kiểm tra lại mạng rồi chạy lại app nha thím!"];
            }
            else {
                [self showErrorWithMessageText:@"Có lỗi rồi" andInformativeText:@"Nhưng mà lỗi gì thì mình không biết :v thím chạy lại app sau nhé!"];
            }
            [NSApp terminate:self];
        }
    }];
}

- (void)showErrorWithMessageText:(NSString *)mText andInformativeText:(NSString *)iText {
    
    NSAlert *al = [[NSAlert alloc] init];
    [al setMessageText:mText];
    [al setInformativeText:iText];
    [al runModal];
}

#pragma mark - Launch at login
- (BOOL)launchOnLogin
{
    LSSharedFileListRef loginItemsListRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    CFArrayRef snapshotRef = LSSharedFileListCopySnapshot(loginItemsListRef, NULL);
    NSArray* loginItems = CFBridgingRelease(snapshotRef);
    NSURL *bundleURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    for (id item in loginItems) {
        LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)CFBridgingRetain(item);
        CFURLRef itemURLRef;
        if (LSSharedFileListItemResolve(itemRef, 0, &itemURLRef, NULL) == noErr) {
            NSURL *itemURL = (NSURL *)CFBridgingRelease(itemURLRef);
            if ([itemURL isEqual:bundleURL]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)setLaunchOnLogin:(BOOL)launchOnLogin
{
    NSURL *bundleURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    LSSharedFileListRef loginItemsListRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    
    if (launchOnLogin) {
        NSDictionary *properties;
        properties = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"com.apple.loginitem.HideOnLaunch"];
        LSSharedFileListItemRef itemRef = LSSharedFileListInsertItemURL(loginItemsListRef, kLSSharedFileListItemLast, NULL, NULL, (CFURLRef)CFBridgingRetain(bundleURL), (CFDictionaryRef)CFBridgingRetain(properties),NULL);
        if (itemRef) {
            CFRelease(itemRef);
        }
    } else {
        LSSharedFileListRef loginItemsListRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
        CFArrayRef snapshotRef = LSSharedFileListCopySnapshot(loginItemsListRef, NULL);
        NSArray* loginItems = CFBridgingRelease(snapshotRef);
        
        for (id item in loginItems) {
            LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)CFBridgingRetain(item);
            CFURLRef itemURLRef;
            if (LSSharedFileListItemResolve(itemRef, 0, &itemURLRef, NULL) == noErr) {
                NSURL *itemURL = (NSURL *)CFBridgingRelease(itemURLRef);
                if ([itemURL isEqual:bundleURL]) {
                    LSSharedFileListItemRemove(loginItemsListRef, itemRef);
                }
            }
        }
    }
}


- (void)setupStatusItem {
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSImage *menuIcon = [NSImage imageNamed:@"mfinger"];
    NSImage *highlightIcon = [NSImage imageNamed:@"mfinger"]; // Yes, we're using the exact same image asset.
    [highlightIcon setTemplate:YES]; // Allows the correct highlighting of the icon when the menu is clicked.
    [[self statusItem] setImage:menuIcon];
    [[self statusItem] setAlternateImage:highlightIcon];
    [[self statusItem] setMenu:nil];
    [[self statusItem] setHighlightMode:YES];
    [self setupMenuItems];
}

- (void)setupMenuItems {
    NSMenu *menu = [[NSMenu alloc] init];
    
    //Add items for image category
    //[menu addItemWithTitle:@"Hóng" action:@selector(getRandomImage:) keyEquivalent:@""];
    
    for (PQImageCategory *imgCat in _imageCategories) {
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:imgCat.name
                                                      action:@selector(getRandomImage:)
                                               keyEquivalent:@""];
        [item setRepresentedObject:imgCat];
        [menu addItem:item];
    }
    //Seperator
    [menu addItem:[NSMenuItem separatorItem]];
    
    
    _launchOnLogInItem = [[NSMenuItem alloc] initWithTitle:@"Tự động chạy khi đăng nhập" action:@selector(getLaunchOnLoginAction:) keyEquivalent:@""];
    [_launchOnLogInItem setState:[self launchOnLogin]];
    [menu addItem:_launchOnLogInItem];
    //Seperator
    [menu addItem:[NSMenuItem separatorItem]];
    
    //Add option item
    //[menu addItemWithTitle:@"Óp sình" action:@selector(getOptionAction:) keyEquivalent:@""];
    
    //Add about item
    [menu addItemWithTitle:@"Ờ bao" action:@selector(getAboutAction:) keyEquivalent:@""];
    
    //Seperator
    [menu addItem:[NSMenuItem separatorItem]];
    
    //Add quit item
    [menu addItemWithTitle:@"Thoát" action:@selector(getQuitAction:) keyEquivalent:@""];
    
    _statusItem.menu = menu;
}

- (void)getLaunchOnLoginAction:(id)sender {
    BOOL isLaunch = [self launchOnLogin];
    [_launchOnLogInItem setState:!isLaunch];
    [self setLaunchOnLogin:!isLaunch];
}

- (void)getRandomImage:(id)sender {
    PQImageCategory *imgCat = (PQImageCategory *)[sender representedObject];
    NSArray *images = [imgCat imageArray];
    
    if ([images count] > 0) {
        PQImage *image = (PQImage *)images[arc4random_uniform((unsigned int)[images count])];
        NSString *toCopyString = [NSString stringWithFormat:@"%@\n%@", imgCat.name, image.imageUrl];
        
        NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
        [pasteboard clearContents];
        
        NSArray *objectsToCopy = @[toCopyString];
        
        [pasteboard writeObjects:objectsToCopy];
    }
    
    [self presentMessage:imgCat.name];
}

- (void)presentMessage:(NSString *)message {
    NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _copiedWC = [sb instantiateControllerWithIdentifier:@"CopiedWindowController"];
    
    [(PQCopiedViewController *)[_copiedWC contentViewController] setString:message];
    
    [_copiedWC showWindow:_copiedWC];
    [[_copiedWC window] center];
}

- (void)getOptionAction:(id)sender {
    NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _optionWC = [sb instantiateControllerWithIdentifier:@"OptionWindowController"];
    [_optionWC showWindow:_optionWC];
}

- (void)getAboutAction:(id)sender {
    NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    _aboutWC = [sb instantiateControllerWithIdentifier:@"AboutWindowController"];
    [_aboutWC showWindow:_aboutWC];
}

- (void)getQuitAction:(id)sender {
    [NSApp terminate:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
