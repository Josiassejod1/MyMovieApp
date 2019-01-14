//
//  ViewController.swift
//  MyMovieApp
//
//  Created by Dalvin Sejour on 1/11/19.
//  Copyright © 2019 Dalvin Sejour. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell =  tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomTableViewClassTableViewCell
        let idx: Int = indexPath.row
        movieCell.movieTitle.text? = favoriteMovies[idx].title
        movieCell.movieYear.text? = favoriteMovies[idx].year
        displayMovieImage(idx, movieCell: movieCell)
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100;//Choose your custom row height
    }
    
    func displayMovieImage(_ row: Int, movieCell: CustomTableViewClassTableViewCell) {
        let url: String = (URL(string: favoriteMovies[row].imageUrl)?.absoluteString)!
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
    var favoriteMovies: [Movie] = []
    @IBOutlet var mainTableView: UITableView!
    //When view is showing this is the mainview on the story board
    override func viewWillAppear(_ animated: Bool) {
        //When the app start loading it initilize with a movie
        mainTableView.reloadData()
        if favoriteMovies.count == 0 {
            favoriteMovies.append(Movie(id: "tt0372784", title: "Batman Begins", year:
                "2005", imageUrl: "https://m.media-amazon.com/images/M/MV5BZmUwNGU2ZmItMmRiNC00MjhlLTg5YWUtODMyNzkxODYzMmZlXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg"))
        }
       super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

