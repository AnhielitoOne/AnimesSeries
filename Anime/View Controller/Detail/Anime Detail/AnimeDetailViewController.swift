//
//  AnimeDetailViewController.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/7/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit

class AnimeDetailViewController: UIViewController {

    @IBOutlet weak var infoUITableView: UITableView!
    
    var series : Series?
    let infoCellIdentifier = "SerieInfoTableViewCell"
    let headerIdentifier = "HeaderAnimeDetailView"
    var headerView : HeaderAnimeDetailView = HeaderAnimeDetailView()
    var infoTitles : [String] = []
    var infoValues : [String] = []
    var rowCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.getInfoFromSeries(series: self.series!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.configureTableHeaderView()
    }
    
    
    
    func configureTableView() {
        
        self.infoUITableView.delegate = self
        self.infoUITableView.dataSource = self
        self.infoUITableView.register(UINib(nibName: infoCellIdentifier, bundle: nil), forCellReuseIdentifier: infoCellIdentifier)
        self.infoUITableView.register(UINib(nibName: headerIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: headerIdentifier)
        
    }
    
    func configureTableHeaderView(){
        self.headerView = Bundle.main.loadNibNamed(headerIdentifier, owner: self, options: nil)![0] as? UIView as! HeaderAnimeDetailView
        self.infoUITableView.tableHeaderView = self.headerView;
        self.infoUITableView.tableFooterView = UIView()
        self.headerView.delegate = self
        self.setInfoHeader()
    }
    
    func setInfoHeader() {
        self.headerView.series = self.series
    }
    
    func getInfoFromSeries(series: Series) -> [String:String]{
        let infoSeries : [String:String] = [
            "Title"         : series.titleJapanese ?? "",
            "Type"          : series.type ?? "",
            "Start Date"    : series.startDateFuzzy?.description ?? "",
            "End Date"      : series.endDateFuzzy?.description ?? "",
            "Seasons"       : series.season?.description ?? "",
            "Series Type"   : series.seriesType ?? "",
            "Adult"         : series.adult?.description ?? "",
            "Avarage Score" : series.avarageScore?.description ?? "",
            "Popularity"    : series.popularity?.description ?? "",
            "Updated At"    : series.updatedAt?.description ?? "",
            "Total Episodes": series.totalEpisodes?.description ?? "",
            "Airing Status" : series.airingStatus ?? ""
        ]
        
        self.infoTitles = Array(infoSeries.keys)
        self.infoValues = Array(infoSeries.values)
        self.rowCount = self.infoTitles.count
        return infoSeries
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "charactersSegue" {
            let charactersViewController = segue.destination as! CharactersViewController
            charactersViewController.series = self.series
        }
    }
    
    // MARK: - Actions
    @IBAction func showTrailerAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "trailerSegue", sender: self)
    }
    
}

extension AnimeDetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let infoCell = self.infoUITableView.dequeueReusableCell(withIdentifier: self.infoCellIdentifier, for: indexPath) as! SerieInfoTableViewCell
        let infoTitle = self.infoTitles[indexPath.row]
        let infoValue = self.infoValues[indexPath.row]
        infoCell.infoTitle = infoTitle
        infoCell.info = infoValue
        
        return infoCell
    }
}

extension AnimeDetailViewController : UITableViewDelegate {
    
}

extension AnimeDetailViewController : HeaderAnimeDetailViewDelegate {
    func moreInfoSelected(seriesId: Int) {
        print("More Info")
        self.performSegue(withIdentifier: "charactersSegue", sender: self)
    }
}
