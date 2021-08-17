//
//  CustomizeViewController.swift
//  FinalProject_OrderUrSlice
//
//  Created by Saurav Arya on 11/08/21.
//

import UIKit

class CustomizeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var selectPickerView: UIPickerView!
    @IBOutlet weak var pizzaName: UILabel!
    
    var selectedPizza = ""
    var size: String = ""
    var crust:String = ""
    var topping:String = ""
    var updateRow:AddToCartListItem = AddToCartListItem()
    
    var selectPickerData = [["None", "Regular", "Medium", "Large"],["None", "Hand Tossed","Cheese Burst","Fresh Pan"],["None", "Crisp Onion", "Golden Corn", "Red Pepper"]]
    
    var selectedArray:[String] = [String]()
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
        return selectPickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedSize = pickerView.selectedRow(inComponent: 0)
        let selectedCrust = pickerView.selectedRow(inComponent: 1)
        let selectedTopping = pickerView.selectedRow(inComponent: 2)
        size = selectPickerData[0][selectedSize]
        crust = selectPickerData[1][selectedCrust]
        topping = selectPickerData[2][selectedTopping]
//        selectedPizza = "\(size): \(crust): \(topping)"
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
            dst.updateItem(item: updateRow, newPizzaItem: selectedPizza)
//            dst.appendItem = selectedPizza
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
