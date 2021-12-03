//
//  TreeNode.swift
//  TreeTableView
//
//  Created by Anwesh M on 01/12/21.
//

import Foundation

open class TreeNode {
    
    static let NOT_LEAF_NODE: Int = 0 //Indicates that the node is not a leaf node
    static let LEAF_NODE: Int = 1 //Indicates that the node is a leaf node
    var type: Int?
    var description: String? // For multiple types of content, the content needs to be determined
    var id: String?
    var pId: String?
    var name: String?
    var level: Int?
    var isExpand: Bool = false
    var icon: String?
    var children: [TreeNode] = []
    var parent: TreeNode?
    
    init (desc: String?, id:String? , pId: String? , name: String?) {
        self.description = desc
        self.id = id
        self.pId = pId
        self.name = name
    }
    
    //Checking whether is it the root node
    func isRoot() -> Bool{
        return parent == nil
    }
    
    //Determine whether the parent node is open
    func isParentExpand() -> Bool {
        if parent == nil {
            return false
        }
        return parent!.isExpand
    }
    
    //Is it a leaf node
    func isLastNode() -> Bool {
        return children.count == 0
    }
    
    //Get level, used to set the left distance of node content
    func getLevel() -> Int {
        return parent == nil ? 0 : parent!.getLevel()+1
    }
    
    //Sets expand
    func setExpand(_ isExpand: Bool) {
        self.isExpand = isExpand
        if !isExpand {
            for i in 0 ..< children.count {
                children[i].setExpand(isExpand)
            }
        }
    }
}
