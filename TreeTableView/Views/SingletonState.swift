//
//  Singleton.swift
//  TreeTableView
//
//  Created by Anwesh M on 01/12/21.
//

import Foundation

class SingletonState{
    static let shared = SingletonState()
    private init(){}
    var mainViewContoller: ViewController?
}
