//
//  SearchViewController.swift
//  MyMovieApp
//
//  Created by Dalvin Sejour on 1/11/19.
//  Copyright © 2019 Dalvin Sejour. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var searchResults: [Movie] = []

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell =  tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomTableViewClassTableViewCell
        let idx: Int = indexPath.row
        movieCell.movieTitle.text? = searchResults[idx].title
        movieCell.favButton.tag = idx
        movieCell.movieYear.text? = searchResults[idx].year
        displayMovieImage(idx, movieCell: movieCell)
        return movieCell
    }
    
    
    func displayMovieImage(_ row: Int, movieCell: CustomTableViewClassTableViewCell) {
        let url: String = (URL(string: searchResults[row].imageUrl)?.absoluteString)!
        /*Make http request, that allows us to make a call to a website to see if it is available... simple way to make a get request
         
         */
        /*
         handler to check if that went through
         */
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            
            //handles the threading in the application and allows us to initialize a new image using the
            //data above
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                movieCell.movieImageView?.image = image
            })
        }).resume()
    }
    
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieYear: UILabel!
    @IBOutlet var movieImage: UIImageView!
    
    @IBAction func search (sender: UIButton) {
        print("Searching...")
        var searchterm = searchText.text!
        if ( searchterm.characters.count > 2) {
           retriveMoviesByTerm(searchTerm: searchterm)
        }
    }
    
    func retriveMoviesByTerm(searchTerm: String){
        let url = "https://www.omdbapi.com/?s=\(searchTerm)&type=movie&response=json&apiKey=924fc682"
        HTTPHandler.getJson(urlString: url, completionHandler: parseDataIntoMovies)
    }
    
    func parseDataIntoMovies(data: Data?) -> Void {
        if let data = data {
            let object = JSONParser.parse(data: data)
                if let object = object {
                    self.searchResults = MovieDataProcessor.mapJsonToMovies(object: object, moviesKey: "Search")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
