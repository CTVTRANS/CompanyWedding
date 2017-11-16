//
//  BaseViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit
import SWRevealViewController
import SwiftyJSON

class BaseViewController: UIViewController {

    var swVC: SWRevealViewController?
    var activity: UIActivityIndicatorView?
    var backGroundview: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swVC = self.revealViewController()
    }
    
    func setupNavigation() {
        if self.revealViewController() != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftBarButton"), style: .plain, target: self.revealViewController(), action: #selector(revealViewController().revealToggle(_:)))
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .done, target: self, action: #selector(popToRootNavigation))
            navigationItem.title = "婚禮助手App"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    @objc func popToRootNavigation() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    func requestWith(task: LKNetwork, success: @escaping BlockSucess) {
        task.requestServer(sucess: { (data) in
            success(data)
        }) { (error) in
            UIAlertController.showAlertWith(title: "", message: error, in: self)
        }
    }
    
    func shared() {
        let textShare = "hello hello"
        let linkShare = "https://www.google.com.vn"
        let shareObject = [textShare, linkShare] as? [Any]
        let activity = UIActivityViewController(activityItems: shareObject!, applicationActivities: nil)
        self.present(activity, animated: true, completion: nil)
    }
    
    func openManagerCompany() {
        UIApplication.shared.openURL(URL(string: baseURL + manager)!)
    }
    
    func openListMember() {
        UIApplication.shared.openURL(URL(string: baseURL + listMemberOnline)!)
    }
    
    func openMemberUpload() {
        UIApplication.shared.openURL(URL(string: baseURL + seatMemberUpload)!)
    }
    
    func openSeat() {
        UIApplication.shared.openURL(URL(string: baseURL + seatLink)!)
    }
    
    func openCompanyInfo() {
        UIApplication.shared.openURL(URL(string: baseURL + companyInfo)!)
    }
    
    func showActivity(inView myView: UIView) {
        backGroundview = UIView(frame: myView.bounds)
        backGroundview?.backgroundColor = UIColor.white
        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        loadingView.backgroundColor = UIColor.clear
        activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingView.addSubview(activity!)
        let nameLoading = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        nameLoading.font = UIFont(name: "Helvetica Neue", size: 15)
        nameLoading.text = "loading..."
        nameLoading.textAlignment = .center
        nameLoading.textColor = UIColor.gray
        nameLoading.backgroundColor = UIColor.clear
        nameLoading.translatesAutoresizingMaskIntoConstraints = true
        loadingView.addSubview(nameLoading)
        
        backGroundview?.addSubview(loadingView)
        nameLoading.center = CGPoint(x: loadingView.center.x, y: loadingView.center.y + 23)
        activity?.center = loadingView.center
        loadingView.center = (backGroundview?.center)!
        myView.addSubview(backGroundview!)
        activity?.startAnimating()
    }
    
    func stopActivityIndicator() {
        activity?.stopAnimating()
        backGroundview?.removeFromSuperview()
    }
}
