//
//  DetailViewController.swift
//  LOL Video
//
//  Created by Anuraag Jain on 10/07/15.
//  Copyright (c) 2015 Anuraag Jain. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var hud = MBProgressHUD()
    @IBOutlet weak var Des: UILabel!
    @IBOutlet weak var player: YouTubePlayerView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
        
        
    }
    
    var descItem: AnyObject? {
       
        didSet{
            self.DescView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
                let url = NSURL(string: label.text!)
                player.loadVideoURL(url!)
                print(url!)
            }
            
        }
        
        self.hud.hide(true, afterDelay: 1.5)
    }
    func DescView(){
        if let detail: AnyObject = self.descItem {
            if let label = self.Des {
               label.text = detail.description
                
                print(label.text)
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hud.labelText = "Loading"
        self.hud.dimBackground = true
        self.view.addSubview(hud)
        self.hud.show(true)
        // Do any additional setup after loading the view, typically from a nib.
        self.DescView()
        self.configureView()
        
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

