//
//  ProductsPresenter.swift
//  VKart-MVP-Combine
//
//  Created by Vishal Kamble on 08/01/25.
//
import Foundation
import Combine

protocol ProductsViewProtocol : AnyObject{
    func showProducts(_ products: [Product])
    func showError(_ error: String)
    
}

class ProductsPresenter {
    private var apiService: APIServiceProtocol
        private weak var view: ProductsViewProtocol?
        private var cancellables = Set<AnyCancellable>()
    
    init(apiService: APIServiceProtocol, view: ProductsViewProtocol? = nil, cancellables: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.apiService = apiService
        self.view = view
        self.cancellables = cancellables
    }
    
    func fetchProducts(){
        print("Fetching products...")
        apiService.fetchData()
            .sink(receiveCompletion: {
                completion in
                switch completion{
                    case .finished:
                    print("Fetch successful.")
                case .failure(let error):
                    self.view?.showError(error.localizedDescription)
                    
                }
            }, receiveValue: { [weak self]
                products in
                self?.view?.showProducts(products)
            })
            .store(in: &cancellables)
    }
    
    
  
}
