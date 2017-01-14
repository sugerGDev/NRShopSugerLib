//
//  JPVideoPlayer.h
//  JPVideoPlayer
//
//  Created by lava on 16/9/13.
//  Hello! I am NewPan from Guangzhou of China, Glad you could use my framework, If you have any question or wanna to contact me, please open https://github.com/Chris-Pan or http://www.jianshu.com/users/e2f2d779c022/latest_articles


/**
 * It is singleton, Through pass in video url(network url only) and the view of video will play on, it can auto play video on the view passed in.
 * It also have the function that play video and save the downloaded video srouce at the same time.
 * It can auto save data as temporary file when requesting data from network.
 * It also can auto move temporary file to the path you assigned when the temporary file is a complete file (mean that the length of temporary file is equal to the file in network) after request finished or canceled.
 * And it will auto delete the temporary file if the temporary file is not a complete file after request finished or canceled.
 * The video player's picture size is equal to the view passed in.
 * When switch video url, it will realease the all configuration before first, and re-create all configuration again.
 * The player logic is that find cache in dick first, if find, take out video data from disk to player. if not find, then play video from network.
 * 这是一个单例, 你只需要传递需要播放的路径(网络路径)和视频图像的载体, 就会自动帮你播放视频.
 * 支持边下边播, 会自动缓存数据.
 * 从网络请求数据，并把数据保存到本地的一个临时文件.
 * 当网络请求结束或取消的时候，如果数据完整，则把数据缓存到指定的路径，不完整就删除.
 * 图像尺寸和传进来的图像载体的尺寸一致.
 * 当切换视频的时候, 会释放之前的所有播放视频所有要的配置, 然后重新创建这些配置.
 * 播放逻辑是, 先从本地缓存中查找有缓存没有, 如果有, 就从本地读取数据播放. 如果没有, 再从网络加载数据播放.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JPCacheManager.h"
#import "JPDownloadManager.h"

@class JPVideoPlayer;

/**
 当前播放状态回调协议
 */
@protocol JPVideoPlayerStatusDelegate<NSObject>
- (void)jpVideoPlayer:(JPVideoPlayer *)player WithPlayerStatus:(AVPlayerItemStatus)playerStatus;
@end

/**
 * Use custom loading need implement this protocol.
 * 使用自定义的loading时, 需实现此协议
 */
@protocol JPVideoPlayerLoadingDelegate<NSObject>

@required
- (void)startAnimating;
- (void)stopAnimating;

@end


@interface JPVideoPlayer : NSObject

/**
 * Singleton.
 * 单例
 */
+ (instancetype)sharedInstance;


/**
 播放状态协议Delegate
 */
@property (nonatomic , weak) id<JPVideoPlayerStatusDelegate> pStatusDelegate;

/**
 * Play video method.
 * Through pass in video url(network url only) and the view of video will play on, it can auto play video on the view passed in.
 * It also have the function that play video and save the downloaded video srouce at the same time.
 * It can auto save data as temporary file when requesting data from network.
 * It also can auto move temporary file to the path you assigned when the temporary file is a complete file (mean that the length of temporary file is equal to the file in network) after request finished or canceled.
 * And it will auto delete the temporary file if the temporary file is not a complete file after request finished or canceled.
 * The video player's picture size is equal to the view passed in.
 * When switch video url, it will realease the all configuration before first, and re-create all configuration again.
 * The player logic is that find cache in dick first, if find, take out video data from disk to player. if not find, then play video from network.
 * 你只需要传递需要播放的路径(网络路径)和视频图像的载体, 就会自动帮你播放视频.
 * 支持边下边播, 会自动缓存数据.
 * 从网络请求数据，并把数据保存到本地的一个临时文件.
 * 当网络请求结束或取消的时候，如果数据完整，则把数据缓存到指定的路径，不完整就删除.
 * 图像尺寸和传进来的图像载体的尺寸一致.
 * 当切换视频的时候, 会释放之前的所有播放视频所有要的配置, 然后重新创建这些配置.
 * 播放逻辑是, 先从本地缓存中查找有缓存没有, 如果有, 就从本地读取数据播放. 如果没有, 再从网络加载数据播放.
 */
- (void)playWithUrl:(NSURL *)url showView:(UIView *)showView;


/**
 * Default is YES.
 */
@property (nonatomic, assign) BOOL showActivityWhenLoading;

/**
 * The loading view before video play.
 * 视频加载视图, 默认为系统UIActivityIndicatorView
 * Default is UIActivityIndicatorView
 */
@property (nonatomic,strong) UIView<JPVideoPlayerLoadingDelegate> *loadingView;

/**
 * Default is YES.
 */
@property (nonatomic, assign) BOOL stopWhenAppDidEnterBackground;

/**
 * Mute.
 * 静音
 */
@property(nonatomic, assign)BOOL mute;

-(void)resume;
-(void)pause;
-(void)stop;
- (BOOL)isInitRes;


/** 
 * The maximum disk cache. 1GB default, automatic clear all cache when the size of cache > 1GB.
 * 最大磁盘缓存. 默认为 1G, 超过 1G 将自动清空所有视频磁盘缓存.
 */
@property(nonatomic, assign)unsigned long long  maxCacheSize;

/**
 * Clear video cache for the given url asynchronously.
 * 清除指定URL的缓存视频文件(异步).
 * @param url   the url of video file.
 */
-(void)clearVideoCacheForUrl:(NSURL *)url;

/**
 * Clear complete files and temporary files asynchronously.
 * 清除所有的缓存(异步), 包括完整视频文件和临时视频文件.
 */
-(void)clearAllVideoCache;

/**
 * Get the total size of complete files and temporary files asynchronously.
 * 获取缓存总大小(异步), 包括完整视频文件和临时视频文件.
 */
-(void)getSize:(JPCacheQueryCompletedBlock)completedOperation;

@end

