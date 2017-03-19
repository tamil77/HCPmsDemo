//
//  CategoriesTableViewController.swift
//  HCPmsDemo
//
//  Created by Tamilarasan Lakshmanan on 3/18/17.
//  Copyright © 2017 Tamilarasan Lakshmanan. All rights reserved.
//

import UIKit
import Alamofire

class CategoriesTableViewController: UITableViewController {

    var categories : [Category] = []
    
    func loadCategories() {
        let deviceId      = UIDevice.current.identifierForVendor!.uuidString
        let deviceType    = UIDevice.current.model
        let deviceName    = UIDevice.current.name
        
        let urlConnection = "https://hcpms-s0017199085trial.hanatrial.ondemand.com/odata/applications/latest/tamil.swift.demo/Connections"
        let urlService    = "https://hcpms-s0017199085trial.hanatrial.ondemand.com/tamil.swift.demo"
        
        let httpHeaders : HTTPHeaders = [
            "Authorization" : "Basic OTA4M2FiYzctNmVhOC0zNTVjLWI0MGMtZmEyYzViYTQxNjQ0OjYyNDFhODkzLTg0ZGEtMzJlOC05YWU2LTJkMzRmNjRmNTQyZg==",
            "Content-Type"  : "application/json",
            "X-SMP-APPCID"  : deviceId
        ]
        
        let parameters: Parameters = [
            "DeviceType": deviceType,
            "UserName"  : deviceName
        ]
        
        Alamofire.request(urlConnection, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: httpHeaders).responseString { response in
            
            let statusCode = response.response?.statusCode
            
            Alamofire.request(urlService + "/Categories", method: .get, headers: httpHeaders).responseJSON { (response) -> Void in
                
                let jsonValue = response.result.value as! NSDictionary
                
                if let categoryArray = jsonValue["value"] as? [NSDictionary] {
                    for categoryObj in categoryArray {
                        let name:  String  = categoryObj.value(forKey: "CategoryName") as! String
                        let description:  String  = categoryObj.value(forKey: "Description") as! String
                        
                        let category: Category = Category(name: name, description: description)
                        
                        self.categories.append(category)
                        
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"CategoryCells", for: indexPath) as! CategoriesTableViewCell
//        let cell = CategoriesTableViewCell()
        
        let category = categories[indexPath.row]
        
        cell.nameLabel.text = category.name
        cell.descriptionLabel.text = category.description
        

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
