//
//  CharactersDetailViewController.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/8/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit

class CharactersDetailViewController: UIViewController {

    @IBOutlet weak var charactersDetailUITableView: UITableView!
    
    let characterCellIdentifier = "CharacterInformationTableViewCell"
    let headerIdentifier = "CharacterDetailHeaderView"
    var headerView : CharacterDetailHeaderView = CharacterDetailHeaderView()
    var character : Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        let characterId = self.character?.id?.description
        self.requestCharacterInfo(characterId: characterId!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.configureTableHeaderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.charactersDetailUITableView.estimatedRowHeight = 300
        self.charactersDetailUITableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func configureTableView() {
        self.charactersDetailUITableView.delegate = self
        self.charactersDetailUITableView.dataSource = self
        self.charactersDetailUITableView.register(UINib(nibName: self.characterCellIdentifier, bundle: nil), forCellReuseIdentifier: self.characterCellIdentifier)
    }
    
    func configureTableHeaderView(){
        self.headerView = Bundle.main.loadNibNamed(headerIdentifier, owner: self, options: nil)![0] as? UIView as! CharacterDetailHeaderView
        self.charactersDetailUITableView.tableHeaderView = self.headerView;
        self.charactersDetailUITableView.tableFooterView = UIView()
        self.setInfoHeader()
    }

    func setInfoHeader() {
        self.headerView.character = self.character
    }
    
    func requestCharacterInfo(characterId: String) {
        WebServicesAPI.requestCharacterInfo(characterId: characterId) { (succes, character) in
            if succes {
                self.character = character
                self.charactersDetailUITableView.reloadData()
                self.setInfoHeader()

            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CharactersDetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let characterInformationCell = self.charactersDetailUITableView.dequeueReusableCell(withIdentifier: self.characterCellIdentifier, for: indexPath) as! CharacterInformationTableViewCell
        characterInformationCell.info = self.character?.info!
        return characterInformationCell
    }
}

extension CharactersDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
