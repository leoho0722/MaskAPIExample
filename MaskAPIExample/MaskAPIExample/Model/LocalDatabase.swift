//
//  LocalDatabase.swift
//  MaskAPIExample
//
//  Created by Leo Ho on 2022/9/21.
//

import Foundation
import RealmSwift

class LocalDatabase: NSObject {
    
    static let shared = LocalDatabase()
    
    func add(maskInfo mask: MaskInfo) {
        let realm = try! Realm()
        
        let maskInfoTable = MaskInfoTable()
        maskInfoTable.drugStoreId = mask.id
        maskInfoTable.name = mask.name
        maskInfoTable.phone = mask.phone
        maskInfoTable.address = mask.address
        maskInfoTable.mask_adult = mask.mask_adult
        maskInfoTable.mask_child = mask.mask_child
        maskInfoTable.county = mask.county
        maskInfoTable.town = mask.town
        maskInfoTable.cunli = mask.cunli
        
        do {
            try! realm.write {
                realm.add(maskInfoTable)
                #if DEBUG
                print("Realm.Add Success")
                #endif
            }
        } catch {
            print("Realm.Add Failed，Error：\(error.localizedDescription)")
        }
    }
    
    func delete(id: String) {
        let realm = try! Realm()
        let deleteMask = realm.objects(MaskInfoTable.self).where { $0.drugStoreId == id }
        do {
            try! realm.write {
                realm.delete(deleteMask)
                #if DEBUG
                print("Realm.Delete Success")
                #endif
            }
        } catch {
            print("Realm.Delete Failed，Error：\(error.localizedDescription)")
        }
    }
}

class MaskInfoTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var drugStoreId: String = ""
    
    @Persisted var name: String = ""
    
    @Persisted var phone: String = ""
    
    @Persisted var address: String = ""
    
    @Persisted var mask_adult: Int = 0
    
    @Persisted var mask_child: Int = 0
    
    @Persisted var county: String = ""
    
    @Persisted var town: String = ""
    
    @Persisted var cunli: String = ""
}
