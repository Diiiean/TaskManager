import Foundation

protocol NetworkSession {
    func saveData(with urlRequest: URLRequest)
}

extension URLSession: NetworkSession {
    func saveData(with urlRequest: URLRequest) {
        
    }
}

class NetworkManager {
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    func makeRequest(
        with url: URL
    ) {
        session.saveData(with: URLRequest(url: url))
    }
}

