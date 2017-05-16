//
//  ViewController.swift
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Private Fields
    
    private var pageControl: UIPageControl!
    private var scrollView: UIScrollView!
    
    private let pageSize = 4;
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Viewの設定
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private Methods
    
    /// Viewの設定
    private func setupView() {
        // Viewの背景色変更
        self.view.backgroundColor = UIColor.cyan
        
        // scrollViewの設定
        self.setupScrollView()
        // pageControlの設定
        self.setupPageControl()
    }
    
    /// scrollViewの設定
    private func setupScrollView() {
        
        // Viewの幅と高さを取得
        let width = self.view.frame.maxX
        let height = self.view.frame.maxY
        
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.delegate = self;
        
        scrollView.contentSize = CGSize(width: CGFloat(pageSize) * width, height: 0)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        
        // ページ数分ラベルを生成し、scrollViewに追加する
        for i in 0 ..< pageSize {
            
            let label = UILabel(frame: CGRect(x: CGFloat(i) * width + width / 2 - 40,
                                              y: height / 2 - 40,
                                              width: 80.0,
                                              height: 80.0))
            label.backgroundColor = UIColor.black
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
            label.text = "Page\(i)"
            
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 40.0
            
            scrollView.addSubview(label)
        }
        
        self.view.addSubview(scrollView)
        
    }
    
    /// pageControlの設定
    private func setupPageControl() {
        // Viewの幅と高さを取得
        let width = self.view.frame.maxX
        
        pageControl = UIPageControl(frame: CGRect(x: 0.0,
                                                  y: self.view.frame.maxY - 100,
                                                  width: width,
                                                  height: 50.0))
        pageControl.backgroundColor = UIColor.orange
        pageControl.numberOfPages = pageSize
        
        // 現在ページ設定
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        
        self.view.addSubview(pageControl)
    }
    
    /// MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // スクロール移動量が1ページ分になった時
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            // pageControlの現在ページを切り替える
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
}

