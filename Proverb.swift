import Foundation
import RealmSwift
protocol Proverb: BaseModelProtocol {
    var text:                       String          { get }
    var meaning:                    String          { get }
    var section:                    String          { get }
    func realmModel() -> Object?
    func firestoreModel() -> Any?
}
