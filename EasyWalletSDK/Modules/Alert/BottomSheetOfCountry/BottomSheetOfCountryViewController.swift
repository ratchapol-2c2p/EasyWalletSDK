//
//  BottomSheetOfCountryViewController.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 1/11/2567 BE.
//
import UIKit

class BottomSheetOfCountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.returnKeyType = .done
        let placeholderText = "Search Country"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
           searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        if let iconView = searchBar.searchTextField.leftView as? UIImageView {
            iconView.tintColor = UIColor.lightGray
        }
           
        return searchBar
    }()
    
    private let tableView = UITableView()
    var items: [Countries] = []
    var filteredItems: [Countries] = []
    var didSelectItem: ((Countries) -> Void)?
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        filteredItems = items
        searchBar.delegate = self
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder()  // ซ่อนคีย์บอร์ดเมื่อกด Done
   }
   
    private func setupUI() {
        view.backgroundColor = UIColor.init(colorName: .primary)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = .white
        searchBar.backgroundColor = .white
        searchBar.searchTextField.backgroundColor = UIColor.init(colorName: .lightGray100)
      
        let textField = searchBar.searchTextField
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredItems[indexPath.row].name
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black

        if cell.contentView.viewWithTag(1) == nil {
            let separator = UIView()
            separator.backgroundColor = .lightGray
            separator.translatesAutoresizingMaskIntoConstraints = false
            separator.tag = 1
            cell.contentView.addSubview(separator)

            NSLayoutConstraint.activate([
                separator.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
                separator.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
                separator.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                separator.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        }
        let country = filteredItems[indexPath.row]
        let searchText = searchBar.text ?? ""
        if let name = country.name {
            cell.textLabel?.attributedText = getHighlightedText(for: name, searchText: searchText)
        } else {
            cell.textLabel?.text = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = filteredItems[indexPath.row]
        didSelectItem?(selectedItem)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredItems = items
        } else {
            filteredItems = items.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false}
        }
        tableView.reloadData()
    }
    private func getHighlightedText(for text: String, searchText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text.lowercased() as NSString).range(of: searchText.lowercased())

        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: range)
        }
        return attributedString
    }
}
