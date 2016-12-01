//
//  TableViewController.swift
//  TableViewApp
//
//  Created by Simon Chen on 11/28/16.
//  Copyright © 2016 Workhorse Bytes. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var dataObjects: [DataObject] = []
    let cellSpacing: CGFloat = 5.0
    let bgColor: UIColor = UIColor(colorLiteralRed: 1.0, green: 0.4, blue: 0.2, alpha: 1.0)
    let CELL_IDENTIFIER = "CommentCell"
    
    let VERTICAL_OFFSET: CGFloat = 30.0
    
    let SHADOW_OFFSET_X = -1
    let SHADOW_OFFSET_Y = 1
    let SHADOW_OPACITY: Float = 0.5
    let SHADOW_RADIUS: CGFloat = 1.5
    
    var didLayoutSubviewOnce = false

    override func viewDidLoad() {
        super.viewDidLoad()

        createDataObjects(number: 3)
        self.tableView.backgroundColor = self.bgColor
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func addChildCells() {
        // Add a cell inside the cell
        for section in 0...(self.tableView.numberOfSections-1) {
            if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: section)) as! CommentCell? {
                self.addChildCell(toCell: cell)
            }
        }
    }
    
    func addChildCell(toCell cell: CommentCell) {
        // Do not add child if minimized
        if cell.isMinimized == false {
            if let childCell = self.tableView.dequeueReusableCell(withIdentifier: self.CELL_IDENTIFIER) {
                (childCell as! CommentCell).delegate = self
                
                // Set Background Color
                childCell.backgroundColor = UIColor.brown
                
                // Resize and position
                childCell.frame = CGRect(origin: childCell.frame.origin, size: CGSize(width: cell.frame.size.width, height: cell.frame.size.height - self.VERTICAL_OFFSET * 1.10))
                childCell.center = CGPoint(x: childCell.center.x + 10, y: childCell.center.y + self.VERTICAL_OFFSET )
                
                // Apply Shadow
                self.applyShadow(view: childCell)
                
                
                cell.addSubview(childCell)
            }
        }
    }
    
    func applyShadow(view: UIView) {
        // Drop shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: self.SHADOW_OFFSET_X, height: self.SHADOW_OFFSET_Y)
        view.layer.shadowOpacity = self.SHADOW_OPACITY
        view.layer.shadowRadius = self.SHADOW_RADIUS
        
        view.clipsToBounds = false
        
        let shadowFrame: CGRect = view.layer.bounds
        let shadowPath: CGPath = UIBezierPath(rect: shadowFrame).cgPath
        view.layer.shadowPath = shadowPath
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func createDataObjects(number: Int) {
        for _ in 1...number {
            // The minimized height is equal to how much a child's vertical offset placement is
            let dataObject = DataObject(height:100.0, minimizedHeight: self.VERTICAL_OFFSET)
            self.dataObjects.append(dataObject)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.dataObjects.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    
    // Return a cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELL_IDENTIFIER, for: indexPath) as! CommentCell
        cell.delegate = self
        
        let dataObject = self.dataObjects[indexPath.section]
        cell.isMinimized = dataObject.isMinimized
        
        // If cell is not minimized, add child
        if cell.isMinimized == false {
            self.addChildCell(toCell: cell)
        }
        
        self.applyShadow(view: cell)

        return cell
    }
    
    // Resize a cell's height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataObject = self.dataObjects[indexPath.section]
        let cellHeight = dataObject.height
        
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.cellSpacing
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension TableViewController: CommentCellDelegate {
    func cellDidHide(cell: UITableViewCell) {
        //self.tableView.reloadData()
    }
    
    func cellDidChange(cell: UITableViewCell, isMinimized: Bool) {
        // Check if indexPath corresponds to a dataObject
        if let indexPath = self.tableView.indexPath(for: cell) {
            
            let dataObject: DataObject = self.dataObjects[indexPath.section]
            dataObject.isMinimized = isMinimized
            
            if isMinimized == true {
                dataObject.height = dataObject.MINIMIZED_HEIGHT
                
                // Remove child cells
                for subview in cell.subviews {
                    if subview.isKind(of: CommentCell.self) {
                        
                        // Remove all children
                        subview.removeFromSuperview()
                    }
                }
            }
            else { // Maximized
                dataObject.height = dataObject.originalHeight
            }
            
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}










