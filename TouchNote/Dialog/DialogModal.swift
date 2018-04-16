//
//  DialogModal.swift
//  class_p
//
//  Created by SeonIl Kim on 2017. 12. 2..
//  Copyright © 2017년 SeonIl Kim. All rights reserved.
//

import UIKit

protocol Modal {
    func show(type: WriteAlert.ActionType)
    func dismiss(type: WriteAlert.ActionType)
    var backgroundView:UIView {get}
    var dialogView:DialogView {get set}
    var isShown:Bool {get}
}

extension Modal where Self:WriteAlert{
    func show(type: ActionType){
        self.backgroundView.alpha = 0
        
        var x:CGFloat = 0.0, y:CGFloat = 0.0
        switch type {
        case .modify:
            fallthrough
        case .new:
            fallthrough
        case .up:
            x = self.center.x
            y = -(self.dialogView.frame.height/2)
        case .down:
            x = self.center.x
            y = self.frame.height + self.dialogView.frame.height/2
        case .left:
            x = -(self.dialogView.frame.width / 2)
            y = self.center.y
        case .right:
            x = self.frame.width + self.dialogView.frame.width/2
            y = self.center.y
        }
        
        self.dialogView.center = CGPoint(x: x, y: y)
        
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.view.addSubview(self)
        }
        
        UIView.animate(withDuration: 0.33, animations: {
            self.backgroundView.alpha = 0.66
        })
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.dialogView.center  = self.center
        }, completion: { (completed) in
            if type != .modify {
                self.dialogView.textView.becomeFirstResponder()
            }
        })
        
//        if animated {
//
//        }else{
//            self.backgroundView.alpha = 0.66
//            self.dialogView.center  = self.center
//            self.dialogView.textView.becomeFirstResponder()
//        }
        self.isShown = true
    }
    
    func dismiss(type: ActionType) {
        UIView.animate(withDuration: 0.33, animations: {
            self.backgroundView.alpha = 0
        })
        
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
            var x:CGFloat = 0.0
            var y:CGFloat = 0.0
            switch type {
            case .up:
                x = self.center.x
                y = -(self.dialogView.frame.height/2)
            case .down:
                x = self.center.x
                y = self.frame.height + self.dialogView.frame.height/2
            case .left:
                x = -(self.dialogView.frame.width / 2)
                y = self.center.y
            case .right:
                x = self.frame.width + self.dialogView.frame.width/2
                y = self.center.y
            default:
                print()
            }
            
            self.dialogView.center = CGPoint(x: x, y: y)
            
        }, completion: { _ in
            self.resignFirstResponder()
            self.dialogView.textView.text = ""
            self.removeFromSuperview()
            self.isShown = false
        })
    }
    
    func dismiss(){
        self.resignFirstResponder()
        self.dialogView.textView.text = ""
        self.removeFromSuperview()
        self.isShown = false
    }
}

