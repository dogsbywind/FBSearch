//
//  Passengers.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/19/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//
import UIKit
class Passengers{
    
static let union = Parameters()

class Parameters{
    
    var keyword:String
    
    var next:UIButton
    
    var prev:UIButton
    
    var searchid:String
    
    var tempResult:ResultUnit
    
    init(){
        self.keyword = String()
        self.next = UIButton()
        self.prev = UIButton()
        self.searchid = String()
        self.tempResult = ResultUnit()
    }
}
}
