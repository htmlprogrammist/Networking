//
//  Quote.swift
//  Networking
//
//  Created by Егор Бадмаев on 15.07.2022.
//

import Foundation

struct Quote: Codable {
    let avgTotalVolume: Double?
    let calculationPrice: String?
    let change, changePercent, close: Double?
    let closeSource: String?
    let closeTime: Double?
    let companyName, currency: String?
    let delayedPrice: Double?
    let delayedPriceTime: Double?
    let extendedChange, extendedChangePercent, extendedPrice: Double?
    let extendedPriceTime: Double?
    let high: Double?
    let highSource: String?
    let highTime: Double?
    let iexAskPrice, iexAskSize, iexBidPrice: Double?
    let iexBidSize: Double? // !!!
    let iexClose: Double?
    let iexCloseTime, iexLastUpdated: Double?
    let iexMarketPercent, iexOpen: Double?
    let iexOpenTime: Double?
    let iexRealtimePrice: Double?
    let iexRealtimeSize, iexVolume, lastTradeTime: Double?
    let latestPrice: Double?
    let latestSource, latestTime: String?
    let latestUpdate, latestVolume: Double?
    let low: Double?
    let lowSource: String?
    let lowTime, marketCap: Double?
    let oddLotDelayedPrice: Double?
    let oddLotDelayedPriceTime: Double?
    let welcomeOpen: Double?
    let openTime: Double?
    let openSource: String?
    let peRatio, previousClose: Double?
    let previousVolume: Double?
    let primaryExchange, symbol: String?
    let volume: Double?
    let week52High, week52Low, ytdChange: Double?
    let isUSMarketOpen: Bool?

    enum CodingKeys: String, CodingKey {
        case avgTotalVolume, calculationPrice, change, changePercent, close, closeSource, closeTime, companyName, currency, delayedPrice, delayedPriceTime, extendedChange, extendedChangePercent, extendedPrice, extendedPriceTime, high, highSource, highTime, iexAskPrice, iexAskSize, iexBidPrice, iexBidSize, iexClose, iexCloseTime, iexLastUpdated, iexMarketPercent, iexOpen, iexOpenTime, iexRealtimePrice, iexRealtimeSize, iexVolume, lastTradeTime, latestPrice, latestSource, latestTime, latestUpdate, latestVolume, low, lowSource, lowTime, marketCap, oddLotDelayedPrice, oddLotDelayedPriceTime
        case welcomeOpen = "open"
        case openTime, openSource, peRatio, previousClose, previousVolume, primaryExchange, symbol, volume, week52High, week52Low, ytdChange, isUSMarketOpen
    }
}

struct ImageURL: Codable {
    let url: String
}
