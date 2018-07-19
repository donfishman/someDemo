//
//  NSString+CachePath.m
//  Sqlite
//
//  Created by 唐仁于 on 2018/7/5.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "NSString+CachePath.h"

@implementation NSString (CachePath)

+(NSString *)cachePathWithFileName:(NSString *)fileName
{
    
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName];
}
@end
