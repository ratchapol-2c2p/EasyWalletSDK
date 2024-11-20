//
//  WorkplaceViewController.swift
//  Pods
//
//  Created by Tanawat Arthan on 2/11/2567 BE.
//

import UIKit

class WorkplaceViewController: BaseViewController {
    
    
    @IBOutlet weak var workplace: CustomTextField!
    
    @IBOutlet weak var workplaceAddressView: CustomTextField!

    @IBOutlet weak var countryView: CustomTextField!
    
    @IBOutlet weak var provincesView: CustomTextField!
 
    @IBOutlet weak var districtView: CustomTextField!
    
    @IBOutlet weak var subDistrictView: CustomTextField!
    
    @IBOutlet weak var stateView: CustomTextField!

    @IBOutlet weak var zipCodeView: CustomTextField!

    @IBOutlet weak var groupPlace: UIView!

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
  
    var router: MailingRouter!
    var viewModel: MailingModel!
    var countries : [Countries] = []
    var provinces : [Provinces] = []
    var districts : [Districts] = []
    var subDistricts : [SubDistricts] = []
    var isChecked: Bool = false
    
     override func viewDidLoad() {
         super.viewDidLoad()
     
         router = MailingRouter(self)
         viewModel = MailingModel()
         setupUI()
         bindViewModel()
         
     }
    
    private func bindViewModel() {
        self.countries = SessionHelper.shared.countries ?? []
        self.provinces = SessionHelper.shared.provinces ?? []
        
        viewModel.$districtsResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] districtsResponse in
                guard self != nil else {return}
                if let response = districtsResponse {
                    switch(response.responseCode) {
                        case "000":
                            self?.districts = response.districts ?? []
                        break
                        default :
                            AlertHelpers.showError(detail: response.responseDescription)
                        break
                    }
                   
                }
            }
            .store(in: &cancellables)
        
        viewModel.$subDistrictsResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] subDistrictsResponse in
                guard self != nil else {return}
                if let response = subDistrictsResponse {
                    switch(response.responseCode) {
                        case "000":
                        self?.subDistricts = response.subDistricts ?? []
                        break
                        default :
                            AlertHelpers.showError(detail: response.responseDescription)
                        break
                    }
                   
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
      
        
        workplaceAddressView.setTitleText("Workplace Address")
        workplaceAddressView.setPlaceholderText("Please enter Workplace Address")
        
        workplace.setTitleText("Workplace")
        workplace.setPlaceholderText("Please enter Workplace")
    
        countryView.setTitleText("Country")
        countryView.textField.text = "- Please select -"
        countryView.setPlaceholderText("Country")
        countryView.setTrailingImage(UIImage(imageNames: .arrowDownIcon)!,color: .black,width: 20,height: 20)
        
        provincesView.setTitleText("Province")
        provincesView.textField.text = "- Please select -"
        provincesView.setPlaceholderText("Province")
        provincesView.setTrailingImage(UIImage(imageNames: .arrowDownIcon)!,color: .black,width: 20,height: 20)
        
        districtView.setTitleText("District")
        districtView.textField.text = "- Please select -"
        districtView.setPlaceholderText("District")
        districtView.setTrailingImage(UIImage(imageNames: .arrowDownIcon)!,color: .black,width: 20,height: 20)
        
        subDistrictView.setTitleText("Sub Distric")
        subDistrictView.textField.text = "- Please select -"
        subDistrictView.setPlaceholderText("Sub Distric")
        subDistrictView.setTrailingImage(UIImage(imageNames: .arrowDownIcon)!,color: .black,width: 20,height: 20)
        
        stateView.setTitleText("State")
        stateView.setPlaceholderText("Please enter your state")
        stateView.isHidden = true
        
        zipCodeView.setTitleText("Zip Code")
        zipCodeView.setPlaceholderText("Zip Code")
        
     
        let backImage = UIImage(imageNames: .backIcon)
        let resizedBackImage = backImage?.resized(to: CGSize(width: 30, height: 24))
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        backButton.semanticContentAttribute = .forceLeftToRight
        backButton.setImage(resizedBackImage, for: .normal)
        
        let nextImage = UIImage(imageNames: .nextIcon)
        let resizedNextImage = nextImage?.resized(to: CGSize(width: 30, height: 24))
        nextButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16)
        nextButton.semanticContentAttribute = .forceRightToLeft
        nextButton.setImage(resizedNextImage, for: .normal)
        
      
    }
    
 
    @IBAction func onTouchCountryButton(_ sender: Any) {
        onShowCountries()
    }
    
    @IBAction func onTouchProvinceButton(_ sender: Any) {
        onShowProvinces()
    }
    
    @IBAction func onTouchDistrictButton(_ sender: Any) {
        onShowDistricts()
    }
  
    @IBAction func onTouchSubDistrictButton(_ sender: Any) {
        onShowSubDistricts()
    }
    
    @IBAction func onTouchNextButton(_ sender: Any) {
     
        NotificationCenter.default.post(
            name: Notification.Name(AddressType.workplace.rawValue),
            object: AddressEvent.next
        )

    }
 
    @IBAction func onTouchBackButton(_ sender: Any) {
        NotificationCenter.default.post(
            name: Notification.Name(AddressType.workplace.rawValue),
            object:  AddressEvent.back
        )
    }
    
    
    private func onShowCountries() {
        
          self.countries =  self.countries.sorted { $0.name! < $1.name! }
          let bottomSheetVC = BottomSheetOfCountryViewController(title: "Select Country")
              bottomSheetVC.items = self.countries
              bottomSheetVC.didSelectItem = { selectedItem in
                  print("Selected item: \(selectedItem)")
                  self.countryView.textField.text = selectedItem.name
                  let isThailand = selectedItem.name?.uppercased() == "THAILAND"
              
                  self.groupPlace.isHidden = isThailand ? false : true
                  self.stateView.isHidden = isThailand ? true : false
                  
              }
              bottomSheetVC.modalPresentationStyle = .custom
              bottomSheetVC.transitioningDelegate = self
              present(bottomSheetVC, animated: true, completion: nil)
    }
    private func onShowProvinces() {
        
        var bottomSheetModel = [BottomSheetModel]()
        for provinces in self.provinces{
            let model = BottomSheetModel(id: provinces.id ?? 0, titleName: provinces.name ?? "")
            bottomSheetModel.append(model)
        }
        bottomSheetModel = bottomSheetModel.sorted { $0.titleName! < $1.titleName! }
        let bottomSheetVC = BottomSheetViewController(title: "Select Provinces")
            bottomSheetVC.items = bottomSheetModel
            bottomSheetVC.didSelectItem = { selectedItem in
         
                self.provincesView.textField.text = selectedItem.titleName
                self.districtView.textField.text = "- Please select -"
                self.subDistrictView.textField.text = "- Please select -"
                let req = DistrictsRequest(provinceId: selectedItem.id ?? 0)
                self.viewModel.doGetDistricts(req: req)
            }
            bottomSheetVC.modalPresentationStyle = .custom
            bottomSheetVC.transitioningDelegate = self
            present(bottomSheetVC, animated: true, completion: nil)
    }
    
    private func onShowDistricts() {
        
        if(self.districts.count > 0){
            var bottomSheetModel = [BottomSheetModel]()
            for districts in self.districts{
                let model = BottomSheetModel(id: districts.id ?? 0, titleName: districts.name ?? "")
                bottomSheetModel.append(model)
            }
            bottomSheetModel = bottomSheetModel.sorted { $0.titleName! < $1.titleName! }
            let bottomSheetVC = BottomSheetViewController(title: "Select District")
                bottomSheetVC.items = bottomSheetModel
                bottomSheetVC.didSelectItem = { selectedItem in
                    self.districtView.textField.text = selectedItem.titleName
                    self.subDistrictView.textField.text = "- Please select -"
                    let req = SubDistrictsRequest(districtId: selectedItem.id ?? 0)
                    self.viewModel.doGetSubDistricts(req: req)
                }
                bottomSheetVC.modalPresentationStyle = .custom
                bottomSheetVC.transitioningDelegate = self
                present(bottomSheetVC, animated: true, completion: nil)
        }else{
            AlertHelpers.showError(detail: "Please select a province first")
        }
    }
    
    private func onShowSubDistricts() {
        
        if(self.subDistricts.count > 0){
            var bottomSheetModel = [BottomSheetModel]()
            for subDistricts in self.subDistricts{
                let model = BottomSheetModel(id: subDistricts.id ?? 0, titleName: subDistricts.name ?? "")
                bottomSheetModel.append(model)
            }
            bottomSheetModel = bottomSheetModel.sorted { $0.titleName! < $1.titleName! }
            let bottomSheetVC = BottomSheetViewController(title: "Select SubDistrict")
                bottomSheetVC.items = bottomSheetModel
                bottomSheetVC.didSelectItem = { selectedItem in
                    self.subDistrictView.textField.text = selectedItem.titleName
                }
                bottomSheetVC.modalPresentationStyle = .custom
                bottomSheetVC.transitioningDelegate = self
                present(bottomSheetVC, animated: true, completion: nil)
            
        }else{
            AlertHelpers.showError(detail: "Please select a district first")
        }
    }

}
extension WorkplaceViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
