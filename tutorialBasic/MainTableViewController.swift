//
//  MainTableViewController.swift
//  tutorialBasic
//
//  Created by Jiraporn Praneet on 12/10/2561 BE.
//  Copyright © 2561 InformatixPlusCompanyLimited. All rights reserved.
//

import UIKit
import Alamofire
import EVReflection
import SDWebImage

class MainTableViewCell: UITableViewCell {
    @IBOutlet var occurredAtLabel: UILabel!
    @IBOutlet var cameraHubNameLabel: UILabel!
    @IBOutlet var prefixSufixLicensePlateLabel: UILabel!
    @IBOutlet var provinceLicensePlateLabel: UILabel!
    @IBOutlet var vehicleImageView: UIImageView!
}

class MainTableViewController: UITableViewController {
    
    var totalLoadMoreUpCount: Int = 100
    var lprResources = [LPRResource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getLPR()
    }
    
    func getLPR() {
        totalLoadMoreUpCount += 1
        let url = "https://api.skylpr.com/index.php/api/v1/lpr/lpr?per-page="
        let accessToken = "WpiTf2L7qYfKzNGul83ZngnjKn7GQo-rW_UfAsGL3S8zneIYGueh_KhJtgyPNdrC"
        let pathObject = "&with-envelope=true"
        let headers = ["Authorization": "Bearer " + accessToken]
        let getLPRPathPerPage = String(format: "%@%d%@",
                                       url, totalLoadMoreUpCount, pathObject)
        Alamofire.request(getLPRPathPerPage, method: .get, headers: headers).responseObject { (response: DataResponse<LPRResourceItem>) in
            switch response.result {
            case .success:
                let resource = response.value
                self.lprResources = (resource?.items)!
                self.tableView.reloadData()
                print("Resource\(self.lprResources)")
            case .failure(let error):
                print("ERROR with '\(error)")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lprResources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCells", for: indexPath as IndexPath) as! MainTableViewCell
        let cellData = lprResources[indexPath.row]
        cell.occurredAtLabel.text = cellData.occurredAt
        cell.cameraHubNameLabel.text = cellData.cameraHubName
        cell.prefixSufixLicensePlateLabel.text = cellData.prefixLicense! + cellData.suffixLicense!
        cell.provinceLicensePlateLabel.text = cellData.province
        print("vehicle\(String(describing: cellData.vehicleImageUrl))")
        cell.vehicleImageView.sd_setImage(with: URL(string: cellData.vehicleImageUrl!), completed: nil)
        return cell
    }
}
