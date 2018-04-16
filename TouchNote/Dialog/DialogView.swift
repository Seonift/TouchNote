//
//  DialogView.swift
//  TouchNote
//
//  Created by SeonIl Kim on 2017. 12. 30..
//  Copyright © 2017년 SeonIl Kim. All rights reserved.
//

import UIKit

class DialogView: UIView, UITextViewDelegate {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textView: UITextView!
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("DialogView", owner: self, options: nil)
        addSubview(contentView)
        textView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
