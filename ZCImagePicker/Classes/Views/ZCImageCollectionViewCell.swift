//
//  ZCImageCollectionViewCell.swift
//  ZCImagePicker
//
//  Created by chuanshuangzhang chuan shuang on 16/2/18.
//  Copyright © 2016年 chuanshuangzhang. All rights reserved.
//

import UIKit

protocol ZCImageCollectionViewCellDelegate
{
    func didSelectImageCollectionViewCell(collectionViewCell:UICollectionViewCell,status:Bool)->Void
}

class ZCImageCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!
    var delegate : ZCImageCollectionViewCellDelegate! = nil
    
    @IBAction func onTouchSelectBtn(sender: AnyObject) {
        let btn : UIButton = sender as! UIButton
        if (btn.selected)
        {
            btn.selected = false
        }else
        {
            btn.selected = true
        }
        delegate?.didSelectImageCollectionViewCell(self, status: btn.selected)
    }
}
