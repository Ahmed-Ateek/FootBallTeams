import Foundation
import UIKit
import SDWebImage

import Photos

extension UIViewController {
    
   
    func alertUserWithHandler(title:String,message: String,handler:((UIAlertAction)->Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          
            let doneAction = UIAlertAction(title: "Done", style: .cancel, handler: handler)
            alert.addAction(doneAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func alertToGoToSettings(title: String, message: String) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment:"" ), style: .default, handler: { action in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            })
            controller.addAction(cancelAction)
            controller.addAction(settingsAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func datePicker(txt : UITextField,handler : (()->())?) {
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        myDatePicker.timeZone = .current
       // myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
       // self.present(dateChooserAlert, animated: true, completion: nil)

        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alertController.view.addSubview(myDatePicker)
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 300)

        alertController.view.addConstraint(height)

        
        let selectAction = UIAlertAction(title: "موافق", style: .default, handler: { _ in
            txt.text = myDatePicker.date.getFormattedDate()
            handler?()
        })

        let cancelAction = UIAlertAction(title: "الغاء", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    func convertDateFormaterForDateOnly( date: String) -> String
       {
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale(identifier: "en_US_POSIX") // edited
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
           let date = dateFormatter.date(from:date)!
           dateFormatter.dateFormat = "yyyy-MM-dd"
           let dateString = dateFormatter.string(from:date)
           return dateString
           
       }
}
extension Date{
    func getFormattedDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"

        dateFormatter.locale = Locale(identifier: "en_US")
        let formateDate = dateFormatter.string(from: self)
        

        // dateFormatter.dateFormat = "dd-MM-yyyy"
        //         dateFormatter.dateFormat = "yyyy-MM-dd"
        print(formateDate)
        return formateDate
    }
    func getFormattedTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")

        //        dateFormatter.dateFormat = "yyyy-MM-dd’T’HH:mm:ssZZZZZ"
        let formateDate = dateFormatter.string(from: self)

        //dateFormatter.timeStyle = .short
        //        return dateFormatter.string(from: formateDate)
        print(formateDate)

        return formateDate
    }
    func getFormatedDateAndTime() -> String{
        let formatDate  = getFormattedDate()
        let formateTime = getFormattedTime()
        let result = "\(formatDate) \(formateTime)"
        print(result)
        return result
    }
   
}

extension UIView {
    func addFloutinButton()  {
        //        let actionButton = JJFloatingActionButton()
        //
        //               actionButton.addItem(title: "item 1", image: UIImage(named: "First")?.withRenderingMode(.alwaysTemplate)) { item in
        //                print("one")
        //               }
        //
        //               actionButton.addItem(title: "item 2", image: UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)) { item in
        //                print("two")
        //               }
        //
        //               actionButton.addItem(title: "item 3", image: nil) { item in
        //                   print("three")
        //               }
        //
        //               self.addSubview(actionButton)
        //               actionButton.translatesAutoresizingMaskIntoConstraints = false
        //        actionButton.centerXAnchor.constraint(equalToSystemSpacingAfter: self.centerXAnchor, multiplier: 0).isActive = true
        //               //actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        //        actionButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
    }
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        },completion: {(true) in
            self.layoutIfNeeded()
        })
    }
    
    func removeBindToKeyboard(){
        NotificationCenter.default.removeObserver(self)
    }
}

extension UIImageView {
    
    func addImage(withImage image: String?, andPlaceHolder holder: String) {
        let placeHolder = UIImage(named: holder)
        if let imageURL = URL(string: image ?? "") {
        
            self.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.sd_setImage(with: imageURL, placeholderImage: placeHolder, options: [], completed: { (_, error,_ , _) in
                if error != nil {
                    self.image = placeHolder
                }
            })
        }else {
            self.image = placeHolder
        }
    }
}

extension NSDate {
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}

extension String {
    
    func toDate(dateFormat format  : String)-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

extension Date {
    
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
    func toString(dateFormat format  : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension UINavigationBar {
    
    func setGradientBackground(colors: [Any]) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.locations = [0.0 , 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.endPoint =  CGPoint(x: 0.0, y: 0.5)
        var updatedFrame = self.bounds
        updatedFrame.size.height += self.frame.origin.y
        gradient.frame = updatedFrame
        gradient.colors = colors;
        self.setBackgroundImage(self.image(fromLayer: gradient), for: .default)
    }
    
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
}

extension UIColor {
    
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
extension PHAsset {
    
    var images : [UIImage] {
        var thumbnail = [UIImage]()
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: self, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil, resultHandler: { image, _ in
            thumbnail = [image!]
        })
        return thumbnail
    }
}
extension UIAlertController{
    static func signOutConfirmation(onConfirm:@escaping () -> Void) ->UIAlertController{
        let ok = UIAlertAction(title:"", style: .default){_ in onConfirm()}
        let cancel = UIAlertAction(title: "", style: .cancel) {_ in }
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        return alert
    }
}
extension CAGradientLayer {
    enum Point {
        case topLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case centerRight
        case bottomRight
        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}
extension Date {
    func convertDateFormater( date: String) -> String
    {
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return  dateFormatter.string(from: date ?? Date())
        
    }
    
}
 extension UILabel {

    // MARK: - spacingValue is spacing that you need
    func addInterlineSpacing(spacingValue: CGFloat = 2) {

        // MARK: - Check if there's any text
        guard let textString = text else { return }

        // MARK: - Create "NSMutableAttributedString" with your text
        let attributedString = NSMutableAttributedString(string: textString)

        // MARK: - Create instance of "NSMutableParagraphStyle"
        let paragraphStyle = NSMutableParagraphStyle()

        // MARK: - Actually adding spacing we need to ParagraphStyle
        paragraphStyle.lineSpacing = spacingValue

        // MARK: - Adding ParagraphStyle to your attributed String
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))

        // MARK: - Assign string that you've modified to current attributed Text
        attributedText = attributedString
    }

}
extension UINavigationItem{
    override open func awakeFromNib() {
        super.awakeFromNib()
        let backItem = UIBarButtonItem()
        backItem.title = "رجوع"

       // backItem.setTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -5), for: UIBarMetrics.default)
        self.backBarButtonItem = backItem
    }

}

extension CGFloat {
    
    
    var deviceRatio:CGFloat {
        return (UIScreen.main.bounds.width / 375) * self
    }
    
}
extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
