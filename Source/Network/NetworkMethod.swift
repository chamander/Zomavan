enum NetworkMethod {

    case get

    var httpMethod: String {
        return String(describing: self).uppercased()
    }
}
