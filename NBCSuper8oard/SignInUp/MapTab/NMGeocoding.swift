//
//  NMGeocoding.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/21/24.
//

import Foundation

struct GeoXY: Decodable {
    let addresses: [Address]
    struct Address: Decodable {
        let x: String
        let y: String
    }
}
class NMGeocoding {
    
    static let shared = NMGeocoding()
    let NAVER_CLIENT_ID = "네이버 API 클라이언트 ID"
    let NAVER_CLIENT_SECRET = "네이버 API 시크릿 값"
    let baseURL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode"
    
    func getGeoXY(_ address: String, completion: @escaping (GeoXY?) -> Void) {
        
        var components = URLComponents(string: baseURL)!
        components.queryItems = [ URLQueryItem(name: "query", value: address) ]
        guard let url = components.url else {
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(NAVER_CLIENT_ID, forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.addValue(NAVER_CLIENT_SECRET, forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let responseData = data else {
                completion(nil)
                return
            }
            do {
                let response = try JSONDecoder().decode(GeoXY.self, from: responseData)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
