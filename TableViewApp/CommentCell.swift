//
//  CommentCell.swift
//  TableViewApp
//
//  Created by Simon Chen on 11/28/16.
//  Copyright © 2016 Workhorse Bytes. All rights reserved.
//

import UIKit


protocol CommentCellDelegate {
    func cellDidHide(cell: UITableViewCell)
    func cellDidChange(cell: UITableViewCell, isMinimized: Bool)
}


class CommentCell: UITableViewCell {
    
    
    var delegate: CommentCellDelegate?
    
    var originalHeight: CGFloat = 0
    
    let MINIMIZED_HEIGHT: CGFloat = 20.0
    
    var isMinimized: Bool = false {
        didSet {
            if isMinimized == true {
                // Minimize
                //self.frame.size = CGSize(width: self.frame.size.width, height: MINIMIZED_HEIGHT)
            }
            else {
                // Maximize
                //self.frame.size = CGSize(width: self.frame.size.width, height: originalHeight)
            }
        }
    }

    @IBAction func pressedButton(_ sender: UIButton) {
        
        if self.isMinimized == false {
            // Minimize
            self.isMinimized = true
        }
        else {
            // Maximize
            self.isMinimized = false
        }
        
        self.delegate?.cellDidChange(cell: self, isMinimized: self.isMinimized)
        
        //self.isHidden = true
        //delegate?.cellDelegateDidHide(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Finished loading
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.originalHeight = self.frame.size.height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
