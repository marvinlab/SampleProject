//
//  MainViewController.m
//  SampleProject
//
//  Created by Temp User on 2/5/15.
//  Copyright (c) 2015 Temp User. All rights reserved.
//

#import "MainViewController.h"
#import "ObjectAL.h"
#import "SoundFiles.h"

@interface MainViewController ()
@property (nonatomic, retain) IBOutlet UIPickerView *songPicker;
@property (nonatomic, retain) IBOutlet UIButton *playBtn;
@property (nonatomic, retain) IBOutlet UIButton *StopBtn;
@property (retain, nonatomic) IBOutlet UILabel *playPercentage;
@property (retain, nonatomic) IBOutlet UILabel *volumeValue;
@property (retain, nonatomic) IBOutlet UISwitch *muteUnmute;
@property (retain, nonatomic) IBOutlet UILabel *muteLabel;

@property (nonatomic, retain) NSTimer *updater;

@property (nonatomic, retain) ALSource *soundSource;
@property (nonatomic, retain) ALBuffer *soundBuffer;
@property (nonatomic, retain) ALDevice* device;
@property (nonatomic, retain) ALContext* context;
@property (nonatomic, retain) ALChannelSource* channel;
@property (nonatomic, retain) OALAudioTrack* audioTrack;


@property (retain, nonatomic) IBOutlet UISlider *panSlider;
@property (retain, nonatomic) IBOutlet UISlider *volumeSlider;


@property (retain, nonatomic) NSArray *arrayOfSounds;

-(IBAction)playSelectedTrack:(id)sender;
-(IBAction)stopSelectedTrack:(id)sender;
-(IBAction)soundOverBtn:(id)sender;

-(IBAction)volumeControl:(id)sender;
-(IBAction)panMoved:(id)sender;
-(IBAction)muteAndUnmute:(id)sender;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.songPicker.delegate = self;
    self.arrayOfSounds = [[NSArray alloc]initWithObjects:kSPDemoAudioColdFunkIntro,kSPDemoAudioColdFunk,kSPDemoAudioHappyAlley,kSPDemoAudioPew,kSPDemoAudioPow,kSPLodsBGMEvBattle,kSPLodsBGMEvQuest,kSPLodsBGMNormBattle,kSPLodsBGMNormQuest,kSPLodsBGMRaid1,kSPLodsBGMRaid2,kSPLodsBGMTop,kSPLodsSEBattleKilled,kSPLodsSEBattleLost,kSPLodsSEBattleRobbed,kSPLodsSEBattleWon,kSPLodsSECollectionComplete,kSPLodsSECommon1,kSPLodsSECommon2,kSPLodsSECommon3,kSPLodsSEExpUp,kSPLodsSEFairiesCollected,kSPLodsSEFairiesSend,kSPLodsSEIncentiveAccept,kSPLodsSEIntro,kSPLodsSEPlayerLVUp,kSPLodsSEQuestBossAtk,kSPLodsSEQuestBossAtkCritical,kSPLodsSEQuestBossDamaged,kSPLodsSEQuestComplete,kSPLodsSEQuestWalk,kSPLodsSERaidAtk1,kSPLodsSERaidAtk2,kSPLodsSERaidAtk3,kSPLodsSERaidAtk4,kSPLodsSERaidAtk5,kSPLodsSERaidAtkFinish,kSPLodsSERaidDmg1,kSPLodsSERaidDmg2,kSPLodsSERaidDmg3,kSPLodsSERaidIn,kSPLodsSERaidLose,kSPLodsSERaidOut,kSPLodsSERaidSkl1,kSPLodsSERaidSkl2,kSPLodsSERaidSkl3,kSPLodsSERaidSkl4,kSPLodsSERaidSkl5,kSPLodsSERaidSklDef1,kSPLodsSERaidSklDef2,kSPLodsSERaidSklDef3,kSPLodsSERaidSklDmgCap,kSPLodsSERaidSklHeal,kSPLodsSERaidSklSeal,kSPLodsSERaidWin,kSPLodsSERaidWordCutin,kSPLodsSERecover,kSPLodsSESecretBoxOpen,kSPLodsSESecretBoxStart,kSPLodsSEShopBuy,kSPLodsSEStoryPage,kSPLodsSEUnitEvolve,kSPLodsSEWarriorLVUp,nil];
    
    self.updater = [NSTimer timerWithTimeInterval:0.2
                                           target:self
                                         selector:@selector(update)
                                         userInfo:nil
                                          repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.updater forMode:NSDefaultRunLoopMode];
}

- (void)dealloc {
    [_songPicker release];
    [_playBtn release];
    [_StopBtn release];
    self.arrayOfSounds = nil;
    self.audioTrack = nil;
    [_panSlider release];
    [_volumeSlider release];
    [_playPercentage release];
    [_volumeValue release];
    [_muteUnmute release];
    [_muteLabel release];
    [super dealloc];
}

-(void)update
{
    NSInteger percentagePlaying = (self.audioTrack.currentTime / self.audioTrack.duration) * 100;
    
    [self.panSlider setValue:percentagePlaying animated:YES];
    self.playPercentage.text = [NSString stringWithFormat:@"%ld",(long)percentagePlaying];

}


#pragma mark ################### Button Actions ####################


-(void)playSelectedTrack:(id)sender
{
    //NSLog(@"%@",[self.arrayOfSounds objectAtIndex:[self.songPicker selectedRowInComponent:0]]);
    NSString *selectedSong = [[self.arrayOfSounds objectAtIndex:[self.songPicker selectedRowInComponent:0]] stringByAppendingString:kSPSoundFileExtensionCaf];

    self.audioTrack = [[OALAudioTrack alloc]init];
    [self.audioTrack playFile:selectedSong];
    self.audioTrack.volume = 0.7;
}

-(void)stopSelectedTrack:(id)sender
{
    self.audioTrack = nil;
}

-(void)soundOverBtn:(id)sender
{
    self.audioTrack = [[[OALAudioTrack alloc]init]autorelease];
    [self.audioTrack playFile:[kSPDemoAudioPew stringByAppendingString:kSPSoundFileExtensionCaf]];
}

-(void)muteAndUnmute:(id)sender
{
    if ([self.muteUnmute isOn]) {
        [self.muteUnmute setOn:YES animated:YES];
        self.audioTrack.muted = NO;
        [self.muteLabel setText:@"Mute"];
    } else {
        [self.muteUnmute setOn:NO animated:YES];
        self.audioTrack.muted = YES;
        [self.muteLabel setText:@"Unmute"];
    }
}

#pragma mark ################### Picker View Data Source ####################

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.arrayOfSounds count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.arrayOfSounds objectAtIndex:row];
}

#pragma mark ################### Slider Actions ####################

-(void)volumeControl:(id)sender
{
    self.audioTrack.volume = self.volumeSlider.value * .1;
    self.volumeValue.text = [NSString stringWithFormat:@"%ld",(long)self.volumeSlider.value];

}

-(void)panMoved:(id)sender
{
    self.playPercentage.text = [NSString stringWithFormat:@"%ld",(long)self.panSlider.value];
    NSInteger panTo = (self.audioTrack.duration * self.panSlider.value) / 100;
    
    self.audioTrack.currentTime = panTo;
    
    
}



@end
