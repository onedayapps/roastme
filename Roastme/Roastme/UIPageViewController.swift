//
//  UIPageViewController.swift
//  Roastme
//
//  Created by Anthony Keelan on 2017-03-26.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import UIKit

private(set) var orderedViewControllers: [UIViewController] = {
  return [newColoredViewController(color: "Notifications"),
          newColoredViewController(color: "Smokehouse"),
          newColoredViewController(color: "Profile")]
}()

private func newColoredViewController(color: String) -> UIViewController {
  return UIStoryboard(name: "Main", bundle: nil) .
    instantiateViewController(withIdentifier: "\(color)ViewController")
}


class ProfileSwipe: UIPageViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  
    
    
    if let firstViewController = orderedViewControllers.first {
      setViewControllers([firstViewController],
                         direction: .forward,
                         animated: true,
                         completion: nil)
      
    }
    
  }
  

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

extension ProfileSwipe: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    return nil
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    return nil
  }
  
}
