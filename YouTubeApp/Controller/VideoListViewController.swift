//
//  VideoListViewController.swift
//  YouTubeApp
//
//  Created by 洋蔥胖 on 2018/7/13.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class VideoListViewController: UITableViewController, VideoModelDelegate {
    
   
    
    
    var videos:[Video] = [Video]()
    var selectedVideo: Video?
    let model: VideoModel = VideoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.videos = model.getVideos()
        self.model.delegate = self
        model.getFeedVideos()
    }
    
    //MARK: - VideoModel Delegate Methods
    func dataReady() {
        
        //Access the video objects that have been downloaded
        self.videos = self.model.videoArray
        //Tell the tablview to reload
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let label = cell.viewWithTag(2) as! UILabel
        label.text = videos[indexPath.row].videoTitle
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        //maxresdefault.jpg(1280*720) 和 mqdefault.jpg(320*180) 差在解析度
        //let videoThumbnailUrlString = "https://i1.ytimg.com/vi/\(videos[indexPath.row].videoId)/maxresdefault.jpg"
        let videoThumbnailUrlString = videos[indexPath.row].videoThumbnailUrl
        let videoThombnailUrl = URL(string: videoThumbnailUrlString)
        
        //
        if videoThombnailUrl != nil {    
            imageView.af_setImage(withURL: videoThombnailUrl!)
        }
        
        
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.size.width / 320) * 180
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //take note of which video the user selected
        self.selectedVideo = self.videos[indexPath.row]
        //Call the segue
        performSegue(withIdentifier: "showDetail", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? VideoDetailViewController

        destinationVC?.selectedVideo = self.selectedVideo
    }
}
