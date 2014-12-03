//
//  ViewController.m
//  AAShareBubbles
//
//  Created by Almas Adilbek on 11/26/13.
//  Copyright (c) 2013 GoodApp inc. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#define CUSTOM_BUTTON_ID 100

@interface ViewController ()

@end

@implementation ViewController {
    AAShareBubbles *shareBubbles;
    float radius;
    float bubbleRadius;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    radius = 130;
    bubbleRadius = 40;
    _radiusSlider.value = radius;
    _bubbleRadiusSlider.value = bubbleRadius;
    
    _radiusLabel.text = [NSString stringWithFormat:@"%.0f", radius];
    _bubbleRadiusLabel.text = [NSString stringWithFormat:@"%.0f", bubbleRadius];
}

- (IBAction)shareTapped:(id)sender
{
    if(shareBubbles) {
        shareBubbles = nil;
    }
    shareBubbles = [[AAShareBubbles alloc] initWithPoint:_shareButton.center radius:radius inView:self.view title:@"Share your post?" subtitle:@"Let your friends know about your giveaway by sharing a link to it."];
    shareBubbles.delegate = self;
    shareBubbles.bubbleRadius = bubbleRadius;
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        shareBubbles.showFacebookBubble = YES;
    }
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        shareBubbles.showTwitterBubble = YES;
    }
    
//    shareBubbles.showGooglePlusBubble = YES;
//    shareBubbles.showTumblrBubble = YES;
//    shareBubbles.showVkBubble = YES;
//    shareBubbles.showLinkedInBubble = YES;
//    shareBubbles.showYoutubeBubble = YES;
//    shareBubbles.showVimeoBubble = YES;
//    shareBubbles.showRedditBubble = YES;
//    shareBubbles.showPinterestBubble = YES;
//    shareBubbles.showInstagramBubble = YES;
    shareBubbles.showWhatsappBubble = YES;
    if ([MFMailComposeViewController canSendMail]) {
//        shareBubbles.showMailBubble = YES;
    }
    
    
    
    shareBubbles.titleColor = [UIColor blackColor];
    shareBubbles.subtitleColor = [UIColor blackColor];
    shareBubbles.faderAlpha = 0.1;
    
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"icon-aa-at"]
                          backgroundColor:[UIColor colorWithRed:51/255.0 green:157/255.0 blue:246/255.0 alpha:1.0]
                              andButtonId:CUSTOM_BUTTON_ID];
    
//    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"custom-vine-icon"]
//                          backgroundColor:[UIColor colorWithRed:13/255.0 green:95/255.0 blue:250/255.0 alpha:1.0]
//                              andButtonId:CUSTOM_BUTTON_ID + 1];
    
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"custom-vine-icon"]
                          backgroundColor:[UIColor whiteColor]
                              andButtonId:CUSTOM_BUTTON_ID + 1];
    
    
    [shareBubbles show];
}

- (IBAction)radiusValueChanged:(id)sender {
    radius = [(UISlider *)sender value];
    _radiusLabel.text = [NSString stringWithFormat:@"%.0f", radius];
}

- (IBAction)bubbleRadiusValueChanged:(id)sender {
    bubbleRadius = [(UISlider *)sender value];
    _bubbleRadiusLabel.text = [NSString stringWithFormat:@"%.0f", bubbleRadius];
}

#pragma mark -
#pragma mark AAShareBubbles

-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(int)bubbleType
{
    switch (bubbleType) {
        case AAShareBubbleTypeFacebook:
            NSLog(@"Facebook");
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController *tweetSheet = [SLComposeViewController
                                                       composeViewControllerForServiceType:SLServiceTypeFacebook];
                [tweetSheet setInitialText:@"Great fun to learn iOS programming at appcoda.com!"];
                [tweetSheet addURL:[NSURL URLWithString:@"https://tryneighborly.com/i/4SBbyXe3Fp"]];
//                [tweetSheet addImage:[UIImage imageNamed:@"custom-vine-icon"]];
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }
            break;
        case AAShareBubbleTypeTwitter:
            NSLog(@"Twitter");
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController *tweetSheet = [SLComposeViewController
                                                       composeViewControllerForServiceType:SLServiceTypeTwitter];
                [tweetSheet setInitialText:@"Great fun to learn iOS programming at appcoda.com!"];
                [tweetSheet addURL:[NSURL URLWithString:@"https://tryneighborly.com/i/4SBbyXe3Fp"]];
//                [tweetSheet addImage:[UIImage imageNamed:@"custom-vine-icon"]];
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }
            break;
        case AAShareBubbleTypeGooglePlus:
            NSLog(@"Google+");
            break;
        case AAShareBubbleTypeTumblr:
            NSLog(@"Tumblr");
            break;
        case AAShareBubbleTypeVk:
            NSLog(@"Vkontakte (vk.com)");
            break;
        case AAShareBubbleTypeLinkedIn:
            NSLog(@"LinkedIn");
            break;
        case AAShareBubbleTypeYoutube:
            NSLog(@"Youtube");
            break;
        case AAShareBubbleTypeVimeo:
            NSLog(@"Vimeo");
            break;
        case AAShareBubbleTypeReddit:
            NSLog(@"Reddit");
            break;
        case AAShareBubbleTypeMail:
            NSLog(@"Mail");
            break;
        case CUSTOM_BUTTON_ID:
            NSLog(@"Custom Button With Type %d", bubbleType);
            break;
        default:
            break;
    }
}

-(void)aaShareBubblesDidHide:(AAShareBubbles*)bubbles {
    NSLog(@"All Bubbles hidden");
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setShareButton:nil];
    [self setRadiusSlider:nil];
    [self setRadiusLabel:nil];
    [self setBubbleRadiusSlider:nil];
    [self setBubbleRadiusLabel:nil];
    [super viewDidUnload];
}
@end
