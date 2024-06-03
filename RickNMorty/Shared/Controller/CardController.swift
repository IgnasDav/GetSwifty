//
//  CardController.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 29/04/2024.
//
import UIKit

class CardController: UIViewController {
    private lazy var cardView = CardView()
    var delegate: CardNavigationDelegate?
    
    override func loadView() {
        view = cardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
    @objc func imageTapped(sender: AnyObject?) {
        delegate?.didNavigateToCard(name: cardView.label.text ?? "")
    }
    
    func configure(with image: UIImage?, label content: String) {
        guard let image = image else {
            fatalError("The image was not found in the Card configuration")
        }
        cardView.imageView.image = image
        cardView.label.text = content
    }
}
