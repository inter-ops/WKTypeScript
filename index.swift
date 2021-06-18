import Foundation

extension TypeScript {
    enum index {
        case toggle(Void = ())
        case setLabel(_ text: String)
        case hideObject(_ hidden: Bool = false)
        case addNumbers(_ a: Double, _ b: Double)

        var js: String {
            switch self {
            case .toggle(): return JS.function("toggle()")
            case let .setLabel(text): return JS.function("setLabel(\(text))")
            case let .hideObject(hidden): return JS.function("hideObject(\(hidden))")
            case let .addNumbers(a, b): return JS.function("addNumbers(\(a),\(b))")
            }
        }
    }
}
