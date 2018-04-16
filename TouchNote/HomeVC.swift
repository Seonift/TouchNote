//
//  HomeVC.swift
//  TouchNote
//
//  Created by SeonIl Kim on 2017. 12. 30..
//  Copyright © 2017년 SeonIl Kim. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    var panGesture = UIPanGestureRecognizer()
    var swipeGesture = UISwipeGestureRecognizer()
    var writeAlert = WriteAlert()
    
    var isFirst:Bool = false
    var y_origin:CGFloat = 0.0 // 다이얼로그 기본 위치
    var dragValue:CGFloat = 38.0 // 드래그 감도
    
    var items:[MemoObj] = [] {
        didSet {
//            DispatchQueue.main.async {
//
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragging(_:)))
        writeAlert.dialogView.addGestureRecognizer(panGesture)
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swiping(_:)))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isFirst == false {
            isFirst = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.writeAlert.show(type: .new)
                self.y_origin = self.writeAlert.dialogView.frame.origin.y
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    @objc func swiping(_ sender: UISwipeGestureRecognizer){
        if self.writeAlert.isShown {
            if sender.direction == .up {
                writeAlert.dismiss(type: .up)
            }
            
            if sender.direction == .down {
                writeAlert.dismiss(type: .down)
            }
        } else {
            if sender.direction == .right {
                self.writeAlert.show(type: .left)
                self.y_origin = self.writeAlert.dialogView.frame.origin.y
            }
        }
        
    }
    
    @objc func dragging(_ sender: UIPanGestureRecognizer) {
        self.view.bringSubview(toFront: writeAlert.dialogView)
        let transition = sender.translation(in: self.view)
        
        // 모든 방향 드래그
//        writeDialog.dialogView.center = CGPoint(x: writeDialog.dialogView.center.x + transition.x, y: writeDialog.dialogView.center.y + transition.y)
        
        // 세로 드래그
        writeAlert.dialogView.center = CGPoint(x: writeAlert.dialogView.center.x, y: writeAlert.dialogView.center.y + transition.y)
        
        // 가로 드래그
//        writeDialog.dialogView.center = CGPoint(x: writeDialog.dialogView.center.x + transition.x, y: writeDialog.dialogView.center.y)
        
        sender.setTranslation(.zero, in: self.view)
        
        if sender.state == UIGestureRecognizerState.ended {
            if sender.state == UIGestureRecognizerState.ended {
                let current_y = writeAlert.dialogView.frame.origin.y
                print("up:\(y_origin - current_y)")
                print("down:\(current_y - y_origin)")
                if y_origin - current_y >= dragValue {
                    // 위로 드래그
//                    let text = writeAlert.dialogView.textField.text
                    writeAlert.dismiss(type: .up)
                } else if current_y - y_origin >= dragValue {
                    // 아래로 드래그
                    writeAlert.dismiss(type: .down)
                } else {
                    // 일정 드래그 범위 이하면 다시 원상복구
                    UIView.animate(withDuration: 0.1, animations: {
//                        self.writeAlert.dialogView.center = self.writeAlert.center
                        self.writeAlert.dialogView.frame.origin.y = self.y_origin
                    })
                }
            }
        }
    }
}

extension HomeVC {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardSize.height == 0.0 {
                return
            }
            print("Show with height: \(keyboardSize.height)")
            
            UIView.animate(withDuration: 0.33, animations: { () -> Void in
                if self.writeAlert.isShown {
                    self.writeAlert.dialogView.frame.origin.y = 20.0
                    self.y_origin = self.writeAlert.dialogView.frame.origin.y
                }
            })
        }
    }
    
    @objc func keyboardWillHide(note: NSNotification) {
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize)
            
            UIView.animate(withDuration: 0.33, animations: { () -> Void in
                if self.writeAlert.isShown {
                    self.writeAlert.dialogView.center.y = self.writeAlert.center.y
                    self.y_origin = self.writeAlert.dialogView.center.y
                }
            })
        }
    }
}
