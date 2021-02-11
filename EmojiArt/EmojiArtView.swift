//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by Игорь on 10.02.2021.
//

import UIKit

@IBDesignable class EmojiArtView: UIView {
    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
}
