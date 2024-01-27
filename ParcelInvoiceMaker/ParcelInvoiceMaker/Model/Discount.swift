//
//  Discount.swift
//  ParcelInvoiceMaker
//
//  Created by Kant on 1/24/24.
//

import Foundation

protocol DiscountStrategy {
    func applyDiscount(deliveryCost: Int) -> Int
    func canAccept(method: Discount) -> Bool
}

struct NoDiscount: DiscountStrategy {
    func applyDiscount(deliveryCost: Int) -> Int { return deliveryCost }
    func canAccept(method: Discount) -> Bool {
        return method == .none
    }
}

struct VIPDiscount: DiscountStrategy {
    func applyDiscount(deliveryCost: Int) -> Int { return (deliveryCost / 5) * 4 }
    func canAccept(method: Discount) -> Bool {
        return method == .vip
    }
}

struct CouponDiscount: DiscountStrategy {
    func applyDiscount(deliveryCost: Int) -> Int { return deliveryCost / 2}
    func canAccept(method: Discount) -> Bool {
        return method == .coupon
    }
}

enum Discount: Int {
    case none = 0, vip, coupon
}

struct DiscountStrategyProvider {
    private var strategies: [DiscountStrategy] = []

    mutating func register(strategy: DiscountStrategy) {
        strategies.append(strategy)
    }

    func strategy(for discount: Discount) -> DiscountStrategy {
        return strategies.first { $0.canAccept(method: discount) } ?? NoDiscount()
    }
}
