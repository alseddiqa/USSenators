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
    var democartsList = [Object]()
    var republicansList = [Object]()
    
    var democrat = false
    var repub = false
    var all = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // assign delegate and data source for the table
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //read json file
        let data = readLocalFile(forName: "us_senatorsj")
        
        //parse result data
        if let data = data {
            self.parse(jsonData: data)
        }
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
                if all {
                    let senator = senatorsList[row]
                    let destinationVC = segue.destination as! SenatorDetailViewController
                    destinationVC.senator = senator
                } else if democrat {
                    let senator = democartsList[row]
                    let destinationVC = segue.destination as! SenatorDetailViewController
                    destinationVC.senator = senator
                }
                else {
                    let senator = republicansList[row]
                    let destinationVC = segue.destination as! SenatorDetailViewController
                    destinationVC.senator = senator
                }
                
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    /// A segment controller to filter out senators based on party label
    /// - Parameter sender: the segment controller
    @IBAction func partySegment(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            democartsList = self.senatorsList.filter {$0.party.rawValue == "Democrat"}
            democrat = true
            all = false
            repub = false
        case 2:
            republicansList = self.senatorsList.filter {$0.party.rawValue == "Republican"}
            repub = true
            all = false
            democrat = false
        default:
            print("all")
            repub = false
            democrat = false
            all = true
        }
        self.tableView.reloadData()
    }
    
    
}

extension SenatorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return senatorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "senatorCell") as! SenatorCell
        
        var senators = [Object]()
        if all {
            senators = senatorsList
        } else if democrat {
            senators = democartsList
        }
        else {
            senators = republicansList
        }
        
        //sort senators based on last name
        senators.sort()
        
        let senator = senators[indexPath.row]
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
