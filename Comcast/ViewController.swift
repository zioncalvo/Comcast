//
//  ViewController.swift
//  Comcast
//
//  Created by Zion Calvo on 8/16/21.
//

import UIKit

struct API : Codable {
    var API: String?
    var Description: String?
    var Link: String?
}

struct Response : Codable {
    var count: Int?
    var entries: [API]?
}

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var apis: [API] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        tableView.register(APITableViewCell.self, forCellReuseIdentifier: APITableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        getData()

    }
    
    func getData() {
        let url = URL(string: "https://api.publicapis.org/entries")

        if let url = url {
            
            let request = URLRequest(url: url)
            let session = URLSession.shared
            
            session.dataTask(with: request) { [weak self] data, res, err in
                
                if err != nil {
                    print(err?.localizedDescription)
                }
                else {
                    
                    do {
                        
                        if let data = data {
                            let json = try JSONDecoder().decode(Response.self, from: data)
                            
                            guard let entries = json.entries else {
                                return
                            }
                            
                            self?.apis = entries
                            print(self?.apis)
                            DispatchQueue.main.async {
                                self?.title = "\(self?.apis.count)"
                                self?.tableView.reloadData()
                            }
                            
                        }
                                        
                    } catch {
                        print("Error")
                    }
                    
                }
                
            }.resume()

        }
    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: APITableViewCell.identifier) as! APITableViewCell
        
        cell.setUpCell(api: apis[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(apis.count)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apis.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
