//
//  TabAddressViewController.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 11/11/2567 BE.
//


import UIKit
import MaterialComponents

class TabAddressViewController: BaseViewController, MDCTabBarViewDelegate {
 
    @IBOutlet weak var tabBarView: MDCTabBarView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var disableTabbarButton: UIButton!
    
    
    private var currentViewController: UIViewController?
    var router: TabAddressRouter!
    var viewModel: TabAddressModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: "Personal Information")
        router = TabAddressRouter(self)
        viewModel = TabAddressModel()
        setupUI()
        setAddressNotify()
        displayContentViewController(forTab: 0)
    
    }
    
    private func setAddressNotify() {
  
        NotificationCenter.default.addObserver(forName: Notification.Name(AddressType.homeAddress.rawValue), object: nil, queue: .main) { notification in
            if let addressEvent = notification.object as? AddressEvent {
                switch addressEvent {
                case .back:
                    break
                case .next:
                    self.displayContentViewController(forTab: 1)
                    break
                }
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(AddressType.mailing.rawValue), object: nil, queue: .main) { notification in
            if let addressEvent = notification.object as? AddressEvent {
                switch addressEvent {
                case .back:
                    self.displayContentViewController(forTab: 0)
                case .next:
                    self.displayContentViewController(forTab: 2)
                    break
                }
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(AddressType.workplace.rawValue), object: nil, queue: .main) { notification in
            if let addressEvent = notification.object as? AddressEvent {
                switch addressEvent {
                case .back:
                    self.displayContentViewController(forTab: 1)
                case .next:
                     // todo register
                    break
                }
            }
        }
    }
 
  
    private func setupUI() {
   
     let tab1 = UITabBarItem(title: "Address", image: nil, tag: 0)
     let tab2 = UITabBarItem(title: "Mailing Address", image: nil, tag: 1)
     let tab3 = UITabBarItem(title: "Workplace", image: nil, tag: 2)
        
        
  
     tabBarView.items = [tab1, tab2, tab3]
     tabBarView.autoresizingMask = [.flexibleLeftMargin]
     tabBarView.translatesAutoresizingMaskIntoConstraints = false
     tabBarView.bottomDividerColor = UIColor.lightGray.withAlphaComponent(0.4)
     tabBarView.setTitleColor(UIColor.init(colorName: .primary), for: .selected)
     tabBarView.setTitleColor(UIColor.lightGray, for: .normal)
     tabBarView.selectionIndicatorStrokeColor = UIColor.init(colorName: .primary)
     tabBarView.tabBarDelegate = self

     view.addSubview(tabBarView)

     NSLayoutConstraint.activate([
          tabBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          tabBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               
     ])

     view.addSubview(disableTabbarButton)
     tabBarView.setSelectedItem(tab1, animated: true)
        
    }
 
    func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
         displayContentViewController(forTab: item.tag)
    }
    
     private func displayContentViewController(forTab index: Int) {
   
         if let currentVC = currentViewController {
             currentVC.view.removeFromSuperview()
             currentVC.removeFromParent()
         }
     
             let newViewController: UIViewController
             switch index {
             case 0:
                 tabBarView.setSelectedItem(tabBarView.items[0], animated: true)
                 let storyboard = BaseConstants.getStoryboard(.homeAddress)
                 newViewController = storyboard.instantiateViewController(withIdentifier: "AddressViewController")
             case 1:
                 tabBarView.setSelectedItem(tabBarView.items[1], animated: true)
                 let storyboard = BaseConstants.getStoryboard(.mailing)
                 newViewController = storyboard.instantiateViewController(withIdentifier: "MailingViewController")
             case 2:
                 tabBarView.setSelectedItem(tabBarView.items[2], animated: true)
                 let storyboard = BaseConstants.getStoryboard(.workplace)
                 newViewController = storyboard.instantiateViewController(withIdentifier: "WorkplaceViewController")
             default:
                 return
             }
   
             addChild(newViewController)
             newViewController.view.frame = containerView.bounds
             containerView.addSubview(newViewController.view)
             newViewController.didMove(toParent: self)
             currentViewController = newViewController
         
     }
   
}
