//
//  AddToCartViewController.swift
//  FinalProject_OrderUrSlice
//
//  Created by Saurav Arya on 12/08/21.
//

import UIKit

class AddToCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var addToCartCell: UITableView!
    
    var selectedRow:AddToCartListItem = AddToCartListItem()
    var addToCartArray:[AddToCartListItem] = [AddToCartListItem]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add to Cart"
        
        self.addToCartCell.delegate = self
        self.addToCartCell.dataSource = self
//        Do any additional setup after loading the view.
        getAllItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addToCartArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.addToCartCell.dequeueReusableCell(withIdentifier: "addToCartCell")!

        let model = self.addToCartArray[indexPath.row]

        cell.textLabel?.text = model.pizzaItem

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = addToCartArray[indexPath.row]
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
            if addToCartArray.contains(selectedRow){
                dst.updateRow = selectedRow
                dst.addToCartArrayDuplicate = addToCartArray
            }else{
                let uialert = UIAlertController(title: "Error", message: "Please select a cart item to customize.", preferredStyle: UIAlertController.Style.alert)
                      uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                   self.present(uialert, animated: true, completion: nil)
            }
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
