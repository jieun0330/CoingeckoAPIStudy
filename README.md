# 💰 비트코인
<picture>![Group 517167400](https://github.com/jieun0330/CoingeckoAPIStudy/assets/42729069/57a5f60e-4208-4739-a4db-a9d6eb851319)</picture>

### 코인을 검색하고 즐겨찾기로 손쉽게 관리할 수 있는 앱
* `트렌딩 정보` 최신 Coin 및 NFT 트렌딩 정보 제공
* `코인 검색` Coingecko Search API를 통해 코인 검색
* `코인 즐겨찾기` 즐겨찾기한 코인의 실시간 가격 확인
* `차트 화면` 코인에 대한 시장 데이터를 시각적으로 확인

<br/>

## ⚒️ 스크린샷
<picture>![Group 517167401](https://github.com/jieun0330/CoingeckoAPIStudy/assets/42729069/3c0b99cf-fe97-41ac-bd2f-b8879c51b96c)</picture>


<br/>



<br/>

## 🔨 개발기간
2024년 2월 27일 ~ 3월 3일 (약 6일, 업데이트 진행중)

<br/>

## ⚙️ 앱 개발 환경
- 최소 버전: iOS 17.4
- iPhone SE ~ iPhone 15 Pro Max 기기 대응

<br/>

## 🛠️ 사용기술 및 라이브러리
`UIKit(Code Base)` `SnapKit` `MVVM` `Custom Observable` `DGCharts` `Then` `Realm` `Alamofire` `FlowLayout` `Singleton` `BaseViewController` `access control` `Coinecko API`

<br/>

## 🔧 구현 고려사항
- Custom Observable을 활용한 비동기 데이터 스트림 관리
- MVVM 패턴 적용으로 ViewController와 ViewModel간의 명확한 역할 분담
- ViewModel을 통한 비동기 API 호출 관리 및 데이터 바인딩 처리
- 네트워크 요청 및 데이터 처리 과정에서 발생할 수 있는 오류 처리 관리
- 테이블 뷰 및 컬렉션 뷰의 셀 로딩 및 재사용 최적화를 통한 스크롤 성능 향상
- 캡쳐리스트를 사용한 메모리 누수 방지
- Realm을 사용한 지속적인 데이터 관리
- BaseViewController를 활용한 코드 재사용성 증대 및 유지보수 용이성 확보


<br/>



## ⛏️ Trouble Shooting


**❌ 문제 상황**
<br/>
각 API 호출부마다 URL을 작성하는 코드가 중복되어, 새로운 엔드포인트가 추가될 때마다 모든 관련 코드를 수정해야 하는 문제 발생

**⭕️ 해결 방법**
- API URL 생성 로직을 CoinAPI라는 열거형으로 통합
- 각 API 엔드포인트에 대한 URL 생성을 중앙에서 관리할 수 있게 되어, 코드 중복을 줄이고 의존성을 낮춤





```swift
enum CoinAPI {
    case search(query: String)
    case market(query: String)
    case trending
    
    var baseURL: String {
        return "https://api.coingecko.com/api/v3/"
    }
    
    var endpoint: URL {
        switch self {
        case .search(let query):
            return URL(string: "\(baseURL)search?query=\(query)")!
        case .market(let query):
            return URL(string: "\(baseURL)coins/markets?vs_currency=krw&ids=\(query)&sparkline=true")!
        case .trending:
            return URL(string: "\(baseURL)search/trending")!
        }
    }
}
```

<br/>



**❌ 문제 상황**
<br/>

데이터를 초기화면에 표시하는데 문제 발생, 뷰를 스크롤할 때만 데이터가 나타나는 이상한 현상 발생

**⭕️ 해결 방법**
- tableView.reloadData()를 호출하여 데이터 소스의 변경을 인식하고 UI 즉시 업데이트


```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.idList()
    
    viewModel.outputMarketAPI.bind { data in
        self.priceAPIResult = data
        self.tableView.reloadData()
    }
    
    viewModel.outputTrendingCoinAPI.bind { data in
        self.topCoinAPIResult = data
        self.tableView.reloadData()
    }

    viewModel.outputTrendingNFTAPI.bind { data in
        self.topNFTAPIResult = data
        self.tableView.reloadData()
    }
}
```
