//
//  ParcelInformation.swift
//  ParcelInvoiceMaker
//
//  Created by Kant on 1/24/24.
//

import Foundation

struct ParcelInformation {
    let receiver: Receiver
    let charge: Charge
    
    init(receiver: Receiver, charge: Charge) {
        self.receiver = receiver
        self.charge = charge
    }
}

struct Receiver {
    let address: String
    var receiverName: String
    var receiverMobile: String
    
    init(address: String, receiverName: String, receiverMobile: String) {
        self.address = address
        self.receiverName = receiverName
        self.receiverMobile = receiverMobile
    }
}

struct Charge {
    let deliveryCost: Int
    private let discount: Discount
    private var discountStrategyProvider: DiscountStrategyProvider
    
    init(deliveryCost: Int, discount: Discount) {
        self.deliveryCost = deliveryCost
        self.discount = discount
        self.discountStrategyProvider = DiscountStrategyProvider()
        discountStrategyProvider.register(strategy: NoDiscount())
        discountStrategyProvider.register(strategy: VIPDiscount())
        discountStrategyProvider.register(strategy: CouponDiscount())
    }
    
    private func caculateDiscountCost() -> Int {
        let strategy = discountStrategyProvider.strategy(for: discount)
        return strategy.applyDiscount(deliveryCost: deliveryCost)
    }
    
    var discountedCost: Int {
        return caculateDiscountCost()
    }
}

struct ParcelInputData {
    var name: String
    var mobile: String
    var address: String
    var cost: Int
    var discount: Discount
}
