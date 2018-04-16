//
//  WriteAlert.swift
//  TouchNote
//
//  Created by SeonIl Kim on 2017. 12. 30..
//  Copyright © 2017년 SeonIl Kim. All rights reserved.
//

import UIKit

class WriteAlert:UIView, Modal {
    var isShown: Bool = false
    
    enum ActionType {
        case up
        case down
        case left
        case right
        case modify
        case new
    }
    
    var backgroundView = UIView()
    var dialogView = DialogView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        dialogView.clipsToBounds = true
        dialogView.center = self.center
//        dialogView.frame.size = CGSize(width: 300, height: 300)
        dialogView.backgroundColor = .white
        dialogView.layer.cornerRadius = 6
        addSubview(dialogView)
    }
    
    @objc func didTappedOnBackgroundView(){
        //        dismiss(animated: true)
        if dialogView.textView.isFirstResponder {
            dialogView.textView.resignFirstResponder()
        } else {
            dismiss(type: .up)
        }
    }
}
