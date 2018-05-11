//
//  XYSDKParam.h
//  XYSDK
//
//  Created by 王云刚 on 2018/3/11.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - XYSDKParam
/*！@brief 该类为小悦SDK初始化参数结构
 *
 */
@interface XYSDKParam : NSObject
/** AppID **/
@property (strong, nonatomic) NSString *appID;
/** appSecret **/
@property (strong, nonatomic) NSString *appSecret;
/** AppSecretKey **/
@property (strong, nonatomic) NSString *appSecretKey;
@end

#pragma mark - XYSDKBaseResp
/*! @brief 该类为小悦SDK所有响应类的基类
 *
 */
@interface XYSDKBaseResp : NSObject
/** 错误码 */
@property (nonatomic, assign) int errCode;
/** 错误提示字符串 */
@property (strong, nonatomic) NSString *errStr;
/** 响应类型 */
@property (nonatomic, assign) int type;
@end
