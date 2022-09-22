//
//  MainViewController.swift
//  MaskAPIExample
//
//  Created by Leo Ho on 2022/9/21.
//

import UIKit
import RealmSwift

class MainViewController: BaseViewController {
    
    @IBOutlet weak var sentenceOfDayLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var maskInfoTableView: UITableView!
    
    var maskInfoArray: [MaskInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "臺中市各地區的口罩數量"
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global().async {
            self.fetchDataFromLocalDatabase()
        }
    }
    
    func setupUI() {
        /// 設定 NavigationBar 顏色
        setupNavigationBarStyle(backgroundColor: .purple)
        
        /// 設定左邊 NavigationBarButtonItems
        setupLeftNavigationBarButtonItems()
        
        /// 設定右邊 NavigationBarButtonItems
        setupRightNavigationBarButtonItems()
        
        /// 設定每日一句的 Label
        setupLabel()
        
        /// 設定 TableView
        setupTableView()
    }
    
    private func setupLeftNavigationBarButtonItems() {
        let reloadItem = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(fetchDataFromLocalDatabase))
        self.navigationItem.leftBarButtonItems = [reloadItem]
    }
    
    private func setupRightNavigationBarButtonItems() {
        let townMenu = UIMenu(children: [
            UIAction(title: "中區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "中區")
            }),
            UIAction(title: "東區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "東區")
            }),
            UIAction(title: "西區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "西區")
            }),
            UIAction(title: "南區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "南區")
            }),
            UIAction(title: "北區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "北區")
            }),
            UIAction(title: "西屯區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "西屯區")
            }),
            UIAction(title: "南屯區", handler: {  [self] _ in
                refreshMaskInfoArray(townName: "南屯區")
            }),
            UIAction(title: "北屯區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "北屯區")
            }),
            UIAction(title: "豐原區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "豐原區")
            }),
            UIAction(title: "東勢區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "東勢區")
            }),
            UIAction(title: "大甲區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "大甲區")
            }),
            UIAction(title: "清水區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "清水區")
            }),
            UIAction(title: "沙鹿區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "沙鹿區")
            }),
            UIAction(title: "梧棲區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "梧棲區")
            }),
            UIAction(title: "后里區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "后里區")
            }),
            UIAction(title: "神岡區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "神岡區")
            }),
            UIAction(title: "潭子區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "潭子區")
            }),
            UIAction(title: "大雅區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "大雅區")
            }),
            UIAction(title: "新社區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "新社區")
            }),
            UIAction(title: "外埔區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "外埔區")
            }),
            UIAction(title: "大安區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "大安區")
            }),
            UIAction(title: "烏日區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "烏日區")
            }),
            UIAction(title: "大肚區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "大肚區")
            }),
            UIAction(title: "龍井區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "龍井區")
            }),
            UIAction(title: "霧峰區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "霧峰區")
            }),
            UIAction(title: "太平區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "太平區")
            }),
            UIAction(title: "大里區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "大里區")
            }),
            UIAction(title: "和平區", handler: { [self] _ in
                refreshMaskInfoArray(townName: "和平區")
            })
        ])
        let townPickerItem = UIBarButtonItem.addPullDownButtonMenu(title: nil, image: UIImage(systemName: "magnifyingglass.circle.fill"), menu: townMenu)
        self.navigationItem.rightBarButtonItems = [townPickerItem]
    }
    
    private func setupLabel() {
        sentenceOfDayLabel.text = "每日一句"
        authorLabel.text = "每日一句的作者"
    }
    
    private func setupTableView() {
        maskInfoTableView.delegate = self
        maskInfoTableView.dataSource = self
        maskInfoTableView.register(MaskInfoTableViewCell.loadFromNib(), forCellReuseIdentifier: MaskInfoTableViewCell.identifier)
    }
    
    func refreshMaskInfoArray(townName name: String) {
        let realm = try! Realm()
        let results = realm.objects(MaskInfoTable.self).where { $0.town == name }
        if results.count > 0 {
            maskInfoArray = []
            for mask in results {
                maskInfoArray.append(MaskInfo(id: mask.drugStoreId,
                                              name: mask.name,
                                              phone: mask.phone,
                                              address: mask.address,
                                              mask_adult: mask.mask_adult,
                                              mask_child: mask.mask_child,
                                              county: mask.county,
                                              town: mask.town,
                                              cunli: mask.cunli)
                )
            }
            
            DispatchQueue.main.async {
                self.maskInfoTableView.reloadData()
            }
        }
    }
    
    @objc func fetchDataFromLocalDatabase() {
        let realm = try! Realm()
        let results = realm.objects(MaskInfoTable.self)
        if results.count == 0 {
            fetchMaskInfo()
        } else {
            maskInfoArray = []
            for mask in results {
                maskInfoArray.append(MaskInfo(id: mask.drugStoreId,
                                              name: mask.name,
                                              phone: mask.phone,
                                              address: mask.address,
                                              mask_adult: mask.mask_adult,
                                              mask_child: mask.mask_child,
                                              county: mask.county,
                                              town: mask.town,
                                              cunli: mask.cunli)
                )
            }
            #if DEBUG
            print("FileURL：", realm.configuration.fileURL?.path)
            #endif
            
            DispatchQueue.main.async {
                self.maskInfoTableView.reloadData()
            }
        }
    }
    
    func fetchMaskInfo() {
        Task {
            do {
                let request = MaskInfoRequest()
                let results: MaskInfoResponse = try await NetworkManager.shared.requestData(httpMethod: .get, path: .mask, parameters: request)
                
                for i in results.features {
                    if i.properties.county == "臺中市" {
                        let maskInfo = MaskInfo(id: i.properties.id,
                                                name: i.properties.name,
                                                phone: i.properties.phone,
                                                address: i.properties.address,
                                                mask_adult: i.properties.mask_adult,
                                                mask_child: i.properties.mask_child,
                                                county: i.properties.county,
                                                town: i.properties.town,
                                                cunli: i.properties.cunli)
                        LocalDatabase.shared.add(maskInfo: maskInfo)
                        maskInfoArray.append(maskInfo)
                    }
                }
                
                DispatchQueue.main.async {
                    self.maskInfoTableView.reloadData()
                }
            } catch NetworkConstants.RequestError.invalidRequest {
                print("NetworkConstants.RequestError.invalidRequest")
            } catch NetworkConstants.RequestError.authorizationError {
                print("NetworkConstants.RequestError.authorizationError")
            } catch NetworkConstants.RequestError.notFound {
                print("NetworkConstants.RequestError.notFound")
            } catch NetworkConstants.RequestError.internalError {
                print("NetworkConstants.RequestError.internalError")
            } catch NetworkConstants.RequestError.serverError {
                print("NetworkConstants.RequestError.serverError")
            } catch NetworkConstants.RequestError.serverUnavailable {
                print("NetworkConstants.RequestError.serverUnavailable")
            } catch NetworkConstants.RequestError.unknownError {
                print("NetworkConstants.RequestError.unknownError")
            } catch NetworkConstants.RequestError.jsonDecodeFailed {
                print("NetworkConstants.RequestError.jsonDecodeFailed")
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maskInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MaskInfoTableViewCell.identifier, for: indexPath) as? MaskInfoTableViewCell else {
            fatalError("Can't Load MaskInfoTableViewCell")
        }
        cell.setInit(drugStoreName: maskInfoArray[indexPath.row].name,
                     drugStoreAddress: maskInfoArray[indexPath.row].address,
                     drugStorePhone: maskInfoArray[indexPath.row].phone,
                     adultMaskNum: maskInfoArray[indexPath.row].mask_adult,
                     childMaskNum: maskInfoArray[indexPath.row].mask_child)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (action, sourceView, completeHandler) in
            LocalDatabase.shared.delete(id: self.maskInfoArray[indexPath.row].id)
            self.maskInfoArray.remove(at: indexPath.row)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
            completeHandler(true)
        }
        let trailingSwipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return trailingSwipeConfiguration
    }
}
