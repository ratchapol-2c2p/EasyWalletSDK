//
//  AddressModel.swift
//  Pods
//
//  Created by Tanawat Arthan on 2/11/2567 BE.
//

import Foundation

class AddressModel: BaseViewModel {
    
    @Published var districtsResponse: DistrictsResponse?
    @Published var subDistrictsResponse: SubDistrictsResponse?
    
    func doGetDistricts(req: DistrictsRequest) {
        callDistricts(request: req) { [weak self] in
            guard self != nil else { return }
        }
    }
    func doGetSubDistricts(req: SubDistrictsRequest) {
        callSubDistricts(request: req) { [weak self] in
            guard self != nil else { return }
        }
    }
  
  
    private func callDistricts(request: DistrictsRequest, completion: @escaping CompletionBlock) {
        self.showLoading(isShow: true)
        NetworkService.requestApi(.getDistricts,
                                  request: request,
                                  completion: {[weak self] (res: DistrictsResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.districtsResponse = res
           
            completion()
        }) { [weak self] (error) in
            self?.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }
    
      private func callSubDistricts(request: SubDistrictsRequest, completion: @escaping CompletionBlock) {
          self.showLoading(isShow: true)
          NetworkService.requestApi(.getSubDistricts,
                                    request: request,
                                    completion: {[weak self] (res: SubDistrictsResponse) in
              guard let self = self else { return }
              self.showLoading(isShow: false)
              self.subDistrictsResponse = res
             
              completion()
          }) { [weak self] (error) in
              self?.showLoading(isShow: false)
              AlertHelpers.showError(detail: error.localizedDescription)
          }
      }
    
   
}
