//
//  File.swift
//
//
//  Created by Narongrit Kanhanoi on 8/9/2563 BE.
//  Copyright © 2563 3dsinteractive. All rights reserved.
//

import Foundation


public enum NetworkError: Error {
    case badURL
    case badQueryString
    case serverError(String, Int)
    case timeOut
}

public struct HttpResponse {
    public let headers: [AnyHashable: Any]
    public let text: String?
    public let statusCode: Int
}

public protocol FormField {

}

public struct FormTextField: FormField {
    public let fieldName: String
    public let value: String
}

public struct FormFileField: FormField {
    public let fieldName: String
    public let fileName: String
    public let data: Data

    public static func createFormPath(fieldName: String, fileName: String, filePath: String) -> FormField? {
        if let url = URL(string: filePath) {
            if let data = try? Data(contentsOf: url) {
                return FormFileField(fieldName: fieldName, fileName: fileName, data: data)
            }
        }
        return nil
    }

    public static func createFromData(fieldName: String, fileName: String, data: Data) -> FormField {
        return FormFileField(fieldName: fieldName, fileName: fileName, data: data)
    }

}

public class RPHttp {

    static var _instance: RPHttp?

    public static var shared: RPHttp {
        get {
            if _instance == nil {
                _instance = RPHttp()
            }
            return _instance!
        }
    }

    public func get(url: String, queryStrings: [String: String]? = nil, headers: [String: String]? = nil) -> Result<HttpResponse, NetworkError> {

        guard var urlComp = URLComponents(string: url) else {
            return .failure(.badURL)
        }

        let taskID = Int.random(in: 0..<99999)

        urlComp.queryItems = []
        queryStrings?.forEach { (key: String, value: String) in
            urlComp.queryItems?.append(URLQueryItem(name: key, value: value))
        }

        guard let url = urlComp.url else {
            return .failure(.badQueryString)
        }

        var request: URLRequest = URLRequest(url: url)
        headers?.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }

        request.httpMethod = "GET"

        RPLog.debug("(\(taskID)) 🍀 \(String(describing: request.httpMethod))\n\(request.curlString)")

        let semaphore = DispatchSemaphore(value: 0)

        let session = URLSession(configuration: .default)

        var responseString: String?
        var statusCode = 0
        var headers: [AnyHashable: Any] = [:]

        session.dataTask(with: request) { data, res, _ in
            guard let httpResponse = res as? HTTPURLResponse, let receivedData = data
                else {
                    semaphore.signal()
                    return
            }
            headers = httpResponse.allHeaderFields
            responseString = String(data: receivedData, encoding: .utf8) ?? ""
            statusCode = httpResponse.statusCode
            semaphore.signal()
        }.resume()

        semaphore.wait()

        if statusCode >= 200 && statusCode <= 299 {
            return .success(HttpResponse(headers: headers, text: responseString, statusCode: statusCode))
        }

        return .failure(.serverError(responseString ?? "", statusCode))
    }


    public func postMultipartForm(url: String, formData: [FormField]? = nil, queryStrings: [String: String]? = nil, headers: [String: String]? = nil) -> Result<HttpResponse, NetworkError> {

        guard var urlComp = URLComponents(string: url) else {
            return .failure(.badURL)
        }

        let taskID = Int.random(in: 0..<99999)

        urlComp.queryItems = []
        queryStrings?.forEach { (key: String, value: String) in
            urlComp.queryItems?.append(URLQueryItem(name: key, value: value))
        }

        guard let url = urlComp.url else {
            return .failure(.badQueryString)
        }

        var request: URLRequest = URLRequest(url: url)
        headers?.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }

        let boundary = "--RampageMVVC-Boundary--\(UUID().uuidString)"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let httpMultipartBody = self.multipartFormToHttpBody(formField: formData, boundary: boundary)
        request.httpBody = httpMultipartBody

        request.httpMethod = "POST"

        RPLog.debug("(\(taskID)) 🍀 \(String(describing: request.httpMethod))\n\(request.curlString)")

        let semaphore = DispatchSemaphore(value: 0)

        let session = URLSession(configuration: .default)

        var responseString: String?
        var statusCode = 0
        var headers: [AnyHashable: Any] = [:]

        session.dataTask(with: request) { data, res, _ in
            guard let httpResponse = res as? HTTPURLResponse, let receivedData = data
                else {
                    semaphore.signal()
                    return
            }
            headers = httpResponse.allHeaderFields
            responseString = String(data: receivedData, encoding: .utf8) ?? ""
            statusCode = httpResponse.statusCode
            semaphore.signal()
        }.resume()

        semaphore.wait()

        if statusCode >= 200 && statusCode <= 299 {
            return .success(HttpResponse(headers: headers, text: responseString, statusCode: statusCode))
        }

        return .failure(.serverError(responseString ?? "", statusCode))
    }

    public func post(url: String, body: Data? = nil, queryStrings: [String: String]? = nil, headers: [String: String]? = nil) -> Result<HttpResponse, NetworkError> {

        guard var urlComp = URLComponents(string: url) else {
            return .failure(.badURL)
        }

        let taskID = Int.random(in: 0..<99999)

        urlComp.queryItems = []
        queryStrings?.forEach { (key: String, value: String) in
            urlComp.queryItems?.append(URLQueryItem(name: key, value: value))
        }

        guard let url = urlComp.url else {
            return .failure(.badQueryString)
        }

        var request: URLRequest = URLRequest(url: url)
        headers?.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }

        request.httpBody = body

        request.httpMethod = "POST"

        RPLog.debug("(\(taskID)) 🍀 \(String(describing: request.httpMethod))\n\(request.curlString)")

        let semaphore = DispatchSemaphore(value: 0)

        let session = URLSession(configuration: .default)

        var responseString: String?
        var statusCode = 0
        var headers: [AnyHashable: Any] = [:]


        session.dataTask(with: request) { data, res, _ in
            guard let httpResponse = res as? HTTPURLResponse, let receivedData = data
                else {
                    semaphore.signal()
                    return
            }
            headers = httpResponse.allHeaderFields
            responseString = String(data: receivedData, encoding: .utf8) ?? ""
            statusCode = httpResponse.statusCode
            semaphore.signal()
        }.resume()

        semaphore.wait()

        if statusCode >= 200 && statusCode <= 299 {
            return .success(HttpResponse(headers: headers, text: responseString, statusCode: statusCode))
        }

        return .failure(.serverError(responseString ?? "", statusCode))
    }

    public func put(url: String, body: Data? = nil, queryStrings: [String: String]? = nil, headers: [String: String]? = nil) -> Result<HttpResponse, NetworkError> {

        guard var urlComp = URLComponents(string: url) else {
            return .failure(.badURL)
        }

        let taskID = Int.random(in: 0..<99999)

        urlComp.queryItems = []
        queryStrings?.forEach { (key: String, value: String) in
            urlComp.queryItems?.append(URLQueryItem(name: key, value: value))
        }

        guard let url = urlComp.url else {
            return .failure(.badQueryString)
        }

        var request: URLRequest = URLRequest(url: url)
        headers?.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }

        request.httpBody = body

        request.httpMethod = "PUT"

        RPLog.debug("(\(taskID)) 🍀 \(String(describing: request.httpMethod))\n\(request.curlString)")

        let semaphore = DispatchSemaphore(value: 0)

        let session = URLSession(configuration: .default)

        var responseString: String?
        var statusCode = 0
        var headers: [AnyHashable: Any] = [:]


        session.dataTask(with: request) { data, res, _ in
            guard let httpResponse = res as? HTTPURLResponse, let receivedData = data
                else {
                    semaphore.signal()
                    return
            }
            headers = httpResponse.allHeaderFields
            responseString = String(data: receivedData, encoding: .utf8) ?? ""
            statusCode = httpResponse.statusCode
            semaphore.signal()
        }.resume()

        semaphore.wait()

        if statusCode >= 200 && statusCode <= 299 {
            return .success(HttpResponse(headers: headers, text: responseString, statusCode: statusCode))
        }

        return .failure(.serverError(responseString ?? "", statusCode))
    }

    public func patch(url: String, body: Data? = nil, queryStrings: [String: String]? = nil, headers: [String: String]? = nil) -> Result<HttpResponse, NetworkError> {

        guard var urlComp = URLComponents(string: url) else {
            return .failure(.badURL)
        }

        let taskID = Int.random(in: 0..<99999)

        urlComp.queryItems = []
        queryStrings?.forEach { (key: String, value: String) in
            urlComp.queryItems?.append(URLQueryItem(name: key, value: value))
        }

        guard let url = urlComp.url else {
            return .failure(.badQueryString)
        }

        var request: URLRequest = URLRequest(url: url)
        headers?.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }

        request.httpBody = body

        request.httpMethod = "PATCH"

        RPLog.debug("(\(taskID)) 🍀 \(String(describing: request.httpMethod))\n\(request.curlString)")

        let semaphore = DispatchSemaphore(value: 0)

        let session = URLSession(configuration: .default)

        var responseString: String?
        var statusCode = 0
        var headers: [AnyHashable: Any] = [:]


        session.dataTask(with: request) { data, res, _ in
            guard let httpResponse = res as? HTTPURLResponse, let receivedData = data
                else {
                    semaphore.signal()
                    return
            }
            headers = httpResponse.allHeaderFields
            responseString = String(data: receivedData, encoding: .utf8) ?? ""
            statusCode = httpResponse.statusCode
            semaphore.signal()
        }.resume()

        semaphore.wait()

        if statusCode >= 200 && statusCode <= 299 {
            return .success(HttpResponse(headers: headers, text: responseString, statusCode: statusCode))
        }

        return .failure(.serverError(responseString ?? "", statusCode))
    }

    public func delete(url: String, queryStrings: [String: String]? = nil, headers: [String: String]? = nil) -> Result<HttpResponse, NetworkError> {

        guard var urlComp = URLComponents(string: url) else {
            return .failure(.badURL)
        }

        let taskID = Int.random(in: 0..<99999)

        urlComp.queryItems = []
        queryStrings?.forEach { (key: String, value: String) in
            urlComp.queryItems?.append(URLQueryItem(name: key, value: value))
        }

        guard let url = urlComp.url else {
            return .failure(.badQueryString)
        }

        var request: URLRequest = URLRequest(url: url)
        headers?.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }

        request.httpMethod = "DELETE"

        RPLog.debug("(\(taskID)) 🍀 \(String(describing: request.httpMethod))\n\(request.curlString)")

        let semaphore = DispatchSemaphore(value: 0)

        let session = URLSession(configuration: .default)

        var responseString: String?
        var statusCode = 0
        var headers: [AnyHashable: Any] = [:]


        session.dataTask(with: request) { data, res, _ in
            guard let httpResponse = res as? HTTPURLResponse, let receivedData = data
                else {
                    semaphore.signal()
                    return
            }
            headers = httpResponse.allHeaderFields
            responseString = String(data: receivedData, encoding: .utf8) ?? ""
            statusCode = httpResponse.statusCode
            semaphore.signal()
        }.resume()

        semaphore.wait()

        if statusCode >= 200 && statusCode <= 299 {
            return .success(HttpResponse(headers: headers, text: responseString, statusCode: statusCode))
        }

        return .failure(.serverError(responseString ?? "", statusCode))
    }

}

extension URLRequest {

    /**
     Returns a cURL command representation of this URL request.
     */
    public var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#

        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var command = [baseCommand]

        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }

        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
    }

    init?(curlString: String) {
        return nil
    }

}


extension RPHttp {

    func multipartFormToHttpBody(formField: [FormField]?, boundary: String) -> Data {
        var resultData = Data()

        var textData = Data()
        var fileData = Data()

        let boundaryData = "\r\n--\(boundary)\r\n".data(using: .utf8)!

        formField?.forEach {
            switch $0 {
            case let field as FormTextField:
                guard let encodedKey = field.fieldName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let encodedValue = field.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    else {
                        return
                }
                if textData.count == 0 {
                    if let data = "\(encodedKey)=\(encodedValue)".data(using: .utf8) {
                        textData.append(data)
                    }
                } else {
                    if let data = "&\(encodedKey)=\(encodedValue)".data(using: .utf8) {
                        textData.append(data)
                    }
                }
            case let field as FormFileField:
                if fileData.count > 0 {
                    fileData.append(boundaryData)
                }
                fileData.append("Content-Disposition: form-data; name=\"\(field.fieldName)\"; filename=\"\(field.fileName)\"\r\n".data(using: .utf8)!)
                let mime = getMimeType(fileName: field.fileName)
                fileData.append("Content-Type: \(mime)\r\n\r\n".data(using: .utf8)!)
                fileData.append(field.data)
            default:
                break
            }
        }


        if textData.count > 0 {
            resultData.append(boundaryData)
            resultData.append(textData)
        }

        if fileData.count > 0 {
            if resultData.count == 0 {
                resultData.append(boundaryData)
            }
            resultData.append(fileData)
        }

        if fileData.count > 0 {
            resultData.append(boundaryData)
        }


        return resultData
    }



}



extension RPHttp {
    func getMimeType(fileName: String) -> String {
        let mimeList = ["aac": "audio/aac",
            "abw": "application/x-abiword",
            "arc": "application/x-freearc",
            "avi": "video/x-msvideo",
            "azw": "application/vndamazonebook",
            "bin": "application/octet-stream",
            "bmp": "image/bmp",
            "bz": "application/x-bzip",
            "bz2": "application/x-bzip2",
            "csh": "application/x-csh",
            "css": "text/css",
            "csv": "text/csv",
            "doc": "application/msword",
            "docx": "application/vndopenxmlformats-officedocumentwordprocessingmldocument",
            "eot": "application/vndms-fontobject",
            "epub": "application/epub+zip",
            "gz": "application/gzip",
            "gif": "image/gif",
            "htm": "text/html",
            "html": "text/html",
            "ico": "image/vndmicrosofticon",
            "ics": "text/calendar",
            "jar": "application/java-archive",
            "jpeg": "image/jpeg",
            "jpg": "image/jpeg",
            "js": "text/javascript",
            "json": "application/json",
            "jsonld": "application/ld+json",
            "mid": "audio/midi audio/x-midi",
            "midi": "audio/midi audio/x-midi",
            "mjs": "text/javascript",
            "mp3": "audio/mpeg",
            "mpeg": "video/mpeg",
            "mpkg": "application/vndappleinstaller+xml",
            "odp": "application/vndoasisopendocumentpresentation",
            "ods": "application/vndoasisopendocumentspreadsheet",
            "odt": "application/vndoasisopendocumenttext",
            "oga": "audio/ogg",
            "ogv": "video/ogg",
            "ogx": "application/ogg",
            "opus": "audio/opus",
            "otf": "font/otf",
            "png": "image/png",
            "pdf": "application/pdf",
            "php": "application/x-httpd-php",
            "ppt": "application/vndms-powerpoint",
            "pptx": "application/vndopenxmlformats-officedocumentpresentationmlpresentation",
            "rar": "application/vndrar",
            "rtf": "application/rtf",
            "sh": "application/x-sh",
            "svg": "image/svg+xml",
            "swf": "application/x-shockwave-flash",
            "tar": "application/x-tar",
            "tif": "image/tiff",
            "tiff": "image/tiff",
            "ts": "video/mp2t",
            "ttf": "font/ttf",
            "txt": "text/plain",
            "vsd": "application/vndvisio",
            "wav": "audio/wav",
            "weba": "audio/webm",
            "webm": "video/webm",
            "webp": "image/webp",
            "woff": "font/woff",
            "woff2": "font/woff2",
            "xhtml": "application/xhtml+xml",
            "xls": "application/vndms-excel",
            "xlsx": "application/vndopenxmlformats-officedocumentspreadsheetmlsheet",
            "xml": "application/xml",
            "xul": "application/vndmozillaxul+xml",
            "zip": "application/zip",
            "3gp": "video/3gpp",
            "3g2": "video/3gpp2",
            "7z": "application/x-7z-compressed"]

        let fileExtension = String(fileName.split(separator: ".").last ?? "-")
        return mimeList[fileExtension] ?? "application/octet-stream"
    }
}
