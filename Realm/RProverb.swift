import UIKit
import RealmSwift
class RProverb: Object, Proverb {
    override static func primaryKey() -> String? {
        return "_identifier"
    }
    @objc dynamic var _identifier                    = ""
    @objc dynamic var _createdAt                     = Date.zero()
    @objc dynamic var _text                          = ""
    @objc dynamic var _meaning                       = ""
    @objc dynamic var _section                       = ""
    @objc dynamic var _viewed                        = false
    typealias RealmType = RProverb
    typealias FirestoreType = Any
    var identifier:                 String          { return _identifier }
    var createdAt:                  Date            { return _createdAt }
    var isRealm:                    Bool            { return true }
    var text:                       String          { return _text }
    var meaning:                    String          { return _meaning }
    var section:                    String          { return _section }
    func realmModel() -> Object? {
        return self
    }
    func firestoreModel() -> Any? {
        return nil
    }
}
