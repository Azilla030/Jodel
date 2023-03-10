//
//  TabBarController.swift
//  JodelChallenge
//
//  Created by Alexander Ruder on 10.03.23.
//  Copyright © 2023 Jodel. All rights reserved.
//

import Foundation


class TabBarController: UITableViewController {
    
    var currentPage = 0
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPage(page: 0)
    }
    
    func loadPage(page: Int) {
        if isLoading {
            return
        }
        
        isLoading = true
        showLoadingOverlay()
        
        // Laden der Daten für die aktuelle Seite
        // ...
        
        currentPage = page
        tableView.reloadData()
        isLoading = false
        hideLoadingOverlay()
    }
    
    @IBAction func loadNextPage() {
        loadPage(page: currentPage + 1)
    }
    
    @IBAction func loadPreviousPage() {
        loadPage(page: currentPage - 1)
    }
    
    func showLoadingOverlay() {
        // Einblenden des Lade-Overlays
        // ...
    }
    
    func hideLoadingOverlay() {
        // Ausblenden des Lade-Overlays
        // ...
    }
}
