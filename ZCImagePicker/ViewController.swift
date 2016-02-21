//
//  ViewController.swift
//  ZCImagePicker
//
//  Created by chuanshuangzhang chuan shuang on 16/2/18.
//  Copyright © 2016年 chuanshuangzhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func open(sender: AnyObject) {
       let sb = UIStoryboard(name: "ZCImage", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("ZCImageTableViewController")
        let nav = UINavigationController(rootViewController: vc)
        self.presentViewController(nav, animated: true, completion: nil)
    }

}

