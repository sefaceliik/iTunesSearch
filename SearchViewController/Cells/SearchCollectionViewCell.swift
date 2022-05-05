//
//  SearchCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Sefa Çelik on 5.05.2022.
//

import UIKit

protocol SearchCellConfigure: AnyObject {
    func configure(model: Items)
}

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var songTitleLabel: UILabel!
    @IBOutlet private weak var artistTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension SearchCollectionViewCell: SearchCellConfigure {

    func configure(model: Items) {
        
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        
        self.songTitleLabel.font = .systemFont(ofSize: 24)
        self.songTitleLabel.textColor = .black
        self.songTitleLabel.text = model.trackName
        
        self.artistTitleLabel.font = .systemFont(ofSize: 17)
        self.artistTitleLabel.textColor = .black
        self.artistTitleLabel.text = model.artistName
    }
}
