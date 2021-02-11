//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Игорь on 10.02.2021.
//

import UIKit

class EmojiArtViewController: UIViewController {
    var imageFetcher: ImageFetcher!

    // MARK: - Outlets
    @IBOutlet weak var dropZoneView: UIView! {
        didSet {
            dropZoneView.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    @IBOutlet weak var emojiArtView: EmojiArtView!
}

// MARK: - EmojiArtViewController + UIDropInteractionDelegate
extension EmojiArtViewController: UIDropInteractionDelegate {
    func dropInteraction(
        _ interaction: UIDropInteraction, canHandle session: UIDropSession
    ) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) &&
            session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(
        _ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession
    ) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        imageFetcher = ImageFetcher() { (url, image) in
            DispatchQueue.main.async {
                self.emojiArtView.backgroundImage = image
            }
        }
        session.loadObjects(ofClass: NSURL.self) { (nsURLs) in
            guard let url = nsURLs.first as? URL else { return }
            self.imageFetcher.fetch(url)
        }
        session.loadObjects(ofClass: UIImage.self) { (images) in
            guard let image = images.first as? UIImage else { return }
            self.imageFetcher.backup = image
        }
    }
}
