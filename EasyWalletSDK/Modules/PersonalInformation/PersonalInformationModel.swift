import Foundation

class PersonalInformationModel: BaseViewModel {
    
    @Published var occupationResponse: OccupationResponse?
    @Published var businessTypeResponse: BusinessTypeResponse?
    @Published var walletPurposesResponse: WalletPurposeResponse?
    @Published var countriesResponse: CountriesResponse?
    @Published var provincesResponse: ProvincesResponse?
    
    
    func doGetOccupations() {
        callOccupations() { [weak self] in
            guard self != nil else { return }
        }
    }
       
    func doGetBusinessTypes() {
        callBusinessTypes() { [weak self] in
            guard self != nil else { return }
        }
    }
       
    
    func doGetWalletPurposes() {
        callWalletPurposes() { [weak self] in
         guard self != nil else { return }
        }
    }
    
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
    
    private func callOccupations(completion: @escaping CompletionBlock) {
        self.showLoading(isShow: true)
        NetworkService.requestApi(.getOccupations,
                                  request: nil,
                                  completion: {[weak self] (res: OccupationResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.occupationResponse = res
           
            completion()
        }) { [weak self] (error) in
            self?.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }
    private func callBusinessTypes(completion: @escaping CompletionBlock) {
        self.showLoading(isShow: true)
        NetworkService.requestApi(.getBusinesstypes,
                                  request: nil,
                                  completion: {[weak self] (res: BusinessTypeResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.businessTypeResponse = res
           
            completion()
        }) { [weak self] (error) in
            self?.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }
    private func callWalletPurposes(completion: @escaping CompletionBlock) {
        self.showLoading(isShow: true)
        NetworkService.requestApi(.getWalletpurposes,
                                  request: nil,
                                  completion: {[weak self] (res: WalletPurposeResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.walletPurposesResponse = res
           
            completion()
        }) { [weak self] (error) in
            self?.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
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
