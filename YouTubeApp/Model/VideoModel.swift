//
//  VideoModel.swift
//  YouTubeApp
//
//  Created by 洋蔥胖 on 2018/7/13.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol VideoModelDelegate {
    func dataReady()
}

class VideoModel: NSObject {
    
    let url = "https://www.googleapis.com/youtube/v3/playlistItems"
    let urlString = "https://www.youtube.com/watch?v=fIotIdt-K5E&list=PLH2b4YnNI7j13eD1KdpEV3t7VEWtRQlYY"
    let API_KEY = "AIzaSyDNDzZ0rX4ucPODmEUZYAcnQobujfFPNfA"
    //卡提諾狂新聞：PLH2b4YnNI7j13eD1KdpEV3t7VEWtRQlYY ，四超玩：PL_mdITDph7YjdClTzHJJwBv07ws_W7w9Z
    let UPLOADS_PLAYLIST_ID = "PLH2b4YnNI7j13eD1KdpEV3t7VEWtRQlYY"
    
    let channelId = "UCLW_SzI9txZvtOFTPDswxqg"
    let maxResults = 10
    let mine = false
    var videoArray = [Video]()
    var delegate:VideoModelDelegate?
    
    //MARK: - Networking
    func getFeedVideos() {
        let parameters: Parameters = ["part":"snippet,contentDetails","key":API_KEY ,"playlistId":UPLOADS_PLAYLIST_ID ,"maxResults":maxResults ]
        //Fetch the videos dynamically through the YouTube Data API
        Alamofire.request(url, method: .get, parameters: parameters)
            
            .responseJSON { response in
//                debugPrint(response)
                if response.result.isSuccess {
                    let videoJSON : JSON = JSON(response.result.value!)
                    print("看這裡：\(videoJSON)")
                    
                    var arrayOfVideos = [Video]()
                    
                    if let result = videoJSON["items"].array{
                        for data in result {
                            let videoObj = Video()
                            videoObj.videoId = data["snippet"]["resourceId"]["videoId"].stringValue
                            videoObj.videoTitle = data["snippet"]["title"].stringValue
                            videoObj.videoDescription = data["snippet"]["description"].stringValue
                            videoObj.videoThumbnailUrl = data["snippet"]["thumbnails"]["maxres"]["url"].stringValue
                            
                            arrayOfVideos.append(videoObj)
                        }
                        //When all the video objects have been constructed, assign the array to the VideoModel property
                        self.videoArray = arrayOfVideos
                        
                        //Notify the delegate that the data is ready
                        if self.delegate != nil {
                            self.delegate!.dataReady()
                        }
                        
                    }
                }
                
                
                
        }
            
       
        
        
        
    }
    
    func getVideos() -> [Video] {
        var videos = [Video]()
        
        //Create a video object
        let video1 = Video()
        
        //Assign properties
        video1.videoId = "Qkf4farak1k" //thumbnail https://i1.ytimg.com/vi/Qkf4farak1k/mqdefault.jpg
        video1.videoTitle = "《一日系列第六十九集》最強主管～市長柯P來了！邰哥來挑戰史上最崩潰工作！-一日市長幕僚feat.柯文哲 One-Day Taipei Mayor Staff"
        video1.videoDescription = "請訂閱我們的頻道：http://bit.ly/2pC9d4e 第一時間看我們的新作品，參與直播！🙏🙏一日幕僚片尾：Game Of Taking Chances 主持人：邰智源     來賓：柯文哲"
        //Append it into the videos array
        videos.append(video1)
        
        //Return the array to the caller
        return videos
    }
    
    
}
