//
//  HFCurrency.swift
//  HFCurrency
//
//  Created by Michał Korycki on 09.11.2017.
//  Copyright © 2017 Michał Korycki. All rights reserved.
//

import Foundation


struct HFCurrencyDescription:Equatable
{
    let code:String!
    let frac:Int!
    
    init?(code: String, fractional:Int = 2)
    {
        
        if code.count == 0
        {
            return nil
        }
        else
        {
            self.code = code
        }
        
        if fractional < 0
        {
            frac = 0
        }
        else
        {
            frac = fractional
        }
        
    }
    
    
    static func ==(lhs: HFCurrencyDescription, rhs: HFCurrencyDescription) -> Bool
    {
        if lhs.code == rhs.code && lhs.frac == rhs.frac
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
}







class HFCurrency:CustomStringConvertible
{
    
    private var amnt:Decimal!
    
    private var desc:HFCurrencyDescription!
    
    var amount:Decimal
    {
        get
        {
            return amnt
        }
        set
        {
            var tmpAmnt = Decimal()
            var tmpNewValue = newValue
            NSDecimalRound(&tmpAmnt, &tmpNewValue, desc.frac, .bankers)
            amnt = tmpAmnt
        }
    }
    
    
    var currencyDescription:HFCurrencyDescription
    {
        get {return desc}
    }
    
    
    
    var description: String
    {
        return amnt.description + " " + desc.code
    }
    
    
    
    init?(code: String, fractional:Int = 2)
    {
        
        if let currencyDescription = HFCurrencyDescription.init(code: code, fractional: fractional)
        {
            desc = currencyDescription
            amnt = 0
        }
        else
        {
            return nil
        }
        
    }
    
    
    init(currencyDescription:HFCurrencyDescription)
    {
        desc = currencyDescription
        amnt = 0
    }
    
    
    func isSameCurrency(_ currency:HFCurrency) -> Bool
    {
        return (self.desc==currency.desc)
    }
    
    
    func add(currency:HFCurrency) -> Bool
    {
        if self.desc == currency.desc
        {
            self.amount += currency.amnt
            
            return true
        }
        else
        {
            return false
        }
    }
    
    
    func subtract(currency:HFCurrency) -> Bool
    {
        if self.desc == currency.desc
        {
            self.amount -= currency.amnt
            
            return true
        }
        else
        {
            return false
        }
    }
    
    
    func adding(currency:HFCurrency) -> HFCurrency?
    {
        if self.desc == currency.desc
        {
            let newCurrency = HFCurrency.init(currencyDescription: currency.desc)
            newCurrency.amount = self.amnt + currency.amnt
            return newCurrency
        }
        else
        {
            return nil
        }
    }
    
    
    func subtracting(currency:HFCurrency) -> HFCurrency?
    {
        if self.desc == currency.desc
        {
            let newCurrency = HFCurrency.init(currencyDescription: currency.desc)
            newCurrency.amount = self.amnt - currency.amnt
            return newCurrency
        }
        else
        {
            return nil
        }
    }
    
    
    
    func exchange(using exchangeRate:HFExchangeRate) -> Bool
    {
        if desc==exchangeRate.currencyDescription1
        {
            desc = exchangeRate.currencyDescription2
            amount /= exchangeRate.rate
            return true
        }
        else if desc==exchangeRate.currencyDescription2
        {
            desc = exchangeRate.currencyDescription1
            amount *= exchangeRate.rate
            return true
        }
        else
        {
            return false
        }
    }
    
    
    func exchangined(using exchangeRate:HFExchangeRate) -> HFCurrency?
    {
        if desc==exchangeRate.currencyDescription1
        {
            let newCurrency = HFCurrency.init(currencyDescription: exchangeRate.currencyDescription2)
            newCurrency.amount = amount / exchangeRate.rate
            return newCurrency
        }
        else if desc==exchangeRate.currencyDescription2
        {
            let newCurrency = HFCurrency.init(currencyDescription: exchangeRate.currencyDescription1)
            newCurrency.amount = amount * exchangeRate.rate
            return newCurrency
        }
        else
        {
            return nil
        }
    }
    
    
}






class HFExchangeRate
{
    
    var rate:Decimal!
    
    private var currDesc1:HFCurrencyDescription!
    private var currDesc2:HFCurrencyDescription!
    
    
    var currencyDescription1:HFCurrencyDescription
    {
        get {return currDesc1}
    }
    
    
    var currencyDescription2:HFCurrencyDescription
    {
        get {return currDesc2}
    }
    
    
    init?(currencyDescription1: HFCurrencyDescription, currencyDescription2: HFCurrencyDescription)
    {
        if !(currencyDescription1==currencyDescription2)
        {
            currDesc1 = currencyDescription1
            currDesc2 = currencyDescription2
            rate = 1
        }
        else
        {
            return nil
        }
    }
    
    
    init?(currency1: HFCurrency, currency2: HFCurrency)
    {
        if !(currencyDescription1==currencyDescription2)
        {
            currDesc1 = currency1.currencyDescription
            currDesc2 = currency2.currencyDescription
            rate = currency1.amount/currency2.amount
        }
        else
        {
            return nil
        }
    }
    
}
