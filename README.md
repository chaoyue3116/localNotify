# localNotify
闹钟 alarmClock  一句话利用本地推送实现闹钟(不在后台照样运行,支持语音提示,弹窗提示,支持key区分多条闹钟)




 [LocalNotify addLocalNotifyKeyString:@"key" Date:date AlertBody:bodyStr SoundName:nil VoiceString:@"成功添加闹钟" repeatInterval:0 remindControllerTarget:self remindSring:@"成功添加"];
