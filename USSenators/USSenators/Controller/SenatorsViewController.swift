//
//  SenatorsViewController.swift
//  USSenators
//
//  Created by Abdullah Alseddiq on 1/14/21.
//

import UIKit

class SenatorsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var senatorsList = [Object]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // assign delegate and data source for the table
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //read json file
        let data = readLocalFile(forName: "us_senatorsj")
        
        //parse result data
        self.parse(jsonData: data!)
    }
    
    /// A helper function to read local file
    /// - Parameter name: the name of the file
    /// - Returns: data in the json formatt
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    /// A helper function to map objects from JSON to the defined struct
    /// - Parameter jsonData: json data
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(Senators.self,
                                                       from: jsonData)
            print(decodedData.objects)
            print("---end json---")
            self.senatorsList = decodedData.objects
            self.tableView.reloadData()
        } catch {
            print("decode error")
            print(error)
        }
    }
    
    //Preparing for segue to the detail view of senator
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "detailsSegue":
            if let row = tableView.indexPathForSelectedRow?.row {
                let senator = senatorsList[row]
                let destinationVC = segue.destination as! SenatorDetailViewController
                destinationVC.senator = senator
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
}

extension SenatorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return senatorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "senatorCell") as! SenatorCell
        
        let senator = self.senatorsList[indexPath.row]
        cell.sentatorNameLabel.text = senator.person.name
        cell.partyLabel.text = senator.party.rawValue
        cell.departmentLabel.text = senator.objectDescription
        if senator.party.rawValue == "Democrat" {
            cell.senatorProfileImage.image = #imageLiteral(resourceName: "democrat")
        }
        else if senator.party.rawValue == "Republican" {
            cell.senatorProfileImage.image = #imageLiteral(resourceName: "republican")
        }
        cell.setShadow()

        return cell
    }
    
    
}
