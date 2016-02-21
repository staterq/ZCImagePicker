//
//  ZCImageTableView.swift
//  ZCImagePicker
//
//  Created by chuanshuangzhang chuan shuang on 16/2/18.
//  Copyright © 2016年 chuanshuangzhang. All rights reserved.
//

import UIKit
import AssetsLibrary

class ZCImageTableViewController : UITableViewController {
    
    let assetsLibrary = ALAssetsLibrary()
    let groupArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        //1. Get photo asset from library
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            self.assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupAll, usingBlock: { (group:ALAssetsGroup!, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
                if group != nil  {
                    self.groupArray.addObject(group)
                }else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if(self.groupArray.count > 0)
                        {
                            self.tableView.reloadData()
                        }
                    })
                }
                }, failureBlock: { (error:NSError!) -> Void in
            })
        }
    }
}

extension ZCImageTableViewController
{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupArray.count
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(cell.respondsToSelector("setSeparatorInset"))
        {
          cell.separatorInset = UIEdgeInsetsZero
        }
        if(cell.respondsToSelector("setLayoutMargins"))
        {
           cell.layoutMargins = UIEdgeInsetsZero
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : ZCImageTableViewCell = tableView.dequeueReusableCellWithIdentifier("ZCImageTableViewCell") as! ZCImageTableViewCell
        let group = self.groupArray[indexPath.row]
        cell.imageView?.image = UIImage(CGImage: group.posterImage().takeUnretainedValue())
        cell.titleLabel.text = "\(group.valueForProperty(ALAssetsGroupPropertyName))"
        cell.numLabel.text = "(\(group.numberOfAssets()))"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc : ZCImageCollectionViewController = UIStoryboard(name: "ZCImage", bundle: nil).instantiateViewControllerWithIdentifier("ZCImageCollectionViewController") as! ZCImageCollectionViewController
        vc.group = self.groupArray[indexPath.row] as! ALAssetsGroup
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}