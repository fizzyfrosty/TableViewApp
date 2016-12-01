//
//  DataObject.swift
//  TableViewApp
//
//  Created by Simon Chen on 11/28/16.
//  Copyright © 2016 Workhorse Bytes. All rights reserved.
//

import UIKit

class DataObject: NSObject {

    var isMinimized = false
    var originalHeight: CGFloat = 0
    
    let MINIMIZED_HEIGHT: CGFloat
    var height: CGFloat
    
    
    
    init(height: CGFloat, minimizedHeight: CGFloat) {
        self.height = height
        self.originalHeight = height
        self.MINIMIZED_HEIGHT = minimizedHeight
        
        
        super.init()
    }
    
    
    
}
