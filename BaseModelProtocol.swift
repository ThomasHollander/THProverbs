import Foundation
protocol BaseModelProtocol {
    var identifier:                 String          { get }
    var createdAt:                  Date            { get }
    var isRealm:                    Bool            { get }
}
