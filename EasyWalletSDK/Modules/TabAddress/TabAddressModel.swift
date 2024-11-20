//
//  TabAddressModel.swift
//  Pods
//
//  Created by Tanawat Arthan on 2/11/2567 BE.
//

import Foundation

class TabAddressModel: BaseViewModel {

    @Published var countriesResponse: CountriesResponse?
    @Published var provincesResponse: ProvincesResponse?
    
    func doGetCountries() {
        callCountries() { [weak self] in
         guard self != nil else { return }
        }
    }
    
    func doGetProvinces() {
        callProvinces() { [weak self] in
         guard self != nil else { return }
        }
    }
    private func callCountries(completion: @escaping CompletionBlock) {
        self.showLoading(isShow: true)
        NetworkService.requestApi(.getCountries,
                                  request: nil,
                                  completion: {[weak self] (res: CountriesResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.countriesResponse = res
 
            completion()
        }) { [weak self] (error) in
            self?.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }
    
    private func callProvinces(completion: @escaping CompletionBlock) {
        self.showLoading(isShow: true)
        NetworkService.requestApi(.getProvinces,
                                  request: nil,
                                  completion: {[weak self] (res: ProvincesResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.provincesResponse = res

           
            completion()
        }) { [weak self] (error) in
            self?.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }
 
}
