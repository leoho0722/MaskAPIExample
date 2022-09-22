//
//  Extension.swift
//  MaskAPIExample
//
//  Created by Leo Ho on 2022/9/21.
//

import UIKit

extension UIView {
    
    /// 載入 UINib，方便用來註冊 TableViewCell、CollectionViewCell
    /// - Returns: 對應的 UINib
    class func loadFromNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UIBarButtonItem {
    
    /// 在 UIBarButtonItem 上面加按鈕
    /// - Parameters:
    ///   - title: 按鈕標題
    ///   - image: 按鈕的圖片
    ///   - size: 按鈕的寬高，目前固定為 28x28 (width x height)
    ///   - tintColor: 按鈕標題、圖片的顏色
    ///   - target: 哪個畫面要幫你做事
    ///   - action: 按下按鈕後要做的事
    static func addButton(title: String?, imageName: String, size: CGSize = CGSize(width: 28, height: 28), tintColor: UIColor?, _ target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.tintColor = tintColor
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        
        return menuBarItem
    }
    
    /// Pull Down Button Menu
    /// - Parameters:
    ///   - title: 按鈕標題
    ///   - image: 按鈕的圖片
    ///   - size: 按鈕的寬高，目前固定為 56x28 (width x height)
    ///   - menu: 按下按鈕後要顯示的 menu 選單，預設為 nil
    static func addPullDownButtonMenu(title: String?, image: UIImage?, size: CGSize = CGSize(width: 60, height: 30), menu: UIMenu? = nil) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.showsMenuAsPrimaryAction = true
        button.menu = menu
        if #available(iOS 15.0, *) {
            button.configuration?.imagePadding = 5
        }

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        
        return menuBarItem
    }
}

extension Encodable {
    
    func asDictionary() throws -> [String : Any] {
        let data = try JSONEncoder().encode(self)
        
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        
        return dictionary
    }
}
