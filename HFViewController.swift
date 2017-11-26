//
//  HFViewController.swift
//  HFCurrency
//
//  Created by Michał Korycki on 26.11.2017.
//  Copyright © 2017 Michał Korycki. All rights reserved.
//

import UIKit

class HFViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: HFCurrencyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        
        if string == ""
        {
            return true
        }
        
        let symbols = string.rangeOfCharacter(from: CharacterSet.symbols)
        let letters = string.rangeOfCharacter(from: CharacterSet.letters)
        let whitenewlines = string.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines)
        
        if symbols != nil || letters != nil || whitenewlines != nil
        {
            return false
        }
        
        
        let separator = self.textField.formatter.decimalSeparator!
        
        let separatorPosition = textField.text?.index(of: Character.init(separator))
        
        let fractionDigits = self.textField.formatter.maximumFractionDigits
        
        
        if string == separator
        {
            if fractionDigits == 0 || separatorPosition != nil
            {
                return false
            }
        }
        else
        {
            if let sepPos = separatorPosition, let suffix = textField.text?.suffix(from: sepPos)
            {
                if range.location > sepPos.encodedOffset && fractionDigits - (suffix.count - 1) <= 0
                {
                    return false
                }
            }
        }
        
        
        
        return true
    }
    
}
