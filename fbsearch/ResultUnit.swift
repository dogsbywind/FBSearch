//
//  ResultUnit.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/19/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit

class ResultUnit{
    //properties
    var name:String
    var photo:UIImage
    var favo:Bool
    var id:String
    var url:String
    
    init(){
        self.name = String()
        self.photo = UIImage()
        self.favo = true
        self.id = String()
        self.url = String()
    }
    
    init?(name:String,url:String,favo:Bool,id:String) {
        if name.isEmpty{
            return nil
        }
        self.name=name
        self.photo=UIImage()
        self.favo=favo
        self.id=id
        self.url = url
        if let photoUrl = URL(string:url){
            if let data = NSData(contentsOf: photoUrl){
                self.photo = UIImage(data: data as Data)!
            }
        }
        
    }
}
