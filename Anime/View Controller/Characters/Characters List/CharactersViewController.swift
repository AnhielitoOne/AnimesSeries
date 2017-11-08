//
//  CharactersViewController.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/7/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet weak var charactersUITableView: UITableView!
    
    let characterCellIdentifier = "SmallCharacterTableViewCell"
    var characters : [Character] = []
    var series : Series?
    var selectedCharacter : Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        self.title = self.series?.titleJapanese
        let seriesId = self.series?.id?.description
        self.requestCharacters(seriesId: seriesId!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureTableView() {
        self.charactersUITableView.delegate = self
        self.charactersUITableView.dataSource = self
        self.charactersUITableView.register(UINib(nibName: self.characterCellIdentifier, bundle: nil), forCellReuseIdentifier: self.characterCellIdentifier)
    }

    func requestCharacters(seriesId: String) {
        WebServicesAPI.requestSeriesCharacters(seriesId: seriesId) { (succes, characters) in
            if succes {
                self.characters = characters
                self.charactersUITableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "characterDetailSegue" {
            let characterDetailViewController = segue.destination as! CharactersDetailViewController
            characterDetailViewController.character = self.selectedCharacter
        }
    }
    

}

extension CharactersViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let characterCell = self.charactersUITableView.dequeueReusableCell(withIdentifier: self.characterCellIdentifier, for: indexPath) as! SmallCharacterTableViewCell
       let character = self.characters[indexPath.row]
         characterCell.character = character
        return characterCell
    }
}

extension CharactersViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let smallCharacterCell = self.charactersUITableView.cellForRow(at: indexPath) as! SmallCharacterTableViewCell
        self.selectedCharacter = smallCharacterCell.character
        self.performSegue(withIdentifier: "characterDetailSegue", sender: self)
    }
}
