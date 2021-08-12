//
//  ViewController.swift
//  FinalProject_OrderUrSlice
//
//  Created by Saurav Arya on 09/08/21.
//

import UIKit

class PizzaDetails{
    var name: String
    var desc: String
    
    init(name: String, desc: String){
        self.name = name
        self.desc = desc
    }
    
    public var description: String { return name + ": " + desc}
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var pizzaListCell: UITableView!
    
    var pizzaListArray:[PizzaDetails] = [PizzaDetails]()
    var selectedRowText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.pizzaListCell.delegate = self
        self.pizzaListCell.dataSource = self
        
        self.pizzaListArray.append(PizzaDetails(name: "Classic Margherita", desc: "Classic delight with mozzarella cheese"))
        self.pizzaListArray.append(PizzaDetails(name: "The Unthinkable Pizza", desc: "Loaded with plant based protein topping along with black olives and red paprika"))
        self.pizzaListArray.append(PizzaDetails(name: "Pepper Barbecue Chicken", desc: "Pepper barbecue chicken for that extra zing"))
        self.pizzaListArray.append(PizzaDetails(name: "Chicken Golden Delight", desc: "Double pepper barbecue chicken, golden corn and extra cheese, true delight"))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.pizzaListCell.dequeueReusableCell(withIdentifier: "pizzaListCell")!
        
        let model = self.pizzaListArray[indexPath.row]
        
        cell.textLabel?.text = model.description
//        cell.textLabel?.text = model.desc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaListArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowText = self.pizzaListArray[indexPath.row].description
    }
    
    
    @IBAction func customize(_ sender: Any) {
        performSegue(withIdentifier: "customize", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customiza"{
            segue.destination as! CustomizeViewController
        }
        else if segue.identifier == "addToCartDirectly"{
            let dst = segue.destination as! AddToCartViewController
            dst.addToCartArray.append(selectedRowText)
        }
    }
    
    
    @IBAction func addToCartDirectly(_ sender: Any) {
        performSegue(withIdentifier: "addToCartDirectly", sender: self)
    }
    
}


