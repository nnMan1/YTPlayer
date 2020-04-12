//
//  Copyright © 2018 fleka. All rights reserved.
//

import WebKit

extension WKWebView {
    func load(HTML html: String, cssFiles: [String], javascriptFiles: [String]) {
        
        var fullHTML = #"""
                            <head>
                                <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
                                <meta name="apple-mobile-web-app-capable" content="yes">
                                <meta name="mobile-web-app-capable" content="yes">
                       """#
        
        for css in cssFiles {
            fullHTML.append(contentsOf: #"<link rel="stylesheet" type="text/css" href=""# + css + #"">"#)
        }
        
        fullHTML.append(contentsOf: "</head> <body>\(html)")
        
        for js in javascriptFiles {
            fullHTML.append( #"<script src=""# + js + #"" charset="UTF-8"></script>"#)
        }
        
        fullHTML.append(contentsOf: "</body>")
        
        self.loadHTMLString(fullHTML, baseURL: URL(fileURLWithPath: Bundle.main.path(forResource: "webViewBase", ofType: "html") ?? ""))
    }
    
    func getContentHeight(completion: @escaping (CGFloat?) -> Void) {
        self.evaluateJavaScript("document.body.style.height = document.body.firstChild.clientHeight") { (result, error) in
            if let result = result as? CGFloat {
               completion(result)
            }
        }
    }
}
