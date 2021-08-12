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
    
    var selectPickerData = [["None", "Regular", "Medium", "Large"],["None", "Hand Tossed","Cheese Burst","Fresh Pan"],["None", "Crisp Onion", "Golden Corn", "Red Pepper"]]
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
        let size = selectPickerData[0][selectedSize]
        let crust = selectPickerData[1][selectedCrust]
        let topping = selectPickerData[2][selectedTopping]
        selectedPizza = "\(size): \(crust): \(topping)"
    }
    
    @IBAction func addToCartBtn(_ sender: Any) {
        performSegue(withIdentifier: "addToCart", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let dst = segue.destination as! AddToCartViewController
        dst.addToCartArray.append(selectedPizza)
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
