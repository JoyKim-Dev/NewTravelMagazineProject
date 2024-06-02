//
//  ReuseIdentifierProtocol.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 6/2/24.
//

import UIKit

// 프로토콜로 만들어두면 더 키워드 강제성을 줄 수 있음. 오타 방지됨. 누락 방지됨. 협업할 때 휴먼 에러를 최소화할 수 있고, 규격화되어 있어서 코드 이해에 도움
// identifier 매번 타입 프로퍼티로 만들 필요 없음

protocol ReuseIdentifierProtocol {
    
    static var identifier: String {get}
}

// UIViewController을 상속받은 모든 곳에서 익스텐션 내부 코드를 호출해서 활용 가능.
extension UIViewController: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

// UITableViewCell을 상속받은 모든 곳에서 익스텐션 내부 코드를 호출해서 활용 가능.
extension UITableViewCell: ReuseIdentifierProtocol {
   
    // 프로퍼티명은 재사용 가능하지만, 거기에 할당할 값은 사용하는 애들마다 각기 다를 것이기에 연산 프로퍼티로 이용하게 됨. 그리고 값이 변경되는 것이니까 let이 아닌 var로 진행. set이 없는 연산 프로퍼티이고 한줄이라 get 키워드도 삭제.
    static var identifier: String {
        return String(describing: self) // 여기서 self는 클래스의 인스턴스를 일컬음.
    }
    
}
