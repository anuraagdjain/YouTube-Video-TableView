//
//  MasterViewController.swift
//  LOL Video
//
//  Created by Anuraag Jain on 10/07/15.
//  Copyright (c) 2015 Anuraag Jain. All rights reserved.
//

import UIKit
import Alamofire

class MasterViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var search: UISearchBar!
    var objects = [AnyObject]()
    var links:[String] = []
    var img:[String] = []
    var name:[String] = []
    var descp:[String] = []
   
    var searchActive : Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
       
        super.viewDidLoad()
        search.delegate = self
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.get_video()
        // Do any additional setup after loading the view, typically from a nib.
    
       
    }
    func get_video(){
    Alamofire.request(.GET, URLString: "http://your-file-php").responseJSON { (request, response, json, error) in
            self.remove_data()
            let jsonObj = JSON(json!)
            for (_,subJson):(String, JSON) in jsonObj["data"] {
                //Do something you want
                self.links.append(subJson["link"].stringValue)
                self.img.append(subJson["image"].stringValue)
                self.name.append(subJson["name"].stringValue)
                self.descp.append(subJson["descp"].stringValue)
                self.tableView.reloadData()
            }
            
            
        }
    }
    func remove_data(){
        self.name.removeAll()
        self.links.removeAll()
        self.img.removeAll()
        self.descp.removeAll()

    }
    func refresh(sender:AnyObject)
    {
       
        self.get_video()
       
        self.refreshControl?.endRefreshing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = links[indexPath.row]
                let desc =  descp[indexPath.row]
            (segue.destinationViewController as! DetailViewController).detailItem = object
                (segue.destinationViewController as! DetailViewController).descItem = desc
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return img.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
       
        let image = img[indexPath.row]
        let names = name[indexPath.row]
        
        //For Basic Cell.
//        cell.textLabel?.text = names
//        let url = NSURL(string: image)
//        let urlData = NSData(contentsOfURL: url!)
//        cell.imageView?.image = UIImage(data: urlData!)
//       cell.imageView?.frame = CGRectMake(0,0, self.view.bounds.width / 2, 120)
//        cell.imageView?.clipsToBounds = true
        
        //For Custom Cell.
        if let captionLabel = cell.viewWithTag(100) as? UIImageView {
            
            let url = NSURL(string: image)
            
                captionLabel.sd_setImageWithURL(url)
            //print(captionLabel)
            
        }
       
        if let captionLabel = cell.viewWithTag(101) as? UILabel {
            
            captionLabel.text = names
        }

        return cell
    }

 

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

   


}

