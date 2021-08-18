//
//  AddToCartViewController.swift
//  FinalProject_OrderUrSlice
//
//  Created by Saurav Arya on 12/08/21.
//

import UIKit

class AddToCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var addToCartCell: UITableView!
    
//    var appendItem = ""
    var selectedRow:AddToCartListItem = AddToCartListItem()
    var addToCartArray:[AddToCartListItem] = [AddToCartListItem]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add to Cart List"
        
        self.addToCartCell.delegate = self
        self.addToCartCell.dataSource = self
//        // Do any additional setup after loading the view.
        getAllItems()
//        self.addToCartArray.append(<#AddToCartListItem#>)
//        createItem(pizzaItem: appendItem)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addToCartArray.count
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.addToCartCell.dequeueReusableCell(withIdentifier: "addToCartCell")!

        let model = self.addToCartArray[indexPath.row]

        cell.textLabel?.text = model.pizzaItem

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        addToCartCell.deselectRow(at: indexPath, animated: true)
        selectedRow = addToCartArray[indexPath.row]
//        self.deleteItem(item: selectedDeleteRow)
//        getAllItems()
    }
        
    @IBAction func deleteSelectedItem(_ sender: Any) {
        self.deleteItem(item: selectedRow)
        getAllItems()
    }
    
    
    @IBAction func customizeItem(_ sender: Any) {
        performSegue(withIdentifier: "customizeItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customizeItem"{
            let dst = segue.destination as! CustomizeViewController
    //        dst.addToCartArray += selectedArray
            dst.updateRow = selectedRow
    //        dst.appendItem = selectedPizza
        }
    }
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getAllItems(){
        do{
            addToCartArray = try context.fetch(AddToCartListItem.fetchRequest())
            DispatchQueue.main.async {
                self.addToCartCell.reloadData()
            }
        }
        catch{
//            error
        }
    }
    
    func createItem(pizzaItem: String){
        let newItem = AddToCartListItem(context: context)
        newItem.pizzaItem = pizzaItem
//        newItem.pizzaDescription = Description
//        newItem.pizzaPrice = pizzaPrice
        
        do{
            try context.save()
            getAllItems()
        }
        catch{
            
        }
    }
    func deleteItem(item: AddToCartListItem){
        context.delete(item)
        do{
            try context.save()
        }
        catch{
            
        }
    }
    
    func updateItem(item: AddToCartListItem, newPizzaItem: String){
        item.pizzaItem = newPizzaItem
        do{
            try context.save()
            getAllItems()
        }
        catch{
            
        }
    }

}
