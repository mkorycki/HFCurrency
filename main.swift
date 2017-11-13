//
//  main.swift
//  HFCurrency
//
//  Created by Michał Korycki on 09.11.2017.
//  Copyright © 2017 Michał Korycki. All rights reserved.
//

import Foundation



var dollars = HFCurrency.init(code: "USD")
dollars!.amount = 29.7777

var euros = HFCurrency.init(code: "EUR")!
euros.amount = 33.559

var invalid = HFCurrency.init(code: "", fractional: 2)
invalid?.amount = 43.45


print(dollars ?? "dollars = nil")
print(euros)
print(invalid ?? "invalid = nil")

var newEuros = HFCurrency.init(code: "EUR")!
newEuros.amount = 300.0

var newDollars = HFCurrency.init(code: "USD")!
newDollars.amount = 300.0

if euros.isSameCurrency(newEuros)
{
    print("euros and newEuros are the same currency")
}

if !euros.isSameCurrency(newDollars)
{
    print("euros and newDollars are not the same currency")
}


if euros.add(currency: newEuros)
{
    print("euros is now", euros)
}

if euros.subtract(currency: newEuros)
{
    print("and now euros is now", euros)
}


if let newerEuros = euros.adding(currency: newEuros)
{
    print("newerEuros is now", newerEuros)
}



if let ridiculous = euros.adding(currency: newDollars)
{
    print("this should not happen", ridiculous)
}


var johnsMoney = HFCurrency.init(code: "USD")!
johnsMoney.amount = 100
print(johnsMoney)

var dollarsToEuros = HFExchangeRate.init(currencyDescription1: HFCurrencyDescription.init(code: "EUR")!, currencyDescription2: HFCurrencyDescription.init(code: "USD")!)!
dollarsToEuros.rate = 0.7

_ = johnsMoney.exchange(using: dollarsToEuros)

print(johnsMoney)

_ = johnsMoney.exchange(using: dollarsToEuros)

print(johnsMoney)

let johnsExchangedMoney = johnsMoney.exchangined(using: dollarsToEuros)!

print(johnsExchangedMoney)
