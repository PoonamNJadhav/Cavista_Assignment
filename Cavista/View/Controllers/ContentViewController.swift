//
//  ContentViewController.swift
//  Cavista
//
//  Created by Lawand, Poonam on 05/08/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//



import UIKit
import SnapKit

class ContentViewController: UIViewController {
    
    private var tableView: UITableView!
    private var contentList:[ContentViewModel] = []
    private let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contents"
        prepareSubViews()
        fetchContents()
     }
    //update table constarints
   override func viewWillLayoutSubviews() {
         tableView.snp.makeConstraints {
                 $0.left.equalToSuperview().offset(0)
                 $0.right.equalToSuperview().offset(0)
                 $0.top.equalToSuperview().offset(0)
                 $0.bottom.equalToSuperview().offset(0)
            }
         }
        
    
    /* Function to prepare/configure table view to show content on page
    */
    func prepareSubViews() {
        tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.identifier)
        view.addSubview(tableView)
        
        //Configure activity indicator
         view.addSubview(activityIndicator)
         activityIndicator.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self.view.snp.center)
          }
      
    }
    //func to show activity indicator when some activity running/ waiting for data
    func showIndicator(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    //func to hide activity indicator
    func hidIndicator(){
            activityIndicator.stopAnimating()
           activityIndicator.isHidden = true
           
       }
    
   // fetch contents from server in online ,use locally stored data in offline mode.
    func fetchContents(){
       showIndicator()
       ClientService.shared.fetchData(completion: {[weak self] (result) in
            switch result {
                case .success(let data):
                    
                    if let dataToParse = data {
                                  self?.contentList += DataHelper.shareInstance.parseAndSaveData(jsonData: dataToParse)
                                  DispatchQueue.main.async {
                                     self?.tableView.reloadData()
                                     }
                              }
                    self?.hidIndicator()
                break
            case .error(let error):
               //fetch data in offline
                self?.contentList += DataHelper.shareInstance.fetchFromDataBase() ?? []
                if((self?.contentList.count)! > 0){
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    self?.hidIndicator()
                }
                else {
                    self?.hidIndicator()
                    self?.showAlert(withTitle: "No Data", message: "No internet connection and stored data available")
                }
               break
               
            }
        })
    }
}
//MARK - UITableViewDelegate
extension ContentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //launch Details View
        let object = contentList[indexPath.row]
        let detailsViewController = ContentDetailViewController()
        detailsViewController.contentObject = object
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

//MARK - UITableViewDataSource
extension ContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier, for: indexPath) as! ContentTableViewCell
        cell.id.text = "\(contentList[indexPath.row].contentTitle)"
        cell.type.text = contentList[indexPath.row].contentType
        cell.date.text = contentList[indexPath.row].contentDate
        return cell
       }
}


