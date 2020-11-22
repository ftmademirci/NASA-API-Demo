//
//  MainViewController.swift
//  NasaDemo
//
//  Created by Admin on 16.11.2020.
//

import UIKit

protocol FilterDelegate {
    func filterByCamera(_ cameraName: String)
}
class MainViewController: UIViewController, FilterDelegate {
    
    var roverType: RoverTypes!
    
    var viewModel: MainViewModel!
    
    let activityInstance = Indicator()
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var filterControlViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var filterNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = MainViewModel(api: API(), roverType: self.roverType)
        self.fetchPhotos()
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func resetPagination() {
        self.collectionView.contentOffset.x = 0
        self.viewModel.resetPagination()
    }
    
    func loadMore() {
        self.fetchPhotos()
    }
    
    func fetchPhotos() {
        self.activityInstance.showIndicator()
        self.viewModel.fetchPhotos(success: {
            self.activityInstance.hideIndicator()
            self.collectionView.reloadData()
            if self.viewModel.cameraName == nil {
                self.filterControlViewHeightConstraint.constant = 0
                self.cancelButton.isHidden = true
            } else {
                self.filterControlViewHeightConstraint.constant = 50
                self.cancelButton.isHidden = false
                self.filterNameLabel.text = "Current Filter: \(self.viewModel.cameraName.uppercased())"
            }
        }, failure: { error in
            print(error!)
        })
    }
    
    func filterByCamera(_ cameraName: String) {
        self.viewModel.cameraName = cameraName
        self.resetPagination()
        fetchPhotos()
    }
    
    @IBAction func filterDisable() {
        self.viewModel.cameraName = nil
        self.resetPagination()
        fetchPhotos()
    }
    
    func filter() {
        let filterViewController = FilterViewController(nibName: "FilterViewController", bundle: nil)
        filterViewController.delegate = self
        filterViewController.viewModel = FilterViewModel(roverType: self.roverType)
        self.show(filterViewController, sender: nil)
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = self.viewModel.getRow(indexPath.row) {
            let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
            detailVC.detailContent = item
            detailVC.modalPresentationStyle = .popover
            detailVC.modalPresentationStyle = .overCurrentContext
            detailVC.modalTransitionStyle = .crossDissolve
            present(detailVC, animated: true, completion: nil)
        }
    }
}

extension MainViewController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.viewModel.getNextPage(indexPath.row) {
            self.fetchPhotos()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getRowCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        if let item = self.viewModel.getRow(indexPath.row) {
            cell.imageView.kf.setImage(with: URL(string: item.img_src ?? ""))
        }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width/2) - 20, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}




