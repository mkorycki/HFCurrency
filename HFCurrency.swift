//
//  HFCurrency.swift
//  HFCurrency
//
//  Created by Michał Korycki on 09.11.2017.
//  Copyright © 2017 Michał Korycki. All rights reserved.
//

import Foundation


let commonCurrencyFractionals:Dictionary<String,Int> = ["AED": 2,    "AFN": 2,    "AMD": 2,    "ANG": 2,    "AOA": 2,    "ARS": 2,    "AUD": 2,    "AWG": 2,    "AZN": 2,    "BAM": 2,
                                                        "BBD": 2,    "BDT": 2,    "BGN": 2,    "BHD": 3,    "BIF": 0,    "BMD": 2,    "BND": 2,    "BOB": 2,    "BRL": 2,    "BSD": 2,
                                                        "BWP": 2,    "BYR": 0,    "BZD": 2,    "CAD": 2,    "CDF": 2,    "CHF": 2,    "CLP": 0,    "CNY": 2,    "COP": 2,    "CRC": 2,
                                                        "CSK": 2,    "CVE": 2,    "CZK": 2,    "DJF": 0,    "DKK": 2,    "DOP": 2,    "DZD": 2,    "EGP": 2,    "ERN": 2,    "ETB": 2,
                                                        "EUR": 2,    "FJD": 2,    "FKP": 2,    "GBP": 2,    "GEL": 2,    "GHS": 2,    "GIP": 2,    "GMD": 2,    "GNF": 0,    "GTQ": 2,
                                                        "GYD": 2,    "HKD": 2,    "HNL": 2,    "HRK": 2,    "HTG": 2,    "HUF": 2,    "IDR": 2,    "ILS": 2,    "INR": 2,    "IQD": 3,
                                                        "ISK": 2,    "JMD": 2,    "JOD": 3,    "JPY": 0,    "KES": 2,    "KGS": 2,    "KHR": 2,    "KMF": 0,    "KRW": 0,    "KWD": 3,
                                                        "KYD": 2,    "KZT": 2,    "LAK": 2,    "LBP": 2,    "LKR": 2,    "LRD": 2,    "LTL": 2,    "LVL": 2,    "MAD": 2,    "MDL": 2,
                                                        "MGA": 0,    "MKD": 2,    "MMK": 2,    "MNT": 2,    "MOP": 2,    "MRO": 2,    "MUR": 2,    "MVR": 2,    "MWK": 2,    "MXN": 2,
                                                        "MYR": 2,    "MZN": 2,    "NAD": 2,    "NGN": 2,    "NIO": 2,    "NOK": 2,    "NPR": 2,    "NZD": 2,    "OMR": 3,    "PAB": 2,
                                                        "PEN": 2,    "PGK": 2,    "PHP": 2,    "PKR": 2,    "PLN": 2,    "PYG": 0,    "QAR": 2,    "RON": 2,    "RSD": 2,    "RUB": 2,
                                                        "RWF": 0,    "SAR": 2,    "SBD": 2,    "SCR": 2,    "SEK": 2,    "SGD": 2,    "SHP": 2,    "SLL": 2,    "SOS": 2,    "SRD": 2,
                                                        "STD": 2,    "SYP": 2,    "SZL": 2,    "THB": 2,    "TJS": 2,    "TND": 3,    "TOP": 2,    "TRY": 2,    "TTD": 2,    "TWD": 2,
                                                        "TZS": 2,    "UAH": 2,    "UGX": 2,    "USD": 2,    "UYU": 2,    "UZS": 2,    "VEF": 2,    "VND": 0,    "VUV": 0,    "WST": 2,
                                                        "XAF": 0,    "XCD": 2,    "XOF": 0,    "XPF": 0,    "YER": 2,    "ZAR": 2,    "ZMW": 2,    "ZWD": 2]




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
    
    
    init?(commonCode: String)
    {
        if let commonFrac = commonCurrencyFractionals[commonCode]
        {
            self.init(code: commonCode, fractional: commonFrac)
        }
        else
        {
            return nil
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
    
    
    convenience init?(commonCode: String)
    {
        if let commonFrac = commonCurrencyFractionals[commonCode]
        {
            self.init(code: commonCode, fractional: commonFrac)
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
