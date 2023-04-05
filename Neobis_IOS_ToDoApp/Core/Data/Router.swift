//
//  Router.swift
//  Neobis_IOS_ToDoApp
//
//  Created by G G on 04.04.2023.
//

import Foundation
import UIKit

protocol RouterProtocol: AnyObject {
    func mainScreenRoute()
    func detailScreenRoute(item: ToDoModel?, index: Int?)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    let transition = CATransition()
    
    func mainScreenRoute() {
        let view = assemblyBuilder?.buildMainScreen(router: self)
        navigationController?.viewControllers = [view!]
    }
    
    func detailScreenRoute(item: ToDoModel?, index: Int?) {
        
        transition.duration = 0.4
        transition.type = .moveIn
        transition.subtype = .fromTop
        
        let view = assemblyBuilder?.buildDetailScreen(router: self,
                                                      item: item,
                                                      index: index)
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(view!, animated: false)
    }
    
    func mainScreenPop() {
        
        transition.duration = 0.3
        transition.type = .moveIn
        transition.subtype = .fromBottom
        
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.popViewController(animated: true)
    }
}
