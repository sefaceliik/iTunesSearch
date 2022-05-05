//
//  DetailViewController.swift
//  iTunesSearch
//
//  Created by Sefa Çelik on 5.05.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var songTitleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    let viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel = DetailViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = DetailViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.artworkImageView.layer.cornerRadius = 8
        self.artworkImageView.backgroundColor = .clear

        self.songTitleLabel.font = .systemFont(ofSize: 24)
        self.songTitleLabel.textColor = .black
        self.songTitleLabel.text = self.viewModel.getSongName()
        
        self.artistLabel.font = .systemFont(ofSize: 17)
        self.artistLabel.textColor = .black
        self.artistLabel.text = self.viewModel.getArtistName()
        
        self.genreLabel.font = .systemFont(ofSize: 17)
        self.genreLabel.textColor = .black
        self.genreLabel.text = self.viewModel.getGenre()
        
        self.releaseDateLabel.font = .systemFont(ofSize: 17)
        self.releaseDateLabel.textColor = .black
        self.releaseDateLabel.text = self.viewModel.getReleaseDate()
        
        guard let url = URL(string: self.viewModel.getImageUrl() ?? "") else {
            self.artworkImageView.backgroundColor = .lightGray
            return
        }
        self.downloadImage(from: url)
    }
    
    func downloadImage(from url: URL) {
        self.viewModel.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.artworkImageView.image = UIImage(data: data)
            }
        }
    }
}
