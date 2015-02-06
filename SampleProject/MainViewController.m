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

@property (nonatomic, retain) ALSource *soundSource;
@property (nonatomic, retain) ALBuffer *soundBuffer;
@property (nonatomic, retain) ALDevice* device;
@property (nonatomic, retain) ALContext* context;
@property (nonatomic, retain) ALChannelSource* channel;
@property (nonatomic, retain) OALAudioTrack* audioTrack;


@property (retain, nonatomic) NSArray *arrayOfSounds;

-(IBAction)playSelectedTrack:(id)sender;
-(IBAction)stopSelectedTrack:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.songPicker.delegate = self;
    self.arrayOfSounds = [[NSArray alloc]initWithObjects:kSPDemoAudioColdFunkIntro,kSPDemoAudioColdFunk,kSPDemoAudioHappyAlley,kSPDemoAudioPew,kSPDemoAudioPow,kSPLodsBGMEvBattle,kSPLodsBGMEvQuest,kSPLodsBGMNormBattle,kSPLodsBGMNormQuest,kSPLodsBGMRaid1,kSPLodsBGMRaid2,kSPLodsBGMTop,kSPLodsSEBattleKilled,kSPLodsSEBattleLost,kSPLodsSEBattleRobbed,kSPLodsSEBattleWon,kSPLodsSECollectionComplete,kSPLodsSECommon1,kSPLodsSECommon2,kSPLodsSECommon3,kSPLodsSEExpUp,kSPLodsSEFairiesCollected,kSPLodsSEFairiesSend,kSPLodsSEIncentiveAccept,kSPLodsSEIntro,kSPLodsSEPlayerLVUp,kSPLodsSEQuestBossAtk,kSPLodsSEQuestBossAtkCritical,kSPLodsSEQuestBossDamaged,kSPLodsSEQuestComplete,kSPLodsSEQuestWalk,kSPLodsSERaidAtk1,kSPLodsSERaidAtk2,kSPLodsSERaidAtk3,kSPLodsSERaidAtk4,kSPLodsSERaidAtk5,kSPLodsSERaidAtkFinish,kSPLodsSERaidDmg1,kSPLodsSERaidDmg2,kSPLodsSERaidDmg3,kSPLodsSERaidIn,kSPLodsSERaidLose,kSPLodsSERaidOut,kSPLodsSERaidSkl1,kSPLodsSERaidSkl2,kSPLodsSERaidSkl3,kSPLodsSERaidSkl4,kSPLodsSERaidSkl5,kSPLodsSERaidSklDef1,kSPLodsSERaidSklDef2,kSPLodsSERaidSklDef3,kSPLodsSERaidSklDmgCap,kSPLodsSERaidSklHeal,kSPLodsSERaidSklSeal,kSPLodsSERaidWin,kSPLodsSERaidWordCutin,kSPLodsSERecover,kSPLodsSESecretBoxOpen,kSPLodsSESecretBoxStart,kSPLodsSEShopBuy,kSPLodsSEStoryPage,kSPLodsSEUnitEvolve,kSPLodsSEWarriorLVUp,nil];


}

- (void)dealloc {
    [_songPicker release];
    [_playBtn release];
    [_StopBtn release];
    self.arrayOfSounds = nil;
    [super dealloc];
}


#pragma mark ################### Button Actions ####################


-(void)playSelectedTrack:(id)sender
{
    //NSLog(@"%@",[self.arrayOfSounds objectAtIndex:[self.songPicker selectedRowInComponent:0]]);
    NSString *selectedSong = [[self.arrayOfSounds objectAtIndex:[self.songPicker selectedRowInComponent:0]] stringByAppendingString:kSPSoundFileExtensionCaf];

    [[OALSimpleAudio sharedInstance]playBg:selectedSong];
}

-(void)stopSelectedTrack:(id)sender
{
    [[OALSimpleAudio sharedInstance]stopBg];
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



@end
