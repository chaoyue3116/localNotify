//
//  LocalNotify.m
//  闹钟
//
//  Created by WeichengWang on 16/8/3.
//  Copyright © 2016年 chaoyue3116. All rights reserved.
//

#import "LocalNotify.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>



@implementation LocalNotify


#pragma mark - add LocalNotify

+ (void)addLocalNotifyKeyString:(NSString *)key Date:(NSDate *)date{
    
    [self addLocalNotifyKeyString:key Date:date AlertBody:@"" SoundName:nil VoiceString:nil repeatInterval:0 remindControllerTarget:nil remindSring:nil];
}

+ (void)addLocalNotifyKeyString:(NSString *)key Date:(NSDate *)date AlertBody:(NSString *)bodyString{
    
     [self addLocalNotifyKeyString:key Date:date AlertBody:bodyString SoundName:nil VoiceString:nil repeatInterval:0 remindControllerTarget:nil remindSring:nil];
}

+ (void)addLocalNotifyKeyString:(NSString *)key Date:(NSDate *)date AlertBody:(NSString *)bodyString repeatInterval:(RepeatUnitType)inteval{
    
    [self addLocalNotifyKeyString:key Date:date AlertBody:bodyString SoundName:nil VoiceString:nil repeatInterval:inteval remindControllerTarget:nil remindSring:nil];
}

+ (void)addLocalNotifyKeyString:(NSString *)key Date:(NSDate *)date AlertBody:(NSString *)bodyString SoundName:(NSString *)soundFileName  VoiceString:(NSString *)voice repeatInterval:(RepeatUnitType)inteval remindControllerTarget:(id)target remindSring:(NSString *)remind{
    
    [self registerLocalNotifycation];
    
    if (!key || !date ||!bodyString) return;//必要条件
    
    //删除同一个key重复的闹钟
    [self deleteLocalNotifyWithKey:key];
    
    //创建推送
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    //注册key
    NSDictionary *dict = @{@"LocalNotifyName":key};
    localNotification.userInfo = dict;
    //设置推送时间
    [localNotification setFireDate:date];
    //设置时区
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    //推送内容
    [localNotification setAlertBody:bodyString];
    //推送声音
    if (soundFileName) {
        [localNotification setSoundName:@"weight_ok.mp3"];
    }
    //语音提示声音
    if (voice) {
        [self voiceAnnouncementsText:voice];
    }
    //重复周期
    if (!inteval) {
        localNotification.repeatInterval = 0;
    }else{
        if (inteval == RepeatUnitTypeOnce) {
            
            localNotification.repeatInterval = 0;
            
        }else if (inteval == RepeatUnitTypeDay){
            
            localNotification.repeatInterval = NSCalendarUnitDay;
        }
        else if (inteval == RepeatUnitTypeWorkDay){
            
            localNotification.repeatInterval = NSCalendarUnitWeekday;
        }
    }
    //添加推送到UIApplication
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    //UIAlertController弹窗提示
    if (target && remind) {
        [self remindController:remind postView:target];
    }

}

#pragma mark - Delete LocalNotify

+(void)cancelNotifyWithKey:(NSString *)keyString VoiceString:(NSString *)voiceString{
    if (!keyString)return;
    
    [self deleteLocalNotifyWithKey:keyString];
    
    if (voiceString) {
        [self voiceAnnouncementsText:voiceString];
    }

}

+ (void)cancellAllNotifyVoiceString:(NSString *)voiceString{
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    if (voiceString) {
        [self voiceAnnouncementsText:voiceString];
    }
}

+ (void)cancellAllNotify{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}


#pragma mark - SupportMethods

+(void)deleteLocalNotifyWithKey:(NSString *)keyString{
    
    UIApplication * application =[UIApplication sharedApplication];
    NSArray * array=[application scheduledLocalNotifications];
    
    for (UILocalNotification * local in array) {
        NSDictionary * dic= local.userInfo;
        if ([dic[@"LocalNotifyName"] isEqual:keyString]) {
            
            [application cancelLocalNotification:local];
        }
    }
}

+ (void)registerLocalNotifycation{
    
    UIApplication * application =[UIApplication sharedApplication];
    
    UIUserNotificationSettings* setting= [application currentUserNotificationSettings];

    if(setting.types==UIUserNotificationTypeNone){
        
        UIUserNotificationSettings* newSetting= [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        
        [application registerUserNotificationSettings:newSetting];
    }
}



//语音播报
+ (void)voiceAnnouncementsText:(NSString *)text
{
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    [synthesizer speakUtterance:utterance];
}

//提示页面
+ (void)remindController:(NSString *)remindText postView:(id)target
{
    //提示页面（8.0出现）
    /**
     *  1.创建UIAlertController的对象
     2.创建UIAlertController的方法
     3.控制器添加action
     4.用presentViewController模态视图控制器
     */
    UIAlertController *alart = [UIAlertController alertControllerWithTitle:@"" message:remindText preferredStyle:UIAlertControllerStyleActionSheet];
    [target presentViewController:alart animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alart dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}


@end
