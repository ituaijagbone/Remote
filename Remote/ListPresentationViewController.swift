//
//  ViewController.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
// List all user Presentations. This is not slides. A presentation has one or more slides I suppose.

import UIKit

// url of Windows Azure Server
let pennappurl = "http://104.42.124.242:3000/"

class ListPresentationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let presentationManager = PresentationManager()
    var presentationList: [Presentation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 230
//        Testing presentation view        
//        presentationManager.getDummyPresentationList{
//            (results) -> Void in
//            dispatch_async(dispatch_get_main_queue()) {
//                self.presentationList = results
//                self.tableView.reloadData()
//            }
//        }

//      Get presentations from server. 
//      Rerefresh table view when complete
        presentationManager.getPresentationList{
            (results) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                println(results.count)
                self.presentationList = results
                self.tableView.reloadData()
            }
        }
    }
    
    /**
        Refresh Presentation List when user clicks button. 
    */
    @IBAction func refreshPresentations(sender: AnyObject) {
        self.presentationList = nil
        self.tableView.reloadData()
        presentationManager.getNewPresentationList{
            (results) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
//                self.presentationList = nil
//                self.tableView.reloadData()
                self.presentationList = results
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
        Number of sections in TableView
        - returns: number of sections
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /**
        Number of rows in each section of TableView
        - returns: number of rows
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presentationList != nil {
            return presentationList.count
        }
        
        return 0
    }
    
    /**
        Table View setup. Uses presentation data for setup
        - returns: presentation cell
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("presentationCell") as! PresentationCell

        // Cell model
        // Presentation for current row
        let mPresentation = self.presentationList[indexPath.row] 
        
//        cell.thumbnail.image = UIImage(named: mPresentation.thumbnail)
//        println(pennappurl + mPresentation.thumbnail)

        // Thumbnail
        let imageData = NSData(contentsOfURL: NSURL(string: pennappurl + mPresentation.thumbnail)!) 
        
        // if image does not exist skip.
        if let tmpData = imageData {
            cell.thumbnail.image = UIImage(data: tmpData)
        } else {
            println("not working")
        }

        // set presentation title
        cell.title.text = mPresentation.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("presentationPlayer", sender: self.tableView.cellForRowAtIndexPath(indexPath))
    }

    /**
        ViewController Transition
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentationPlayer" {
            // PresentationViewController destination setup
            let indexPath = self.tableView.indexPathForCell(sender as! PresentationCell)
            let presentation = self.presentationList[indexPath!.row]
            let presentationVC = segue.destinationViewController as! PresentationPlayerViewController
            presentationVC.slideId = presentation.slideId
            
            presentationVC.navTitle = presentation.title
            
        }
    }
}

