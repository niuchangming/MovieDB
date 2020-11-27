//
//  UIResponder+Utils.swift
//  MovieDB
//
//  Created by Niu Changming on 26/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit

extension UIResponder {

    func viewController(responder: UIResponder) -> UIViewController? {
        if let vc = responder as? UIViewController {
            return vc
        }

        if let next = responder.next {
            return viewController(responder: next)
        }

        return nil
    }
}
