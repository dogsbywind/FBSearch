//
//  AlbumUnit.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/20/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit

class AlbumUnit{
    var title:String
    var pic1: UIImage?
    var pic2: UIImage?
    
    init?(title: String, pic1:UIImage?,pic2:UIImage?){
        self.title = title
        self.pic1 = pic1
        self.pic2 = pic2
    }
}
