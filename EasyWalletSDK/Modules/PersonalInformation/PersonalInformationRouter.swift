import Foundation

class PersonalInformationRouter: BaseRouter {

    private let viewController: UIViewController!
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func toTabAddressInfomationPage() {
        let storyboard = BaseConstants.getStoryboard(.tabAddress)
        if let vc = storyboard.instantiateViewController(withIdentifier: "TabAddressViewController") as? TabAddressViewController {
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
