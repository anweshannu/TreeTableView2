//
//  TreeNodeHelper.swift
//  TreeTableView
//
//  Created by Anwesh M on 01/12/21.
//

import Foundation

class TreeNodeHelper {
    
    // Singleton mode
    class var sharedInstance: TreeNodeHelper {
        struct Static {
            static var instance: TreeNodeHelper? = TreeNodeHelper()
        }
        return Static.instance!
    }
    
    
    //Incoming ordinary nodes, converted into sorted
    func getSortedNodes(_ groups: NSMutableArray, defaultExpandLevel: Int) -> [TreeNode] {
        var result: [TreeNode] = []
        let nodes = convertData2Node(groups)
        let rootNodes = getRootNodes(nodes)
        for item in rootNodes{
            addNode(&result, node: item, defaultExpandLeval: defaultExpandLevel, currentLevel: 1)
        }
        
        return result
    }
    
    //Filter out all visible nodes
    func filterVisibleNode(_ nodes: [TreeNode]) -> [TreeNode] {
        var result: [TreeNode] = []
        for item in nodes {
            if item.isRoot() || item.isParentExpand() {
                setNodeIcon(item)
                result.append(item)
            }
        }
        return result
    }
    
    //Convert data into nodes
    func convertData2Node(_ groups: NSMutableArray) -> [TreeNode] {
        var nodes: [TreeNode] = []
        
        var node: TreeNode
        var desc: String?
        var id: Int?
        var pId: Int?
        var label: String?
        
        for element in groups {
            let item = element as? [String:Any]
            desc = item?["description"] as? String
            id = item?["id"] as? Int
            pId = item?["pid"] as? Int
            label = item?["name"] as? String
            
            node = TreeNode(desc: desc, id: id!.description, pId: pId!.description, name: label)
            nodes.append(node)
        }
        
        /**
        * Set up the parent-child relationship between Nodes; compare each two nodes to set the relationship
        */
        var n: TreeNode
        var m: TreeNode
        for i in 0 ..< nodes.count {
            n = nodes[i]
            
            for j in i+1 ..< nodes.count {
                m = nodes[j]
                if m.pId == n.id {
                    n.children.append(m)
                    m.parent = n
                } else if n.pId == m.id {
                    m.children.append(n)
                    n.parent = m
                }
            }
        }
        for item in nodes {
            setNodeIcon(item)
        }
        
        return nodes
    }
    
    // Get the root node set
    func getRootNodes(_ nodes: [TreeNode]) -> [TreeNode] {
        var root: [TreeNode] = []
        for item in nodes {
            if item.isRoot() {
                root.append(item)
            }
        }
        return root
    }
    
    //Hang up all the child nodes of a node
    func addNode(_ nodes: inout [TreeNode], node: TreeNode, defaultExpandLeval: Int, currentLevel: Int) {
        nodes.append(node)
        if defaultExpandLeval >= currentLevel {
            node.setExpand(true)
        }
        guard !node.isLastNode() else{
            return
        }
        for i in 0 ..< node.children.count {
            addNode(&nodes, node: node.children[i], defaultExpandLeval: defaultExpandLeval, currentLevel: currentLevel+1)
        }
    }
    
    //Set node icon
    func setNodeIcon(_ node: TreeNode) {
        if node.children.count > 0 {
            node.type = TreeNode.NOT_LEAF_NODE
            if node.isExpand {
                // Set the icon to the down arrow
                node.icon = "up-arrow.png"
            } else if !node.isExpand {
                // Set the icon to the right arrow
                node.icon = "down-arrow.png"
            }
        } else {
            node.type = TreeNode.LEAF_NODE
        }
    }
}
