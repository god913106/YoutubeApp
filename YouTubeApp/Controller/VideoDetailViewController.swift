//
//  ViewController.swift
//  YouTubeApp
//
//  Created by 洋蔥胖 on 2018/7/13.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

class VideoDetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
//    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    
//    @IBOutlet weak var descLabelHeight: NSLayoutConstraint!
    var selectedVideo: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if #available(iOS 11.0, *) {
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: descLabel.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        if let vid = self.selectedVideo{
            self.titleLabel.text = vid.videoTitle
            self.descLabel.text = vid.videoDescription
            
            //寬高要重設成手機的寬高
            let webViewWidth = self.view.frame.size.width
            let webViewHeight = (webViewWidth / 320) * 180
            
            
            let videoUrlString = "<html><head><style type=\"text/css\"> body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameborder=\"0\" height=\"\(webViewHeight)\" width=\"\(webViewWidth)\" src=\"http://www.youtube.com/embed/\(vid.videoId)?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
            self.webView.loadHTMLString(videoUrlString, baseURL: nil)
            
           
        }
    }

}

