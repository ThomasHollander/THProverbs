import Foundation
import RealmSwift
import Firebase
class FFavoriteProverb: FavoriteProverb {
    struct SecondaryIndex {
        static let originIdentifier  = "originIdentifier"
    }
    private static let localStorage = ProverbsStorage()
    var _identifier                    = ""
    var _originIdentifier              = ""
    var _createdAt                     = Date.zero()
    var _section                       = ""
    init(rFavoriteProverb: RFavoriteProverb) {
        self._identifier        = rFavoriteProverb._identifier
        self._originIdentifier  = rFavoriteProverb._originIdentifier
        self._createdAt         = rFavoriteProverb._createdAt
        self._section           = rFavoriteProverb._section
    }
    init(rProverb: RProverb) {
        self._identifier        = String.randomString()
        self._originIdentifier  = rProverb._identifier
        self._createdAt         = Date()
        self._section           = rProverb._section
    }
    init(dictionary: [String: Any]) {
        self._identifier        = dictionary["identifier"]          as? String ?? ""
        self._originIdentifier  = dictionary["originIdentifier"]    as? String ?? ""
        self._createdAt         = (dictionary["createdAt"] as? Timestamp)?.dateValue() ?? Date.zero()
        self._section           = dictionary["section"]             as? String ?? ""
    }
    func dictionary() -> [String: Any] {
        return ["identifier" :          _identifier,
                "originIdentifier" :    _originIdentifier,
                "createdAt" :           Timestamp(date: _createdAt),
                "section" :             _section]
    }
    var identifier:                 String          { return _identifier }
    var createdAt:                  Date            { return _createdAt }
    var isRealm:                    Bool            { return false }
    var text:                       String          { return FFavoriteProverb.localStorage.getProverb(withIdentifier: self.originIdentifier)?._text ?? "" }
    var meaning:                    String          { return FFavoriteProverb.localStorage.getProverb(withIdentifier: self.originIdentifier)?._meaning ?? "" }
    var section:                    String          { return _section }
    var originIdentifier:           String          { return _originIdentifier }
    func realmModel() -> Object? {
        return nil
    }
    func firestoreModel() -> Any? {
        return self
    }
}
