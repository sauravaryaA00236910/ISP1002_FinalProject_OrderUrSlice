//
//  CustomizeViewController.swift
//  FinalProject_OrderUrSlice
//
//  Created by Saurav Arya on 11/08/21.
//

import UIKit

class PizzaCustomize{
    var customizeField: String
    var price: Int
    
    init(customizeField: String, price: Int){
        self.customizeField = customizeField
        self.price = price
    }
    
    public var description: String { return customizeField + ": $" + String(price)}
    
}
//class PizzaCrust{
//    var crust: String
//    var price: Int
//
//    init(crust: String, price: Int){
//        self.crust = crust
//        self.price = price
//    }
//
//    public var description: String { return crust + ": $" + String(price)}
//
//}
//class PizzaTopping{
//    var topping: String
//    var price: Int
//
//    init(topping: String, price: Int){
//        self.topping = topping
//        self.price = price
//    }
//
//    public var description: String { return topping + ": $" + String(price)}
//
//}

class CustomizeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var selectPickerView: UIPickerView!
    @IBOutlet weak var pizzaName: UILabel!
    @IBOutlet weak var customPizzaAmount: UITextField!
    @IBOutlet weak var currentSelected: UITextField!
    
    var selectedPizza = ""
    var size: String = ""
    var crust:String = ""
    var topping:String = ""
    var sizePrice: Int = 0
    var crustPrice: Int = 0
    var toppingPrice:Int = 0
    var totalPrice: Int = 0
    var updateRow:AddToCartListItem = AddToCartListItem()
    var addToCartArrayDuplicate: [AddToCartListItem] = [AddToCartListItem]()
    
    var selectedArray:[PizzaCustomize] = [PizzaCustomize]()
    var selectPickerData = [[PizzaCustomize(customizeField: "None", price: 0), PizzaCustomize(customizeField: "Regular", price: 1), PizzaCustomize(customizeField: "Medium", price: 2), PizzaCustomize(customizeField: "Large", price: 3)],[PizzaCustomize(customizeField: "None", price: 0), PizzaCustomize(customizeField: "Hand Tossed", price: 1), PizzaCustomize(customizeField: "Cheese Burst", price: 2),PizzaCustomize(customizeField: "Thin Crust", price: 2), PizzaCustomize(customizeField: "Fresh Pan", price: 3)],[PizzaCustomize(customizeField: "None", price: 0), PizzaCustomize(customizeField: "Grilled Mushroom", price: 1), PizzaCustomize(customizeField: "Crisp Onion", price: 1), PizzaCustomize(customizeField: "Fresh Tomato", price: 1), PizzaCustomize(customizeField: "Golden Corn", price: 1), PizzaCustomize(customizeField: "Red Pepper", price: 1), PizzaCustomize(customizeField: "Barbeque Chicken", price: 2), PizzaCustomize(customizeField: "Peri-Peri Chicken", price: 2), PizzaCustomize(customizeField: "Chicken Sausage", price: 2), PizzaCustomize(customizeField: "Chicken Pepproni", price: 2), PizzaCustomize(customizeField: "Chicken Tikka", price: 2)]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectPickerView.delegate = self
        self.selectPickerView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return selectPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectPickerData[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return selectPickerData[component][row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedSize = pickerView.selectedRow(inComponent: 0)
        let selectedCrust = pickerView.selectedRow(inComponent: 1)
        let selectedTopping = pickerView.selectedRow(inComponent: 2)
        size = selectPickerData[0][selectedSize].description
        crust = selectPickerData[1][selectedCrust].description
        topping = selectPickerData[2][selectedTopping].description
        sizePrice = selectPickerData[0][selectedSize].price
        crustPrice = selectPickerData[1][selectedCrust].price
        toppingPrice = selectPickerData[2][selectedTopping].price
        selectedPizza = "\(size): \(crust): \(topping)"
        currentSelected.text = selectedPizza
    }
    
    
    @IBAction func calculateTotal(_ sender: Any) {
        if !customPizzaAmount.isEqual(sizePrice+crustPrice+toppingPrice){
            totalPrice = sizePrice + crustPrice + toppingPrice
            customPizzaAmount.text = "$"+String(totalPrice)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addToCart"{
            let dst = segue.destination as! AddToCartViewController
    //        dst.addToCartArray += selectedArray
            dst.createItem(pizzaItem: selectedPizza)
    //        dst.appendItem = selectedPizza
        }
        else if segue.identifier == "updateCartItem"{
            let dst = segue.destination as! AddToCartViewController
            if addToCartArrayDuplicate.contains(updateRow){
                dst.updateItem(item: updateRow, newPizzaItem: selectedPizza)
            }else{
                let uialert = UIAlertController(title: "Error", message: "Please click on the Add To Cart New Item option to add newly created item.", preferredStyle: UIAlertController.Style.alert)
                      uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                   self.present(uialert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func addToCartBtn(_ sender: Any) {
//        self.selectedArray.append(selectedPizza)
        selectedPizza = "\(size): \(crust): \(topping)"
        performSegue(withIdentifier: "addToCart", sender: self)
    }
    
        
    @IBAction func updateCartItem(_ sender: Any) {
        selectedPizza = "\(size): \(crust): \(topping)"
        performSegue(withIdentifier: "updateCartItem", sender: self)
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
