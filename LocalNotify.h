//
//  LocalNotify.h
//  闹钟
//
//  Created by WeichengWang on 16/8/3.
//  Copyright © 2016年 chaoyue3116. All rights reserved.
//

#import <Foundation/Foundation.h>


//定义枚举类型
typedef enum {
    RepeatUnitTypeOnce = 0,//一次
    RepeatUnitTypeDay,//每天
    RepeatUnitTypeWorkDay,//工作日

} RepeatUnitType;

@interface LocalNotify : NSObject

#pragma mark - add Notify


+ (void)addLocalNotifyKeyString:(NSString *)key Date:(NSDate *)date;

+ (void)addLocalNotifyKeyString:(NSString *)key Date:(NSDate *)date AlertBody:(NSString *)bodyString;

+ (void)addLocalNotifyKeyString:(NSString *)key Date:(NSDate *)date AlertBody:(NSString *)bodyString repeatInterval:(RepeatUnitType)inteval;

/**
 *  添加通知
 *
 *  @param key           唯一标识符
 *  @param date          时间
 *  @param bodyString    通知时显示的内容
 *  @param soundFileName 通知时播放的声音文件名
 *  @param voice         语音播报提示语语句
 *  @param inteval       重复周期
 *  @param target        UIAlertController提示窗显示的位置
 *  @param remind        UIAlertController提示内容
 */
+ (void)addLocalNotifyKeyString:(NSString *)key Date:(NSDate *)date AlertBody:(NSString *)bodyString SoundName:(NSString *)soundFileName  VoiceString:(NSString *)voice repeatInterval:(RepeatUnitType)inteval remindControllerTarget:(id)target remindSring:(NSString *)remind;




#pragma mark - delete Notify


/**
 *  取消闹钟
 *
 *  @param keyString 唯一标识符
 */
+(void)cancelNotifyWithKey:(NSString *)keyString VoiceString:(NSString *)voiceString;

/**
 *  取消所有闹钟
 */
+ (void)cancellAllNotifyVoiceString:(NSString *)voiceString;

/**
 *  取消所有闹钟
 */
+ (void)cancellAllNotify;

@end
