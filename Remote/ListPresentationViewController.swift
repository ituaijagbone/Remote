//
//  ViewController.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
//

import UIKit

class ListPresentationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let presentationManager = PresentationManager()
    var presentationList: [Presentation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 230
//        self.tableView.estimatedRowHeight = 215
        
        presentationManager.getDummyPresentationList{
            (results) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.presentationList = results
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presentationList != nil {
            return presentationList.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("presentationCell") as! PresentationCell

        // TODO: Add cell model here
        let mPresentation = self.presentationList[indexPath.row]
        cell.thumbnail.image = UIImage(named: mPresentation.thumbnail)
//        let imageData = NSData(contentsOfURL: NSURL(fileURLWithPath: mPresentation.thumbnail)!)
//        if let tmpData = imageData {
//            cell.thumbnail.image = UIImage(data: tmpData)
//        }

        cell.title.text = mPresentation.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("presentationPlayer", sender: self.tableView.cellForRowAtIndexPath(indexPath))
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentationPlayer" {
            // TODO: Add the routine destintion controller here
            let indexPath = self.tableView.indexPathForCell(sender as! PresentationCell)
            let presentation = self.presentationList[indexPath!.row]
            let presentationVC = segue.destinationViewController as! PresentationPlayerViewController
            presentationVC.slideId = presentation.slideId
            
        }
    }
}

