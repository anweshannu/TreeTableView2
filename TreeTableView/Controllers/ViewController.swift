//
//  ViewController.swift
//  TreeTableView
//
//  Created by Anwesh M on 01/12/21.
//

import UIKit

class ViewController: UIViewController, TreeTableViewCellDelegate  {
 
    var tableView: TreeTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        SingletonState.shared.mainViewContoller = self
        loadTableview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func loadTableview(){
        
        let data: NSMutableArray = [
            [
                "id" :  1,
                "name" :  "Instant Food, Sauces & Noodles",
                "pid" :  0,
            ],
            [
                "id" :  29,
                "name" :  "Stationary",
                "pid" :  0,
            ],
            [
                "id" :  30,
                "name" :  "Home care",
                "pid" :  0,
            ],
            [
                "id" :  31,
                "name" :  "Grocery & Staples",
                "pid" :  0,
            ],
            
            [
                "id" :  31,
                "name" :  "Grocery & Staples",
                "pid" :  31,
            ],
            
            [
                "id" :  32,
                "name" :  "Pet care",
                "pid" :  0,
            ],
            
            [
                "id" :  32,
                "name" :  "Pet care",
                "pid" :  32,
            ],
            
            [
                "id" :  33,
                "name" :  "Baby care",
                "pid" :  0,
            ],
            [
                "id" :  33,
                "name" :  "Baby care",
                "pid" :  33,
            ],
            [
                "id" :  34,
                "name" :  "Personal care",
                "pid" :  0,
            ],
            [
                "id" :  35,
                "name" :  "Personal care",
                "pid" :  34,
            ],
            [
                "id" :  2,
                "name" :  "Biryanies",
                "pid" :  1,
            ],
            [
                "id" :  3,
                "name" :  "Fries",
                "pid" :  1,
            ],
            [
                "id" :  4,
                "name" :  "Veg biryani",
                "pid" :  1,
            ],
            [
                "id" :  5,
                "name" :  "Chicken fry",
                "pid" :  3,
            ],
            [
                "id" :  6,
                "name" :  "Mutton fry",
                "pid" :  3,
            ],
            [
                "id" :  7,
                "name" :  "Veg Biryani",
                "pid" :  2,
            ],
            [
                "id" :  8,
                "name" :  "Chicken hundi Biryani",
                "pid" :  2,
            ],
            [
                "id" :  11,
                "name" :  "Mutton Biryani",
                "pid" :  2,
            ],
            [
                "id" :  9,
                "name" :  "Food",
                "pid" :  5,
            ],
            [
                "id" :  10,
                "name" :  "Food",
                "pid" :  5,
            ],
            [
                "id" :  11,
                "name" :  "Food",
                "pid" :  6,
            ],
            [
                "id" :  12,
                "name" :  "food",
                "pid" :  8,
            ],
            [
                "id" :  13,
                "name" :  "food",
                "pid" :  8,
            ],
            [
                "id" :  14,
                "name" :  "Food",
                "pid" :  4,
            ],
            [
                "id" :  15,
                "name" :  "Food",
                "pid" :  4,
            ],
            [
                "id" :  17,
                "name" :  "Food",
                "pid" :  30,
            ],
            [
                "id" :  19,
                "name" :  "Food",
                "pid" :  30,
            ],
            [
                "id" :  19,
                "name" :  "Pens",
                "pid" :  29,
            ]
        ]
        
        let nodes = TreeNodeHelper.sharedInstance.getSortedNodes(data, defaultExpandLevel: 0)
        tableView = TreeTableView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height), withData: nodes)
        self.view.addSubview(tableView)
        tableView.treeTableViewCellDelegate = self
        tableView.separatorStyle = .none
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setTableViewConstraints()
    }
    
    private func setTableViewConstraints(){
        NSLayoutConstraint(item: tableView!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0).isActive = true
    }
    

    func cellClick(name: String) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "svc") as! SelectedViewController
        self.present(controller, animated: true, completion: nil)
        controller.textLabel.text = "Selected \(name)"
    }
    
}
