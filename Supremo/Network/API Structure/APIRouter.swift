//
//  APIRouter.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import Foundation

struct APIRouter<T: Codable> {
    
    // MARK: - Local Variables
    private let session: URLSessionProtocol!
    
    // MARK: - Init
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    // MARK: API Request
    func requestData(_ router: Routable,
                     completion : @escaping (_ model : T?, _ statusCode: Int? , _ error : Error?) -> Void ) {
        
        let queue = DispatchQueue(label: "NetworkThread", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem, target: .none)
        queue.async {
            guard let request = router.request else {return}
            let task = self.session.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    curateResponseForUI(data, httpResponse.statusCode, error, completion: completion)
                } else {
                    curateResponseForUI(data, nil, error, completion: completion)
                }
            }
            task.resume()
        }
        
        
    }
    
    private func curateResponseForUI(_ data: Data?, _ statusCode: Int?, _ error: Error?, completion : @escaping (_ model : T?, _ statusCode: Int? , _ error : Error?) -> Void) {
        guard error == nil, let code = statusCode, (200..<300) ~= code else {
            completion(nil, statusCode, GenericErrors.invalidAPIResponse)
            return
        }
        
        guard let properData = data else {
            completion(nil, statusCode, GenericErrors.invalidAPIResponse)
            return
        }
        
        do {
            let model = try JSONDecoder().decode(T.self, from: properData)
            completion(model, statusCode,  nil)
        } catch {
            print("decodingError: \(error)")
            completion(nil, statusCode, GenericErrors.decodingError)
        }
    }
    
}
