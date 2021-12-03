//
//  SelectedViewController.swift
//  TreeTableView
//
//  Created by Anwesh M on 03/12/21.
//

import UIKit

class SelectedViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
