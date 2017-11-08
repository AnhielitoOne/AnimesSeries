//
//  TrailerViewController.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/7/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var webWKWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMovieTrailer()
        // Do any additional setup after loading the view.
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMovieTrailer() {
        let url = URL(string: "https://www.youtube.com/watch?v=AsvlgALMR4w")
        let request = URLRequest(url: url!)
        self.webWKWebView.load(request)
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
