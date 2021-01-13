//
//  ViewController.swift
//  test-download-files
//
//  Created by Jan Salvador Sebastian on 1/13/21.
//

import UIKit
import WebKit
import QuickLook
import Alamofire

class ViewController: UIViewController, WKNavigationDelegate{
    
    var webView: WKWebView!
    let url: String = "https://drive.google.com/u/1/uc?id=1a1j_6MMelvaqDFlGWQ6H4q6ehT-7h8Ae&export=download"
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change URL here
        let url = URL(string: self.url)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        self.downloadFiles()
    }
    
    func downloadFiles(){
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("R&D_baby.pdf")

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        AF.download(self.url, to: destination).response { response in
            debugPrint(response)

            if response.error == nil, let imagePath = response.fileURL?.path {
//                let image = UIImage(contentsOfFile: imagePath)
                print(imagePath)
            }
        }
    }
    
}

