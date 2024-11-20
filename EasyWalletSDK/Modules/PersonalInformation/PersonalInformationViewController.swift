import UIKit

class PersonalInformationViewController: BaseViewController{
    
    @IBOutlet weak var thaiFirstView: CustomTextField!
    @IBOutlet weak var thaiLastNameView: CustomTextField!
    @IBOutlet weak var englishFirstNameView: CustomTextField!
    @IBOutlet weak var englishLastNameView: CustomTextField!
    @IBOutlet weak var thaiIDView: CustomTextField!
    @IBOutlet weak var laserIDView: CustomTextField!
    @IBOutlet weak var nationalityView: CustomTextField!
    @IBOutlet weak var genderView: CustomTextField!
    @IBOutlet weak var dateOfBirthView: CustomTextField!
    @IBOutlet weak var emailView: CustomTextField!
    @IBOutlet weak var countryCodeView: CustomTextField!
    @IBOutlet weak var mobileNumberView: CustomTextField!
    @IBOutlet weak var occupationView: CustomTextField!
    @IBOutlet weak var businessTypeView: CustomTextField!
    @IBOutlet weak var walletPurposeView: CustomTextField!
    @IBOutlet weak var walletPurposeDescriptionView: CustomTextField!
    
    var router: PersonalInformationRouter!
    var viewModel: PersonalInformationModel!
    var occupations: [Occupation] = []
    var businessTypes: [BusinessType] = []
    var walletPurposes: [WalletPurpose] = []
    var zolozIdInfo : IdInfo?
    var isThai: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        router = PersonalInformationRouter(self)
        viewModel = PersonalInformationModel()
        bindViewModel()
        viewModel.doGetCountries()
        viewModel.doGetProvinces()
        viewModel.doGetWalletPurposes()
        viewModel.doGetOccupations()
        viewModel.doGetBusinessTypes()
        viewModel.doGetWalletPurposes()
        
        setupUI()
    }
    
    private func bindViewModel() {
        zolozIdInfo = SessionHelper.shared.zolozIdInfo
        isThai = SessionHelper.shared.isThai ?? true
        
        viewModel.$countriesResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] responseData in
                guard self != nil else {return}
                if let response = responseData {
                    SessionHelper.shared.countries = response.countries ?? []
                    print("=========>countries  = \(String(describing: response.countries!.count))")
                }
            }
            .store(in: &cancellables)
        viewModel.$provincesResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] responseData in
                guard self != nil else {return}
                if let response = responseData {
                    SessionHelper.shared.provinces = response.provinces ?? []
                    print("=========>provinces  = \(String(describing: response.provinces!.count))")
                }
            }
            .store(in: &cancellables)

        viewModel.$occupationResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] responseData in
                guard self != nil else {return}
                if let response = responseData {
                    self?.occupations = response.occupations ?? []
                    
                    print("=========>zolozCheckResult  = \(String(describing: self?.occupations.count))")
                }
            }
            .store(in: &cancellables)
        
        viewModel.$businessTypeResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] responseData in
                guard self != nil else {return}
                if let response = responseData {
                  
                    self?.businessTypes = response.businessTypes ?? []
                    print("=========>zolozCheckResult  = \(String(describing: self?.businessTypes.count))")
                }
            }
            .store(in: &cancellables)
        viewModel.$walletPurposesResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] responseData in
                guard self != nil else {return}
                if let response = responseData {
                    self?.walletPurposes = response.walletPurposes ?? []
                    print("=========>zolozCheckResult  = \(String(describing: self?.walletPurposes.count))")
                   
                }
            }
            .store(in: &cancellables)
        
        
        
    }
    
   
    private func setupUI() {
        self.configureNavigationBar(title: "Personal Information")
    
        thaiFirstView.isHidden = isThai ? false: true
        thaiLastNameView.isHidden = isThai ? false: true
        englishLastNameView.isHidden = ((zolozIdInfo?.ocrResult?.ELAST_NAME?.isEmpty) != nil) ? false: true
        laserIDView.isHidden = isThai ? false: true
        walletPurposeDescriptionView.isHidden = true
        
        thaiFirstView.setTitleText("Thai FirstName")
        thaiFirstView.setPlaceholderText("Thai FirstName")
        thaiFirstView.textField.text = zolozIdInfo?.ocrResult?.FIRST_NAME
      
       // thaiFirstView.setErrorMessage(text: "Thai FirstName is required")
        
        thaiLastNameView.setTitleText("Thai Last Name")
        thaiLastNameView.setPlaceholderText("Thai Last Name")
        thaiLastNameView.textField.text = zolozIdInfo?.ocrResult?.LAST_NAME
       // thaiLastNameView.setErrorMessage(text: "Thai LastName is required")
        
        englishFirstNameView.setTitleText("English First Name")
        englishFirstNameView.setPlaceholderText("English First Name")
        englishFirstNameView.textField.text = isThai ? zolozIdInfo?.ocrResult?.EFIRST_NAME :zolozIdInfo?.ocrResult?.FIRST_NAME
       // englishFirstNameView.setErrorMessage(text: "English First is required")
        
        englishLastNameView.setTitleText("English Last Name")
        englishLastNameView.setPlaceholderText("English Last Name")
        englishLastNameView.textField.text = isThai ? zolozIdInfo?.ocrResult?.ELAST_NAME :zolozIdInfo?.ocrResult?.LAST_NAME
       // englishLastNameView.setErrorMessage(text: "English Last is required")
        
        thaiIDView.setTitleText(isThai ? "Thai ID": "Passport No")
        thaiIDView.setPlaceholderText(isThai ? "Thai ID": "Passport No")
        thaiIDView.textField.text = zolozIdInfo?.ocrResult?.ID_NUMBER
       // thaiIDView.setErrorMessage(text: "Thai ID is required")
        
        laserIDView.setTitleText("Laser ID")
        laserIDView.setPlaceholderText("Laser ID")
        laserIDView.textField.text = zolozIdInfo?.ocrResult?.LASER_NUMBER
       // laserIDView.setErrorMessage(text: "Laser ID is required")
        
        
        nationalityView.textField.isEnabled = false
        nationalityView.setTitleText("Nationality")
        nationalityView.setPlaceholderText("Nationality")
        nationalityView.setTextColor(.gray, state: .normal)
        nationalityView.textField.text =  isThai ? "Thailand" : zolozIdInfo?.ocrResult?.COUNTRY
        
       // nationalityView.setErrorMessage(text: "Nationality is required")
        genderView.textField.isEnabled = false
        genderView.setTextColor(.black, state: .normal)
        genderView.setTitleText("Gender")
        genderView.setPlaceholderText("Gender")
        genderView.setTrailingImage(UIImage(imageNames: .arrowDownIcon)!,color: .black,width: 20,height: 20)
        genderView.textField.text = zolozIdInfo?.ocrResult?.SEX == nil ? "- Please select -" : zolozIdInfo?.ocrResult?.SEX == "M" ? "Male" : "Female"
       // genderView.setErrorMessage(text: "Gender is required")
        
        dateOfBirthView.setTitleText("Date Of Birth")
        dateOfBirthView.setPlaceholderText("YY/MM/DD")
        dateOfBirthView.setTrailingImage(UIImage(imageNames: .dateIcon)!,color: .black)
        dateOfBirthView.textField.text = zolozIdInfo?.ocrResult?.DATE_OF_BIRTH
       // dateOfBirthView.setErrorMessage(text: "Date Of Birth is required")
        
        emailView.textField.isEnabled = false
        emailView.setTitleText("Email")
        emailView.setPlaceholderText("Email Address")
        emailView.setTextColor(.gray, state: .normal)
        emailView.textField.text = SessionHelper.shared.email ?? ""
       // emailView.setErrorMessage(text: "Email Address is required")
        
        countryCodeView.setTitleText("Country Code")
        countryCodeView.setPlaceholderText("Country Code")
        countryCodeView.textField.text =  isThai ? "+66" : ""
       // countryCodeView.setErrorMessage(text: "Country Code is required")
        
        mobileNumberView.setTitleText("Mobile Number")
        mobileNumberView.setPlaceholderText("Mobile Number")
       // mobileNumberView.setErrorMessage(text: "Mobile Number is required")
        
        occupationView.setTitleText("Occupation")
        occupationView.textField.text = "- Please select -"
        occupationView.setPlaceholderText("Occupation")
        occupationView.setTrailingImage(UIImage(imageNames: .arrowDownIcon)!,color: .black,width: 20,height: 20)
        
        businessTypeView.setTitleText("Business Type")
        businessTypeView.textField.text = "- Please select -"
        businessTypeView.setPlaceholderText("Business Type")
        businessTypeView.setTrailingImage(UIImage(imageNames: .arrowDownIcon)!,color: .black,width: 20,height: 20)
        
        walletPurposeView.setTitleText("Wallet Purpose")
        walletPurposeView.textField.text = "- Please select -"
        walletPurposeView.setPlaceholderText("Wallet Purpose")
        walletPurposeView.setTrailingImage(UIImage(imageNames: .arrowDownIcon)!,color: .black,width: 20,height: 20)
        
        walletPurposeDescriptionView.setTitleText("Wallet Purpose Description")
        walletPurposeDescriptionView.setPlaceholderText("Wallet Purpose Description")
        
        
    }
    
    
    @IBAction func onTouchAcceptButton(_ sender: Any) {
        router?.toTabAddressInfomationPage()
    }
    
    
    @IBAction func onTouchGenderButton(_ sender: Any) {
        let genders = [
            BottomSheetModel(id: 1, titleName: "Male"),
            BottomSheetModel(id: 2, titleName: "FeMale"),
        ]
      
        let bottomSheetVC = BottomSheetViewController(title: "Select Gender")
            bottomSheetVC.items = genders
            bottomSheetVC.didSelectItem = { selectedItem in
                print("Selected item: \(selectedItem)")
                self.genderView.textField.text = selectedItem.titleName
            }
            bottomSheetVC.modalPresentationStyle = .custom
            bottomSheetVC.transitioningDelegate = self
            present(bottomSheetVC, animated: true, completion: nil)
        
    }
    
    @IBAction func onTouchDatePickerButton(_ sender: Any) {
      
        let currentDate  = Date()
        let minimumDate = Calendar.current.date(byAdding: .year, value: -70, to: Date())
        let datePickerDialog = DatePickerDialogCustom()
        datePickerDialog.show("Select Date of Birth",
            doneButtonTitle: "Done",
            cancelButtonTitle: "Cancel",
            minimumDate: minimumDate,
            maximumDate: currentDate,
            datePickerMode: .date
        ) { selectedDate in
            if let date = selectedDate {
              
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY/MM/dd"
                formatter.timeZone = TimeZone.current
                
                print("Selected Date2: \(formatter.string(from: date))")
                self.dateOfBirthView.textField.text = formatter.string(from: date)
            } else {
                print("No date selected.")
            }
        }
    }
    
    @IBAction func onTouchOccupationButton(_ sender: Any) {
        var occupationsList = [BottomSheetModel]()
        for occupation in self.occupations {
            let model = BottomSheetModel(id: occupation.id ?? 0, titleName: occupation.name ?? "")
            occupationsList.append(model)
        }
            
        let bottomSheetVC = BottomSheetViewController(title: "Select Occupation")
            bottomSheetVC.items = occupationsList
            bottomSheetVC.didSelectItem = { selectedItem in
                print("Selected item: \(selectedItem)")
                self.occupationView.textField.text = selectedItem.titleName
            }
            bottomSheetVC.modalPresentationStyle = .custom
            bottomSheetVC.transitioningDelegate = self
            present(bottomSheetVC, animated: true, completion: nil)
        
    }
    
    @IBAction func onTouchBusinessTypeButton(_ sender: Any) {
        var businessTypesList = [BottomSheetModel]()
        for businessType in self.businessTypes {
            let model = BottomSheetModel(id: businessType.businessTypeId ?? 0, titleName: businessType.businessTypeEN ?? "")
            businessTypesList.append(model)
        }
            
        let bottomSheetVC = BottomSheetViewController(title: "Select BusinessType")
            bottomSheetVC.items = businessTypesList
            bottomSheetVC.didSelectItem = { selectedItem in
                print("Selected item: \(selectedItem)")
                self.businessTypeView.textField.text = selectedItem.titleName
            }
            bottomSheetVC.modalPresentationStyle = .custom
            bottomSheetVC.transitioningDelegate = self
            present(bottomSheetVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func onTouchWalletPurposeButton(_ sender: Any) {
        var walletPurposesList = [BottomSheetModel]()
        for walletPurposes in self.walletPurposes {
            let model = BottomSheetModel(id: walletPurposes.purposeId ?? 0, titleName: walletPurposes.purposeEN ?? "")
            walletPurposesList.append(model)
        }
            
        let bottomSheetVC = BottomSheetViewController(title: "Select WalletPurpose")
            bottomSheetVC.items = walletPurposesList
            bottomSheetVC.didSelectItem = { selectedItem in
                print("Selected item: \(selectedItem)")
                self.walletPurposeView.textField.text = selectedItem.titleName
                self.walletPurposeDescriptionView.isHidden = selectedItem.titleName?.uppercased() == "OTHERS" ? false : true
            }
            bottomSheetVC.modalPresentationStyle = .custom
            bottomSheetVC.transitioningDelegate = self
            present(bottomSheetVC, animated: true, completion: nil)
        
    }
    
}

extension PersonalInformationViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
