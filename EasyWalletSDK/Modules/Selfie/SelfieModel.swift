import Foundation

class SelfieModel: BaseViewModel {
    
    @Published var zolozInitialFaceResponse: ZolozInitialFaceResponse?
    @Published var zolozCheckResultFaceResponse: ZolozCheckResultFaceResponse?
 
    func initialFaceZoloz(req: ZolozInitialFaceRequest) {
        callZolozInitialFaceCapture(request: req) { [weak self] in
            guard self != nil else { return }
        }
    }
    func doZolozCheckFaceResult(req: ZolozCheckResultFaceRequest) {
        callZolozCheckResultFaceCapture(request: req) { [weak self] in
            guard self != nil else { return }
        }
    }
        
    private func callZolozInitialFaceCapture(request: ZolozInitialFaceRequest, completion: @escaping CompletionBlock) {
        showLoading(isShow: true)
        NetworkService.requestApi(.zolozInitialFaceCapture,
                                  request: request,
                                  completion: { [weak self] (res: ZolozInitialFaceResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.zolozInitialFaceResponse = res
            completion()
        }) { (error) in
            self.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }

    private func callZolozCheckResultFaceCapture(request: ZolozCheckResultFaceRequest, completion: @escaping CompletionBlock) {
        self.showLoading(isShow: true)
        NetworkService.requestApi(.zolozCheckResultFaceCapture,
                                  request: request,
                                  completion: {[weak self] (res: ZolozCheckResultFaceResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.zolozCheckResultFaceResponse = res
           
            completion()
        }) { [weak self] (error) in
            self?.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }
}
