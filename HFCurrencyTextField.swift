//
//  HFCurrencyTextField.swift
//  HFCurrency
//
//  Created by Michał Korycki on 19.11.2017.
//  Copyright © 2017 Michał Korycki. All rights reserved.
//

import UIKit

class HFCurrencyTextField: UITextField
{
    
    private var cont : AnyObject!
    
    private var form : NumberFormatter!
    
    
    
    var contents : AnyObject
    {
        get {return cont}
        set
        {
            if newValue is HFCurrency || newValue is HFExchangeRate
            {
                cont = newValue
                setCurrencyTextField()
                clear()
            }
        }
        
    }
    
    var formatter : NumberFormatter
    {
        get {return form}
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        cont = HFCurrency.init(code: "USD")
        
        form = NumberFormatter.init()
        
        keyboardType = .decimalPad
        
        setCurrencyTextField()
        
        addTarget(self, action: #selector(displayAmount), for: .editingDidBegin)
        
        addTarget(self, action: #selector(updateAmount), for: .editingChanged)
        
        addTarget(self, action: #selector(updateText), for: .editingDidEnd)
    }
    
    
    func setCurrencyTextField()
    {
        if let currency = cont as? HFCurrency
        {
            formatter.minimumIntegerDigits = 1
            formatter.minimumFractionDigits = currency.currencyDescription.frac
            formatter.maximumFractionDigits = currency.currencyDescription.frac
            
            placeholder = currency.currencyDescription.code
        }
        
        else if let exchangeRate = cont as? HFExchangeRate
        {
            formatter.minimumIntegerDigits = 1
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 6
            
            placeholder = exchangeRate.currencyDescription1.code + "/" + exchangeRate.currencyDescription2.code
        }
        
    }
    
    
    
    
    @objc func updateAmount()
    {
        
        let text = self.text ?? "0"
        
        let amountNumber = formatter.number(from: text) ?? NSNumber.init()
        
        let amountDecimal = amountNumber.decimalValue
        
        if let currency = cont as? HFCurrency
        {
            currency.amount = amountDecimal
        }
        else if let exchangeRate = cont as? HFExchangeRate
        {
            exchangeRate.rate = amountDecimal
        }
        
    }
    
    @objc func updateText()
    {
        var amountNumber:NSNumber
        
        if let currency = cont as? HFCurrency
        {
            amountNumber = currency.amount as NSNumber
        }
        else if let exchangeRate = cont as? HFExchangeRate
        {
            amountNumber = exchangeRate.rate as NSNumber
        }
        else
        {
            return
        }
        
        let amountText = formatter.string(from: amountNumber)
        if amountText == nil || amountText == ""
        {
            self.text = nil
        }
        else
        {
            if let currency = cont as? HFCurrency
            {
                text = amountText! + currency.currencyDescription.code
            }
            else if let exchangeRate = cont as? HFExchangeRate
            {
                text = amountText! + exchangeRate.currencyDescription1.code + "/" + exchangeRate.currencyDescription2.code
            }
        }
        
    }
    
    @objc func displayAmount()
    {
        
        var amountNumber:NSNumber
        
        if let currency = cont as? HFCurrency
        {
            amountNumber = currency.amount as NSNumber
        }
        else if let exchangeRate = cont as? HFExchangeRate
        {
            amountNumber = exchangeRate.rate as NSNumber
        }
        else
        {
            return
        }
        
        let amountText = formatter.string(from: amountNumber)
        if amountText == nil || amountText == ""
        {
            self.text = nil
        }
        else
        {
            self.text = amountText!
        }
    }
    
    func clear()
    {
        resignFirstResponder()
        if let currency = cont as? HFCurrency
        {
            currency.amount = 0
        }
        else if let exchangeRate = cont as? HFExchangeRate
        {
            exchangeRate.rate = 0
        }
        text = nil
    }
    
}
