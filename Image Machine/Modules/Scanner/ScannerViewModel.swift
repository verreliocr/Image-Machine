//
//  ScannerViewModel.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 03/12/22.
//

import Foundation
import UIKit

class ScannerViewModel: IScannerViewModel, IModule {
    weak var view: IScannerView?
    weak var delegate: ISCannerDelegate?
    var router: IRouter
    
    init(router: IRouter) {
        self.router = router
    }
    
    func setView(_ view: IScannerView) {
        self.view = view
    }
    
    func resolve(using params: [String : Any]) -> UIViewController {
        delegate = params["delegate"] as? ISCannerDelegate
        let view = ScannerView(viewModel: self)
        self.setView(view)
        
        return view
    }
    
    func viewLoaded() {
        view?.reloadView()
    }
    
    func scannerDidScan(with id: String) {
        delegate?.scannerDidScan(with: id)
    }
}
