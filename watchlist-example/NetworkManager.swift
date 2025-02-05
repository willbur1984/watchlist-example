//
//  NetworkManager.swift
//  watchlist-example
//
//  Created by William Towe on 2/4/25.
//

import Alamofire
import Combine
import Feige
import Foundation
import os.log
import Valet

extension JSONDecoder: @retroactive ScopeFunctions {}

private final class NetworkEventMonitor: EventMonitor {
    // MARK: - EventMonitor
    var queue: DispatchQueue {
        self._queue
    }
    
    // MARK: - Private Properties
    private let _queue = DispatchQueue(label: String(describing: NetworkEventMonitor.self), qos: .background)
    
    // MARK: - EventMonitor
    func request(_ request: Request, didCreateURLRequest urlRequest: URLRequest) {
        os_log("request %@", request.cURLDescription())
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) where Value : Sendable {
        if let response = request.response {
            os_log("response status code %@", String(describing: response.statusCode))
            os_log("response header fields %@", String(describing: response.allHeaderFields))
        }
        if let data = request.data {
            if let json = try? JSONSerialization.jsonObject(with: data), let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted, .sortedKeys]), let jsonString = String(data: jsonData, encoding: .utf8) {
                os_log("response data %@", jsonString)
            }
            else if let dataString = String(data: data, encoding: .utf8) {
                os_log("response data %@", dataString)
            }
        }
        if let error = response.error {
            os_log("response error %@", type: .error, String(describing: error))
        }
    }
}

private final class NetworkRequestInterceptor: RequestInterceptor {
    // MARK: - RequestInterceptor
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var urlRequest = urlRequest
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        completion(.success(urlRequest))
    }
}

final class NetworkManager: BaseViewModel {
    // MARK: - Public Types
    enum NetworkError: Error {
        case emptySessionToken
    }
    
    // MARK: - Public Properties
    var isLoggedIn: AnyPublisher<Bool, Never> {
        self.$sessionToken
            .map {
                $0.isNotEmptyOrNil
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    static let shared = NetworkManager()
    
    // MARK: - Private Properties
    private static let baseURL = URL(string: "https://api.cert.tastyworks.com/")!
    private static let decoder = JSONDecoder().also {
        $0.dateDecodingStrategy = .iso8601
    }
    private static let session = Session(interceptor: NetworkRequestInterceptor(), eventMonitors: [NetworkEventMonitor()])
    private static let valet = Valet.valet(with: Identifier(nonEmpty: String(describing: NetworkManager.self))!, accessibility: .afterFirstUnlockThisDeviceOnly)
    private static let sessionTokenKey = "\(NetworkManager.self).session-token"
    @Published
    private var sessionToken: String? {
        didSet {
            guard let sessionToken = self.sessionToken else {
                try? Self.valet.removeObject(forKey: Self.sessionTokenKey)
                return
            }
            try? Self.valet.setString(sessionToken, forKey: Self.sessionTokenKey)
        }
    }
    
    // MARK: - Public Functions
    func login(username: String, password: String) async throws -> LoginResponse {
        try await Self.session.request(
            URL(string: "sessions", relativeTo: Self.baseURL)!,
            method: .post,
            parameters: [
                "login": username,
                "password": password,
                "remember-me": false
            ]).serializingDecodable(LoginResponse.self, decoder: Self.decoder).value
    }
    
    func watchlists() async throws -> WatchlistsResponse {
        try await Self.session.request(
            URL(string: "watchlists", relativeTo: Self.baseURL)!,
            headers: [
                .authorization(sessionTokenOrThrow())
            ]
        ).serializingDecodable(WatchlistsResponse.self, decoder: Self.decoder).value
    }
    
    // MARK: - Private Functions
    private func sessionTokenOrThrow() throws(NetworkError) -> String {
        guard let retval = self.sessionToken?.nilIfEmpty else {
            throw NetworkError.emptySessionToken
        }
        return retval
    }
    
    // MARK: - Initializers
    private override init() {
        super.init()
        
        self.sessionToken = try? Self.valet.string(forKey: Self.sessionTokenKey)
    }
}
