//
//  AnimeViewController.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/5/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit

class AnimeViewController: UIViewController {

    
    @IBOutlet weak var animeUICollectionView: UICollectionView!
    @IBOutlet var seeAllUIBarButtonItem: UIBarButtonItem!
    
    let cellIdentifier = "AnimeCoverCollectionViewCell"
    var series : [Series] = []
    var filteredSeries : [Series] = []
    var selectedSeries : Series?
    var searchController : UISearchController!
    var searchText : String!
    var isFiltering : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.setTitleWithImage()
        if  User.shared.accesToken == ""  {
            self.requestToken()
        }
        else{
            self.requestAnimeList()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTitleWithImage() {
        let logo = UIImage(named: "circle")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func configureCollectionView() {
        self.animeUICollectionView.delegate = self
        self.animeUICollectionView.dataSource = self
        self.animeUICollectionView.register(UINib(nibName: self.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: self.cellIdentifier)
    }
    
    
    
    
    func requestToken() {
        WebServicesAPI.requestAccesToken { (succes) in
            if succes {
                self.requestAnimeList()
            }
        }

    }
    
    func requestAnimeList() {
        WebServicesAPI.requestAnimeList { (succes, series) in
            if succes {
                self.series = series
                self.animeUICollectionView.reloadData()
            }
            else{
                print("Token Request")
                self.requestToken()
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "animeDetailSegue" {
            let animeDetailViewController = segue.destination as! AnimeDetailViewController
            animeDetailViewController.series = self.selectedSeries
        }
    }
    
    // MARK: - Actions

    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.text = self.searchText
        self.present(self.searchController, animated: true, completion: nil)
    }
    
    @IBAction func seeAllSeriesAction(_ sender: UIBarButtonItem) {
        self.isFiltering = false
        self.navigationItem.leftBarButtonItem = nil
        self.animeUICollectionView.reloadData()
    }
    
}

extension AnimeViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isFiltering {
            return self.filteredSeries.count
        }
        else{
            return self.series.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let seriesCell = self.animeUICollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AnimeCoverCollectionViewCell
        if self.isFiltering {
            seriesCell.series = self.filteredSeries[indexPath.row]
        }
        else{
            seriesCell.series = self.series[indexPath.row]
        }
        return seriesCell
    }
    
   
}

extension AnimeViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = self.animeUICollectionView.cellForItem(at: indexPath) as! AnimeCoverCollectionViewCell
        self.selectedSeries = selectedCell.series
        self.performSegue(withIdentifier: "animeDetailSegue", sender: self)
    }
    
}

extension AnimeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3.2 - 1
        
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}

extension AnimeViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchText = searchBar.text!
        self.navigationItem.title = searchText.uppercased()
        WebServicesAPI.searchSeries(serachSeries: searchText) { (succes, foundSeries) in
            if succes {
                self.filteredSeries = foundSeries
                self.isFiltering = true
                self.navigationItem.leftBarButtonItem = self.seeAllUIBarButtonItem
                self.animeUICollectionView.reloadData()
            }
            self.searchController.dismiss(animated: true, completion: nil)

        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isFiltering = false
        self.animeUICollectionView.reloadData()

    }
}

