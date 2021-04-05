//
//  URLProtocolMock.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/3/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

class URLProtocolMock: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (Data?, HTTPURLResponse?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
      // To check if this protocol can handle the given request.
      return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
      // Here you return the canonical version of the request but most of the time you pass the orignal one.
      return request
    }
    
    var data: Data?
    var error: Error?
    var response: HTTPURLResponse?
    
    override func startLoading() {
        URLProtocolMock.requestHandler = {request in
            
            let jsonFile = request.url?.lastPathComponent
            if let path = Bundle.main.path(forResource: jsonFile, ofType: "json") {
                do {
                    let fileUrl = URL(fileURLWithPath: path)
                    self.data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                    self.response = HTTPURLResponse(url: fileUrl, statusCode: 200, httpVersion: "", headerFields: nil)
                } catch {
                    self.error = APIServiceError.noData
                }
            }else{
                self.error = APIServiceError.fileNotFound
            }
            
            let data = self.data
            let error = self.error
            let response = self.response
            
            return (data, response, error)
        }
        
        guard let handler = URLProtocolMock.requestHandler else {
            fatalError("Handler is unavailable.")
        }

        do {
            let (data, response, _) = try handler(request)

            client?.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)

            if let data = data {
              client?.urlProtocol(self, didLoad: data)
            }

            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
