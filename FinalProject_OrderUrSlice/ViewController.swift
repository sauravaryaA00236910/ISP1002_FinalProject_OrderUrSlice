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
    var price: Int
    
    init(name: String, desc: String, price: Int){
        self.name = name
        self.desc = desc
        self.price = price
    }
    
    public var description: String { return name + ": " + desc + ": $" + String(price)}
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var pizzaListCell: UITableView!
    
    @IBOutlet weak var addToCartDirectly: generalButton!
    @IBOutlet weak var viewCart: generalButton!
    @IBOutlet weak var customize: generalButton!
    @IBOutlet weak var readyMadePizzaAmount: UITextField!
    
    var pizzaListArray:[PizzaDetails] = [PizzaDetails]()
    var selectedRowText = ""
    var selectedPizza = ""
    var pizzaAmount: Int = 0
    var selectedRowArray:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customize.backgroundColor = UIColor.secondarySystemBackground
        customize.layer.cornerRadius = 4
        customize.setTitleColor(UIColor.systemBlue, for: .normal)
       
        
        self.pizzaListCell.delegate = self
        self.pizzaListCell.dataSource = self
        
        self.pizzaListArray.append(PizzaDetails(name: "Classic Margherita", desc: "Classic delight with mozzarella cheese", price: 2))
        self.pizzaListArray.append(PizzaDetails(name: "The Unthinkable Pizza", desc: "Loaded with plant based protein topping along with black olives and red paprika", price: 3))
        self.pizzaListArray.append(PizzaDetails(name: "Pepper Barbecue Chicken", desc: "Pepper barbecue chicken for that extra zing", price: 4))
        self.pizzaListArray.append(PizzaDetails(name: "Chicken Golden Delight", desc: "Double pepper barbecue chicken, golden corn and extra cheese, true delight", price: 4))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.pizzaListCell.dequeueReusableCell(withIdentifier: "pizzaListCell")!
        
        let model = self.pizzaListArray[indexPath.row]
        
        cell.textLabel?.text = model.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaListArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowText = self.pizzaListArray[indexPath.row].description
        pizzaAmount = self.pizzaListArray[indexPath.row].price
        if !readyMadePizzaAmount.isEqual(pizzaAmount){
            readyMadePizzaAmount.text = "$" + String(pizzaAmount)
        }
    }
    
    
    @IBAction func customize(_ sender: Any) {
        performSegue(withIdentifier: "customize", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customize"{
            let dst = segue.destination as! CustomizeViewController
        }
        else if segue.identifier == "addToCartDirectly"{
            let dst = segue.destination as! AddToCartViewController
            dst.createItem(pizzaItem: selectedPizza)
        }
    }
    
    
    @IBAction func addToCartDirectly(_ sender: Any) {
        selectedPizza = selectedRowText
        performSegue(withIdentifier: "addToCartDirectly", sender: self)
    }
    
    @IBAction func viewCart(_ sender: Any) {
        performSegue(withIdentifier: "viewCart", sender: self)
    }
}

class generalButton: UIButton{
    override func didMoveToWindow() {
        self.backgroundColor = UIColor.secondarySystemBackground
        self.layer.cornerRadius = 4
        self.setTitleColor(UIColor.systemBlue, for: .normal)
    }
}
