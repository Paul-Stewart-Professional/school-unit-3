//
//  AddToOrderDelegate.swift
//  Restaurant
//
//  Created by Paul Stewart on 12/20/23.
//  Copyright © 2023 Paul Stewart. All rights reserved.
//
//  Protocol for adding items to the order

protocol AddToOrderDelegate {
    /// Called when menu item is added
    func added(menuItem: MenuItem)
}
