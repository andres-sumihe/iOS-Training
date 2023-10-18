//
//  ImagePageController.swift
//  training
//
//  Created by P090MMCTSE010 on 13/10/23.
//

import UIKit

class ImagePageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    var pages = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self

        let p1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "viewID1")
        let p2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "viewID2")
        let p3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "viewID3")
        let p4: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "viewID4")


        pages.append(p1)
        pages.append(p2)
        pages.append(p3)
        pages.append(p4)

        setViewControllers([p1], direction: .forward, animated: false, completion: nil)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)-> UIViewController? {
       
        guard let cur = pages.firstIndex(of: viewController) else { return nil }

        // if you prefer to NOT scroll circularly, simply add here:
        // if cur == 0 { return nil }

        var prev = (cur - 1) % pages.count
        if prev < 0 {
            prev = pages.count - 1
        }
        return pages[prev]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)-> UIViewController? {

        guard let cur = pages.firstIndex(of: viewController) else { return nil }

        // if you prefer to NOT scroll circularly, simply add here:
        // if cur == (pages.count - 1) { return nil }

        let nxt = abs((cur + 1) % pages.count)
        return pages[nxt]
    }

    func presentationIndex(for pageViewController: UIPageViewController)-> Int {
        return pages.count
    }

}
