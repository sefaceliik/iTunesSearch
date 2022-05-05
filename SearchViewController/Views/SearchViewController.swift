//
//  SearchViewController.swift
//  iTunesSearch
//
//  Created by Sefa Çelik on 4.05.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var timer: Timer?
    private var reuseIdentifier = "SearchCell"
    
    let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel = SearchViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = SearchViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.searchBar.searchBarStyle = .minimal
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: self.reuseIdentifier)
        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.collectionView.isHidden = true
        
        self.searchLabel.font = .systemFont(ofSize: 24)
        self.searchLabel.textColor = .black
        self.searchLabel.textAlignment = .center
        self.searchLabel.text = "Search Something.."
    }

    @objc private func makeSearch() {
        let text = searchBar.text ?? ""
        
        if text == text {
            self.viewModel.getSearchResults(searchText: text) {
                
                if self.viewModel.getResultItemsCount() > 0 {
                    DispatchQueue.main.async {
                        self.searchLabel.isHidden = true
                        self.collectionView.isHidden = false
                        self.collectionView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.searchLabel.text = "Try something else.."
                    }
                }
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = nil
        self.viewModel.resetPagingCount()
        
        self.searchLabel.isHidden = false
        self.collectionView.isHidden = true
        
        if searchText.count >= 1 {
            self.searchLabel.text = "Searching.."
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(makeSearch), userInfo: nil, repeats: false)
        } else if searchText.count == 0 {
            self.searchLabel.text = "Search Something.."
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getResultItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! SearchCollectionViewCell
        
        let items = self.viewModel.getResultItems()
        cell.configure(model: items[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let items = self.viewModel.getResultItems()
        
        let vc = DetailViewController(viewModel: DetailViewModel(model: items[indexPath.row]))
        self.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == self.viewModel.getResultItems().count - 4) {
            self.makeSearch()
        }
    }
}


extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width/2)-20
        let width = (view.frame.width/2)-20
        return CGSize(width: width, height: height)
    }
}
