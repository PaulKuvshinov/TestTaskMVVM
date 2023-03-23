//
//  UILabelExtension.swift
//  TestTaskMVVM
//
//  Created by Paul on 23.03.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String = "",
                     font: UIFont?,
                     color: UIColor = .black,
                     lines: Int = 1,
                     alignment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = lines
        self.textAlignment = alignment
    }
}

class LabelWithLine: UILabel {
    
    convenience init(font: UIFont? = .helvetica17Bold()) {
        self.init()
        self.font = font
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var bottomView = UIView()
        bottomView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomView.backgroundColor = .black
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 40),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            bottomView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
