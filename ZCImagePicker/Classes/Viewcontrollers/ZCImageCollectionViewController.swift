//
//  ZCImageCollectionView.swift
//  ZCImagePicker
//
//  Created by chuanshuangzhang chuan shuang on 16/2/18.
//  Copyright © 2016年 chuanshuangzhang. All rights reserved.
//

import UIKit
import AssetsLibrary

class ZCImageCollectionViewController : UIViewController , UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ZCImageCollectionViewCellDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource : NSMutableArray! = nil
    var group : ALAssetsGroup! = nil
    var selectedArray : NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = getAllAssetsWithGroup(group)
    }
    func getAllAssetsWithGroup(group:ALAssetsGroup)->NSMutableArray
    {
        let array = NSMutableArray()
        let t = NSEnumerationOptions()
        group.enumerateAssetsWithOptions(t) { (result:ALAsset!, index:Int, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            if(result != nil)
            {
                array.addObject(result)
            }
        }
        return array
    }
    
    func  checkMarkSameAsset(arraySelect:NSArray,set:ALAsset)->NSArray
    {
       let pre = NSPredicate(format:"self.defaultRepresentation.url.absoluteString == \(set.defaultRepresentation().url().absoluteString)")
        return arraySelect.filteredArrayUsingPredicate(pre)
    }

}


extension ZCImageCollectionViewController
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 3.5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (collectionView.frame.size.width-4*3.5)/4.0
        return CGSizeMake(width, width)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 3.5
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : ZCImageCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ZCImageCollectionViewCell", forIndexPath: indexPath) as! ZCImageCollectionViewCell
        let set : ALAsset! = self.dataSource[indexPath.row] as! ALAsset
//        cell.selectBtn.selected = (self.checkMarkSameAsset(self.selectedArray, set: set).count > 0)
        cell.imageView.image = UIImage(CGImage: set.thumbnail().takeUnretainedValue())
        return cell
    }
    
    func didSelectImageCollectionViewCell(collectionViewCell: UICollectionViewCell,status:Bool) {
        let set : ALAsset = self.dataSource[(self.collectionView.indexPathForCell(collectionViewCell)?.row)!] as! ALAsset
        if(status)
        {
            self.selectedArray.addObject(set)
        }
        else
        {
//            let  arr = self.checkMarkSameAsset(self.selectedArray, set: set)
//            if(arr.count > 0)
//            {
//                self.selectedArray.removeObject(arr.firstObject!)
//            }
        }
    }
}