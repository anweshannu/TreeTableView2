//
//  TreeTableView.swift
//  TreeTableView
//
//  Created by Anwesh M on 01/12/21.
//

import UIKit

protocol TreeTableViewCellDelegate: NSObjectProtocol {
    func cellClick(name: String)
}


class TreeTableView: UITableView, UITableViewDataSource, UITableViewDelegate{
    
    var mAllNodes: [TreeNode]? //all nodes
    var mNodes: [TreeNode]? //visible nodes
    
    var treeTableViewCellDelegate: TreeTableViewCellDelegate?
    
    let NODE_CELL_ID: String = "nodecell"
    
    init(frame: CGRect, withData data: [TreeNode]) {
        super.init(frame: frame, style: UITableView.Style.plain)
        self.delegate = self
        self.dataSource = self
        mAllNodes = data
        mNodes = TreeNodeHelper.sharedInstance.filterVisibleNode(mAllNodes!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Register the tableviewcell
        let nib = UINib(nibName: "TreeNodeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NODE_CELL_ID)
        let cell = tableView.dequeueReusableCell(withIdentifier: NODE_CELL_ID) as! TreeNodeTableViewCell
        let node: TreeNode = mNodes![indexPath.row]
        cell.nodeIMG.image = node.type != TreeNode.NOT_LEAF_NODE ? nil : UIImage(named: node.icon!)
        cell.view.layer.shadowOpacity = node.pId != "0" ? 0 : 0.3
        cell.nameButton.setTitleColor(node.pId != "0" ? .black : .red, for: .normal)
        cell.nameButton.setTitle(node.name, for: .normal)
        cell.nameButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return cell
    }
    
    @objc func buttonAction(sender: UIButton!){
        if let buttonTitle = sender.title(for: .normal) {
            treeTableViewCellDelegate?.cellClick(name: buttonTitle)
         }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mNodes?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let nib = UINib(nibName: "TreeNodeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NODE_CELL_ID)
        let cell = tableView.dequeueReusableCell(withIdentifier: NODE_CELL_ID) as! TreeNodeTableViewCell
        return cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parentNode = mNodes![indexPath.row]
        
        let startPosition = indexPath.row+1
        var endPosition = startPosition
        
        if parentNode.isLastNode() {
            // do something
            treeTableViewCellDelegate?.cellClick(name: parentNode.name!.description)
            print("Clicked \(parentNode.name!.description)")
        
        } else {
            expandOrCollapse(&endPosition, node: parentNode)
            mNodes = TreeNodeHelper.sharedInstance.filterVisibleNode(mAllNodes!)
            
            //indexpath
            var indexPathArray :[IndexPath] = []
            var tempIndexPath: IndexPath?
            for i in startPosition ..< endPosition {
                tempIndexPath = IndexPath(row: i, section: 0)
                indexPathArray.append(tempIndexPath!)
            }
            
            if parentNode.isExpand {
                self.insertRows(at: indexPathArray, with: .none)
            } else {
                self.deleteRows(at: indexPathArray, with: .none)
            }
            
            self.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        }
    }
    
    //Expand or close a node
    func expandOrCollapse(_ count: inout Int, node: TreeNode) {
        if node.isExpand {
            closedChildNode(&count,node: node)
        } else {
            count += node.children.count
            node.setExpand(true)
        }
    }
    
    //Close a node and all child nodes of the node
    func closedChildNode(_ count:inout Int, node: TreeNode) {
        guard !node.isLastNode() else{
            return
        }
        if node.isExpand {
            node.isExpand = false
            for item in node.children { //Close child node
                count += 1 // Calculate the number of child nodes plus one
                closedChildNode(&count, node: item)
            }
        }
    }
}
