//
//  AddToCartViewController.swift
//  FinalProject_OrderUrSlice
//
//  Created by Saurav Arya on 12/08/21.
//

import UIKit

class AddToCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var addToCartCell: UITableView!
    var addToCartArray:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addToCartCell.delegate = self
        self.addToCartCell.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addToCartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.addToCartCell.dequeueReusableCell(withIdentifier: "addToCartCell")!
        
//        let model = self.pizzaListArray[indexPath.row]
        
        cell.textLabel?.text = self.addToCartArray[indexPath.row]
        
        return cell
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
