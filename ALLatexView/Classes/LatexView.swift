//
//  LatexView.swift
//
//  Created by Alfred Gao on 20210408.

import SwiftUI
import WebKit

public struct LatexView: UIViewRepresentable {
    
    @Binding var latex: String
    @Binding var height: CGFloat?
    
    var css: String
    
    public init(_ latex:Binding<String>, height: Binding<CGFloat?> = Binding.constant(nil), css:String = ".formula-wrap {line-height: 24px;}") {
        self._latex = latex
        self._height = height
        self.css = css
    }
    
    static var engine = "katex"
    class __LatexViewBundlePath{}
    static var bundle = Bundle(for: LatexView.__LatexViewBundlePath.self)
    static var base = bundle.resourceURL?.appendingPathComponent(engine)
    static var filePath = bundle.path(forResource:"index", ofType:"html", inDirectory: engine)!
    static var basehtml = try! String(contentsOfFile: filePath, encoding: .utf8)
   
    public func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.scrollView.isScrollEnabled = false
        webview.scrollView.showsVerticalScrollIndicator = false
        webview.scrollView.showsHorizontalScrollIndicator = false
        webview.isOpaque = false
        
        #if DEBUG
        print("Created LatexView with latex '\(latex)'")
        #endif
        
        let html = LatexView.basehtml
            .replacingOccurrences(of: "{*customCSS*}", with: css)
            .replacingOccurrences(of: "{*latexString*}", with: "")
        webview.loadHTMLString(html, baseURL: LatexView.base)
        waitingLoadAndUpdateLatex(webview, context: context)
        
        return webview
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        print("updating view")
        
        waitingLoadAndUpdateLatex(uiView, context: context)
    }
    
    func waitingLoadAndUpdateLatex(_ uiView: WKWebView, context: Context) {
        #if DEBUG
        print("waitingLoadAndUpdateLatex")
        #endif
        uiView.evaluateJavaScript("document.readyState", completionHandler: { [weak uiView] (complete, error) in
            if complete as! String == "complete" {
                uiView?.evaluateJavaScript("""
        document.getElementById(\"formula\").innerHTML = String.raw`\(latex)`;
        renderMathInElement(document.getElementById(\"formula\"),  {
            delimiters:
                [
                    {left: '$$', right: '$$', display: true},
                    {left: '$', right: '$', display: false},
                    {left: '\\(', right: '\\)', display: false},
                    {left: '\\[', right: '\\]', display: true}
                ],
            throwOnError : false
            })
        """, completionHandler: { [weak uiView] (updateResult, error) in
                    #if DEBUG
                    print("Changing: Latex updated with \(latex)")
                    #endif
                    waitingLoadAndResize(uiView!, context: context)
                })
            } else {
                #if DEBUG
                print("Changing: LatexView loading not complete: \(complete as! String), waiting and retry...")
                #endif
                usleep(10000)
                waitingLoadAndUpdateLatex(uiView!, context: context)
            }
        })
    }
    
    func waitingLoadAndResize(_ uiView: WKWebView, context: Context) {
        #if DEBUG
        print("waitingLoadAndResize")
        #endif
        uiView.evaluateJavaScript("document.readyState", completionHandler: { [weak uiView] (complete, error) in
            if complete as! String == "complete" {
                uiView?.evaluateJavaScript("Math.max(document.documentElement.offsetHeight)", completionHandler: {  (viewHeight, error) in
                    #if DEBUG
                    if height != nil {
                        print("Resizing: LatexView height changes from \(height!) to \(String(describing: viewHeight))")
                    } else {
                        print("Resizing: LatexView content height changed to \(String(describing: viewHeight))")
                    }
                    #endif
                    if viewHeight as! Int == 0 {
                        #if DEBUG
                        print("Resizing: 0 not accepted, try again")
                        #endif
                        usleep(10000)
                        waitingLoadAndResize(uiView!, context: context)
                    } else {
                        if height != nil {
                            height = (viewHeight as! CGFloat)
                        }
                    }
                })
            } else {
                #if DEBUG
                print("Resizing: LatexView loading not complete: \(complete as! String), waiting and retry...")
                #endif
                usleep(10000)
                waitingLoadAndUpdateLatex(uiView!, context: context)
            }
        })
    }
}
