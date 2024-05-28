//
//  MarketDataModel.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 28.05.2024.
//

import Foundation

// JSON Data:
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 14517,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1104,
     "total_market_cap": {
       "btc": 39649478.2458059,
       "eth": 701557014.36563,
       "ltc": 32433554573.7033,
       "bch": 5789974143.58549,
       "bnb": 4483143178.07007,
       "eos": 3328534628976.54,
       "xrp": 5087172624514.73,
       "xlm": 24925758194066.9,
       "link": 147859933064.577,
       "dot": 364965423323.165,
       "yfi": 371331091.290234,
       "usd": 2686328713818.84,
       "aed": 9866616732985.21,
       "ars": 2399618461990182,
       "aud": 4033648821248.55,
       "bdt": 314983603654043,
       "bhd": 1012493410210.61,
       "bmd": 2686328713818.84,
       "brl": 13849636316964.4,
       "cad": 3663077834163.37,
       "chf": 2447702134170.31,
       "clp": 2.41124865352379e+15,
       "cny": 19095767662181.2,
       "czk": 60947425859121.7,
       "dkk": 18431707204125.2,
       "eur": 2470380121172.37,
       "gbp": 2102610974935.72,
       "gel": 7279950814449.04,
       "hkd": 20983853798688.8,
       "huf": 948876947535594,
       "idr": 43247333110393976,
       "ils": 9879242477940.18,
       "inr": 223502817622599,
       "jpy": 421711634183403,
       "krw": 3.65548033243166e+15,
       "kwd": 824001783348.078,
       "lkr": 810517009569683,
       "mmk": 5636487745016884,
       "mxn": 44980941025038.5,
       "myr": 12609089716922.9,
       "ngn": 3912409111377023,
       "nok": 28168813343488.5,
       "nzd": 4367623952265.35,
       "php": 155970936825693,
       "pkr": 746954697908886,
       "pln": 10503553330017.8,
       "rub": 237938769358313,
       "sar": 10075556694017.4,
       "sek": 28320848803375.8,
       "sgd": 3620365207613.65,
       "thb": 98239041064355.1,
       "try": 86569629131526.1,
       "twd": 86484472511298,
       "uah": 108472129446808,
       "vef": 268982094114.68,
       "vnd": 68371822037934760,
       "zar": 49107391758034.5,
       "xdr": 2028097589071.81,
       "xag": 84031800669.0069,
       "xau": 1139433187.2534,
       "bits": 39649478245805.9,
       "sats": 3964947824580589
     },
     "total_volume": {
       "btc": 1431797.85138068,
       "eth": 25334200.353469,
       "ltc": 1171220803.04244,
       "bch": 209084025.947109,
       "bnb": 161892540.678557,
       "eos": 120198018760.031,
       "xrp": 183704884796.392,
       "xlm": 900103824949.438,
       "link": 5339428003.43274,
       "dot": 13179409466.6964,
       "yfi": 13409282.5979732,
       "usd": 97007069215.4671,
       "aed": 356297264521.488,
       "ars": 86653562922341.7,
       "aud": 145660673759.277,
       "bdt": 11374496383939.4,
       "bhd": 36562546429.7249,
       "bmd": 97007069215.4671,
       "brl": 500129646047.262,
       "cad": 132278839582.211,
       "chf": 88389931257.057,
       "clp": 87073545327803.2,
       "cny": 689574751518.148,
       "czk": 2200896386360.51,
       "dkk": 665594604008.083,
       "eur": 89208864935.3741,
       "gbp": 75928209131.4998,
       "gel": 262889157573.915,
       "hkd": 757756170116.238,
       "huf": 34265267408653.4,
       "idr": 1561721398741400,
       "ils": 356753197746.802,
       "inr": 8070997859433.78,
       "jpy": 15228594131371.8,
       "krw": 132004483218985,
       "kwd": 29755851404.0831,
       "lkr": 29268897452190.9,
       "mmk": 203541418442307,
       "mxn": 1624324393714.91,
       "myr": 455331781483.56,
       "ngn": 141282539070596,
       "nok": 1017215060715.63,
       "nzd": 157720980632.42,
       "php": 5632327639733.36,
       "pkr": 26973573899620.7,
       "pln": 379297931653.684,
       "rub": 8592300171400.93,
       "sar": 363842377357.999,
       "sek": 1022705272804.94,
       "sgd": 130736427181.685,
       "thb": 3547548521209.63,
       "try": 3126149812537.64,
       "twd": 3123074688443.51,
       "uah": 3917079587120.56,
       "vef": 9713317840.54471,
       "vnd": 2469001667109013,
       "zar": 1773336273687.3,
       "xdr": 73237427045.6012,
       "xag": 3034505294.1084,
       "xau": 41146518.4784325,
       "bits": 1431797851380.68,
       "sats": 143179785138068
     },
     "market_cap_percentage": {
       "btc": 49.6970045301526,
       "eth": 17.096558749821,
       "usdt": 4.16526164328497,
       "bnb": 3.42776347320707,
       "sol": 2.78513728510284,
       "steth": 1.3222369815866,
       "usdc": 1.20842364714933,
       "xrp": 1.08856904896375,
       "doge": 0.876890353940599,
       "ton": 0.832676155412088
     },
     "market_cap_change_percentage_24h_usd": -3.04135680525041,
     "updated_at": 1716915445
   }
 }
 */


struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "\(item.value)"
        }
        return ""
    }

    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "\(item.value)"
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentNumberString()
        }
        return ""
    }
}


