//
//  ViewController.swift
//  WebServiceCallEx1
//
//  Created by Sudeb Sarkar on 06/06/17.
//  Copyright © 2017 test ss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webServiceCall(service: "sudeb")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func webServiceCall(service:String) {
        
        // Set up the URL request
        let todoEndpoint: String = "http://api.geonames.org/citiesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&lang=de&username=demo"
        guard let url = URL(string :todoEndpoint) else {
            print("can't create URL")
            return
        }
        
        let urlRequest = URLRequest(url:url)
        
        let config = URLSessionConfiguration.default;
        
        let session = URLSession(configuration:config)
        
        let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            guard error == nil else {
                print("error calling GET on /todos/1 \(String(describing: error))")
                 return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
                print("The todo is: " + todo.description)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
            
        }
                task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

