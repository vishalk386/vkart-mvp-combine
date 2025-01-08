//
//  ViewController.swift
//  VKart-MVP-Combine
//
//  Created by Vishal Kamble on 08/01/25.
//

import UIKit
import Combine

class ViewController: UIViewController, ProductsViewProtocol {

    private var presenter: ProductsPresenter?
    private var products: [Product] = []
    private var cancellables = Set<AnyCancellable>()
    
    // Make tableView an instance property
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .brown
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the API service and presenter
        let apiService = APIService()
        presenter = ProductsPresenter(apiService: apiService, view: self)
        
        // Set up the table view
        setupTableView()
        
        // Fetch products
        presenter?.fetchProducts()
    }

    // MARK: - Setup TableView
    private func setupTableView() {
        // Add tableView to the view hierarchy
        view.addSubview(tableView)
        
        // Set up constraints after adding tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Set up dataSource and delegate
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - ProductsViewProtocol Methods
    func showProducts(_ products: [Product]) {
        print("Products received: \(products.count)")  
        self.products = products
        tableView.reloadData()
    }
    
    func showError(_ error: String) {
        print("Products error: \(error)")
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let product = products[indexPath.row]
        cell.textLabel?.text = product.title
        return cell
    }
}

