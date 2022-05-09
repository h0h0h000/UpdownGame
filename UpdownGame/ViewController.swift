//
//  ViewController.swift
//  UpdownGame
//
//  Created by 박경호 on 2022/05/07.
//

import UIKit

class ViewController: UIViewController {
    
    var randomValue : Int = 0
    var tryCount : Int = 0

    //스토리 보드 위에 있는 화면 요소를 변수로 가져온다.
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLable : UILabel!
    @IBOutlet weak var sliderValueLable : UILabel!
    @IBOutlet weak var minimumValueLabel : UILabel!
    @IBOutlet weak var maximumValueLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slider.setThumbImage(#imageLiteral(resourceName: "slider_thumb.png"), for: .normal)
        reset()
        
        
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        let integerValue : Int = Int(sender.value)
        print(integerValue)
        sliderValueLable.text = String(integerValue)
    }
    
    @IBAction func touchUpHitButton(_ sender: UIButton) {
        let hitValue : Int = Int(slider.value)
        /*
         정수를 실수형으로 바꿈으로서 값 보정이 가능하다.
         즉, hitValue는 출력되는(내부적인)값을 말하는 반면,
         slider.value는  외부적인(보여지는)값을 뜻한다.
         */
        slider.value = Float(hitValue)
        
        tryCount = tryCount + 1
        //tryCountLable.text = String(tryCount) + " / 5"
        tryCountLable.text = "\(tryCount)/5"
        
        if randomValue == hitValue {
            showAlert(message: "You HIT!!!")
            reset()
            return
        }else if tryCount >= 5 {
            showAlert(message: "You lose...")
            reset()
            return
        } else if randomValue > hitValue {
            slider.minimumValue = Float(hitValue)
            minimumValueLabel.text = String(hitValue)
        } else {
            slider.maximumValue = Float(hitValue)
            maximumValueLabel.text = String(hitValue)
        }
    }
    
    func showAlert(message : String) {
        // UIAlertController는 메시지 창을 구현하기 위해 사용된다.
        // style은 알림창(.alert ) , 액션시트(.actionSheet)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        //Handler는 버튼 클릭시 실행될 구문
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            //버튼 클릭시 실행되는 코드
            self.reset()
        }
        
        alert.addAction(okAction)
        //화면에 보여주는 역할
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        print("touch up reset button")
        reset()
    }
    
    func reset() {
        print("reset !")
        randomValue = Int.random(in: 0...30)
        print(randomValue)
        tryCount = 0
        tryCountLable.text = "0/5"
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 15
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValueLable.text = "15"
    }
    
    
}

