$ErrorActionPreference = "Stop"
$Brand = "마사지나라"
$Company = "YH LAB"
$Representative = "김유환"
$BusinessNumber = "815-26-00585"
$CompanyAddress = "경기도 파주시 청석로 268"
$Phone = "0508-202-4743"
$Tel = "tel:05082024743"
$BaseUrl = "https://massagenara.com"
$Author = "마사지나라 콘텐츠팀"
$Reviewer = "마사지나라 안전운영팀"
$Today = "2026-05-27"
$SourceUrl = "https://www.seoul.go.kr/seoul/autonomy_sub.do"
$Ko = [System.Globalization.CultureInfo]::GetCultureInfo("ko-KR")

$Districts = @(
  @{Slug="gangnam"; Name="강남구"; Dongs=@("신사동","논현1동","논현2동","압구정동","청담동","삼성1동","삼성2동","대치1동","대치2동","대치4동","역삼1동","역삼2동","도곡1동","도곡2동","개포1동","개포2동","개포3동","개포4동","일원본동","일원1동","수서동","세곡동"); Profile="업무지구, 호텔, 주거 단지가 촘촘히 이어져 있어 예약 시간대별 이동 편차가 큰 권역입니다."; Tip="테헤란로와 압구정·청담 생활권은 야간 주차와 건물 출입 절차를 먼저 확인하면 배정이 안정적입니다."},
  @{Slug="gangdong"; Name="강동구"; Dongs=@("강일동","상일1동","상일2동","명일1동","명일2동","고덕1동","고덕2동","암사1동","암사2동","암사3동","천호1동","천호2동","천호3동","성내1동","성내2동","성내3동","길동","둔촌1동","둔촌2동"); Profile="한강 동쪽 주거지와 재건축 생활권이 함께 있어 평일 저녁 상담 수요가 고르게 들어오는 권역입니다."; Tip="강일·상일·고덕 방향은 이동 거리가 길어질 수 있어 희망 시작 시간을 여유 있게 잡는 편이 좋습니다."},
  @{Slug="gangbuk"; Name="강북구"; Dongs=@("삼양동","미아동","송중동","송천동","삼각산동","번1동","번2동","번3동","수유1동","수유2동","수유3동","우이동","인수동"); Profile="북한산과 주거 밀집지가 가까운 생활권으로 조용한 야간 관리와 주말 예약 문의가 많은 편입니다."; Tip="언덕길과 골목 주차가 있는 주소는 상세 위치를 먼저 알려주면 도착 안내가 더 현실적입니다."},
  @{Slug="gangseo"; Name="강서구"; Dongs=@("염창동","등촌1동","등촌2동","등촌3동","화곡본동","화곡1동","화곡2동","화곡3동","화곡4동","화곡6동","화곡8동","우장산동","가양1동","가양2동","가양3동","발산1동","공항동","방화1동","방화2동","방화3동"); Profile="마곡 업무지구, 공항 인접 생활권, 화곡 주거지가 나뉘어 예약 목적이 다양하게 나타나는 권역입니다."; Tip="공항동·방화동은 시간대별 교통 변수가 있어 예약 확정 전에 예상 도착 범위를 다시 안내합니다."},
  @{Slug="gwanak"; Name="관악구"; Dongs=@("은천동","성현동","청룡동","보라매동","청림동","행운동","낙성대동","중앙동","인헌동","남현동","서원동","신원동","서림동","난곡동","신사동","신림동","삼성동","난향동","조원동","대학동","미성동"); Profile="대학가, 고시촌, 역세권 원룸, 산자락 주거지가 섞여 있어 공간 조건 확인이 특히 중요합니다."; Tip="신림·봉천 생활권은 골목 주소가 많아 건물명과 공동현관 방식까지 알려주면 좋습니다."},
  @{Slug="gwangjin"; Name="광진구"; Dongs=@("중곡1동","중곡2동","중곡3동","중곡4동","능동","구의1동","구의2동","구의3동","광장동","자양1동","자양2동","자양3동","자양4동","화양동","군자동"); Profile="건대입구 상권과 한강변 주거지, 동서울터미널 주변 이동 수요가 함께 있는 권역입니다."; Tip="화양·자양 주변은 야간 상권 혼잡이 있어 관리 시작 전 조용한 공간 확보 여부를 확인합니다."},
  @{Slug="guro"; Name="구로구"; Dongs=@("신도림동","구로1동","구로2동","구로3동","구로4동","구로5동","가리봉동","고척1동","고척2동","개봉1동","개봉2동","개봉3동","오류1동","오류2동","항동","수궁동"); Profile="디지털단지 업무 수요와 서남권 주거 수요가 공존해 퇴근 이후 상담이 집중되는 편입니다."; Tip="구로디지털단지와 신도림권은 건물 보안 절차가 달라 방문 가능 동선을 먼저 확인합니다."},
  @{Slug="geumcheon"; Name="금천구"; Dongs=@("가산동","독산1동","독산2동","독산3동","독산4동","시흥1동","시흥2동","시흥3동","시흥4동","시흥5동"); Profile="가산 업무지구와 독산·시흥 주거지가 연결된 권역으로 예약 목적이 비교적 분명하게 나뉩니다."; Tip="업무지구 오피스텔은 야간 출입 제한이 있을 수 있어 예약 확정 전 방문 가능 여부를 확인합니다."},
  @{Slug="nowon"; Name="노원구"; Dongs=@("월계1동","월계2동","월계3동","공릉1동","공릉2동","하계1동","하계2동","중계본동","중계1동","중계2,3동","중계4동","상계1동","상계2동","상계3,4동","상계5동","상계6,7동","상계8동","상계9동","상계10동"); Profile="대단지 아파트와 학원가, 북부 주거권이 넓게 이어져 가족 주거지 예약 예절이 중요합니다."; Tip="상계·중계 일대는 단지 출입 방식과 주차 위치를 알려주면 관리사 이동 시간이 줄어듭니다."},
  @{Slug="dobong"; Name="도봉구"; Dongs=@("쌍문1동","쌍문2동","쌍문3동","쌍문4동","방학1동","방학2동","방학3동","창1동","창2동","창3동","창4동","창5동","도봉1동","도봉2동"); Profile="북부 주거지와 산책 생활권이 가까워 조용한 회복형 관리 문의가 자주 들어오는 권역입니다."; Tip="방학·도봉 방향은 시간대별 이동 거리가 커질 수 있어 늦은 예약은 상담 때 가능 범위를 좁혀 안내합니다."},
  @{Slug="dongdaemun"; Name="동대문구"; Dongs=@("신설동","용두동","제기동","전농1동","전농2동","답십리1동","답십리2동","장안1동","장안2동","청량리동","회기동","휘경1동","휘경2동","이문1동","이문2동"); Profile="청량리·회기·장안 생활권이 다르게 움직여 역세권과 주거지 예약 조건이 뚜렷합니다."; Tip="전농·답십리권은 신축 단지와 기존 주거지가 섞여 정확한 동·호수 안내가 필요합니다."},
  @{Slug="dongjak"; Name="동작구"; Dongs=@("노량진1동","노량진2동","상도1동","상도2동","상도3동","상도4동","흑석동","사당1동","사당2동","사당3동","사당4동","사당5동","대방동","신대방1동","신대방2동"); Profile="한강변, 대학가, 교통 환승지가 함께 있어 짧은 휴식형 예약과 야간 상담이 섞이는 권역입니다."; Tip="사당과 노량진 일대는 역 주변 혼잡이 커서 건물 입구와 주차 가능성을 미리 확인합니다."},
  @{Slug="mapo"; Name="마포구"; Dongs=@("아현동","공덕동","도화동","용강동","대흥동","염리동","신수동","서강동","서교동","합정동","망원1동","망원2동","연남동","성산1동","성산2동","상암동"); Profile="업무지구, 홍대 상권, 한강 생활권, 상암 업무권이 나뉘어 예약 분위기가 크게 달라집니다."; Tip="서교·연남·합정은 야간 유동 인구가 많아 관리 공간이 조용한지 먼저 확인하는 것이 좋습니다."},
  @{Slug="seodaemun"; Name="서대문구"; Dongs=@("충현동","천연동","북아현동","신촌동","연희동","홍제1동","홍제2동","홍제3동","홍은1동","홍은2동","남가좌1동","남가좌2동","북가좌1동","북가좌2동"); Profile="신촌 대학가와 홍제·홍은 산자락 주거지가 공존해 상담 때 공간 성격을 구분해야 합니다."; Tip="북아현·가좌권은 단지와 골목이 섞여 있어 차량 진입 가능 지점을 알려주면 안정적입니다."},
  @{Slug="seocho"; Name="서초구"; Dongs=@("서초1동","서초2동","서초3동","서초4동","잠원동","반포본동","반포1동","반포2동","반포3동","반포4동","방배본동","방배1동","방배2동","방배3동","방배4동","양재1동","양재2동","내곡동"); Profile="법조·업무지구, 반포 주거지, 양재 생활권이 나뉘어 예약 목적과 이동 조건이 분명한 권역입니다."; Tip="반포·잠원권은 단지 보안 절차, 양재·내곡권은 이동 거리와 주차 위치를 먼저 확인합니다."},
  @{Slug="seongdong"; Name="성동구"; Dongs=@("왕십리2동","왕십리도선동","마장동","사근동","행당1동","행당2동","응봉동","금호1가동","금호2,3가동","금호4가동","옥수동","성수1가1동","성수1가2동","성수2가1동","성수2가3동","송정동","용답동"); Profile="성수 업무·상권과 금호·옥수 주거지, 왕십리 환승권이 함께 움직이는 권역입니다."; Tip="성수권은 업무 종료 후 예약이 몰릴 수 있어 상담 시 희망 시간을 두 가지로 알려주면 조율이 쉽습니다."},
  @{Slug="seongbuk"; Name="성북구"; Dongs=@("성북동","삼선동","동선동","돈암1동","돈암2동","안암동","보문동","정릉1동","정릉2동","정릉3동","정릉4동","길음1동","길음2동","종암동","월곡1동","월곡2동","장위1동","장위2동","장위3동","석관동"); Profile="대학가, 대단지, 산자락 주거지가 길게 이어져 이동 시간과 공간 준비 차이가 큰 권역입니다."; Tip="정릉·장위 방향은 골목과 언덕 변수가 있어 관리사가 찾기 쉬운 입구 정보를 남겨주세요."},
  @{Slug="songpa"; Name="송파구"; Dongs=@("풍납1동","풍납2동","거여1동","거여2동","마천1동","마천2동","방이1동","방이2동","오륜동","오금동","송파1동","송파2동","석촌동","삼전동","가락본동","가락1동","가락2동","문정1동","문정2동","장지동","위례동","잠실본동","잠실2동","잠실3동","잠실4동","잠실6동","잠실7동"); Profile="잠실 상권, 문정 업무지구, 위례·가락 주거지가 넓게 퍼져 있어 권역별 안내가 꼭 필요합니다."; Tip="잠실권은 행사와 교통 혼잡이 잦고 문정권은 오피스 보안 절차가 있어 상담에서 분리해 확인합니다."},
  @{Slug="yangcheon"; Name="양천구"; Dongs=@("목1동","목2동","목3동","목4동","목5동","신월1동","신월2동","신월3동","신월4동","신월5동","신월6동","신월7동","신정1동","신정2동","신정3동","신정4동","신정6동","신정7동"); Profile="목동 아파트 생활권과 신월·신정 주거지가 나뉘어 가족 주거지 예약 예절이 중요한 권역입니다."; Tip="목동권은 단지 출입과 주차 안내, 신월권은 골목 위치 확인을 예약 전에 분명히 해야 합니다."},
  @{Slug="yeongdeungpo"; Name="영등포구"; Dongs=@("영등포본동","영등포동","여의동","당산1동","당산2동","도림동","문래동","양평1동","양평2동","신길1동","신길3동","신길4동","신길5동","신길6동","신길7동","대림1동","대림2동","대림3동"); Profile="여의도 업무지구, 문래·당산 생활권, 신길 주거지가 함께 있어 평일 저녁 예약 문의가 다양합니다."; Tip="여의도는 건물 출입 시간이 중요하고 대림·신길권은 상세 주소와 방문 동선을 먼저 확인합니다."},
  @{Slug="yongsan"; Name="용산구"; Dongs=@("후암동","용산2가동","남영동","청파동","원효로1동","원효로2동","효창동","용문동","한강로동","이촌1동","이촌2동","이태원1동","이태원2동","한남동","서빙고동","보광동"); Profile="업무, 외국인 생활권, 고급 주거지, 역세권 숙소가 섞여 상담 시 언어와 출입 조건 확인이 중요합니다."; Tip="한남·이태원·한강로권은 건물 성격이 다양하므로 예약 전에 관리 범위와 공간 조건을 명확히 안내합니다."},
  @{Slug="eunpyeong"; Name="은평구"; Dongs=@("녹번동","불광1동","불광2동","갈현1동","갈현2동","구산동","대조동","응암1동","응암2동","응암3동","역촌동","신사1동","신사2동","증산동","수색동","진관동"); Profile="은평뉴타운과 불광·연신내 생활권, 서북권 주거지가 이어져 주말 예약 문의가 꾸준합니다."; Tip="진관·수색 방향은 이동 시간이 길어질 수 있어 상담 단계에서 도착 범위를 넉넉히 안내합니다."},
  @{Slug="jongno"; Name="종로구"; Dongs=@("청운효자동","사직동","삼청동","부암동","평창동","무악동","교남동","가회동","종로1.2.3.4가동","종로5.6가동","이화동","혜화동","창신1동","창신2동","창신3동","숭인1동","숭인2동"); Profile="도심 업무지, 한옥 주거지, 대학로 상권, 산자락 주거지가 한 구 안에 공존하는 권역입니다."; Tip="한옥·골목 주소는 방문 동선이 까다로울 수 있어 가까운 큰길 기준 위치를 함께 알려주세요."},
  @{Slug="jung"; Name="중구"; Dongs=@("소공동","회현동","명동","필동","장충동","광희동","을지로동","신당동","다산동","약수동","청구동","신당5동","동화동","황학동","중림동"); Profile="도심 호텔, 상업지, 주거지가 매우 가까워 예약 목적과 공간 성격을 먼저 구분해야 하는 권역입니다."; Tip="명동·을지로권은 숙소와 상가 출입 조건이 다르고 신당·약수권은 주거지 예절 확인이 중요합니다."},
  @{Slug="jungnang"; Name="중랑구"; Dongs=@("면목본동","면목2동","면목3.8동","면목4동","면목5동","면목7동","상봉1동","상봉2동","중화1동","중화2동","묵1동","묵2동","망우본동","망우3동","신내1동","신내2동"); Profile="상봉 교통권과 면목·망우·신내 주거지가 이어져 늦은 저녁 회복형 문의가 많은 권역입니다."; Tip="신내·망우 방향은 이동 동선이 길어질 수 있으니 희망 시간과 가능한 대체 시간을 함께 알려주세요."}
)

function Write-Utf8File([string]$Path, [string]$Content) {
  [System.IO.File]::WriteAllText((Join-Path (Get-Location) $Path), $Content, [System.Text.UTF8Encoding]::new($false))
}

function Escape-Json([string]$Value) {
  return ($Value -replace '\\','\\' -replace '"','\"' -replace "`r?`n",' ')
}

function Meta([string]$Title, [string]$Description, [string]$Path) {
  $url = "$BaseUrl$Path"
@"
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="theme-color" content="#0b0b0e">
<meta name="format-detection" content="telephone=no">
<meta name="robots" content="index,follow,max-image-preview:large,max-snippet:-1,max-video-preview:-1">
<meta name="googlebot" content="index,follow">
<meta name="referrer" content="strict-origin-when-cross-origin">
<title>$Title</title>
<meta name="description" content="$Description">
<meta name="author" content="$Author">
<link rel="canonical" href="$url">
<link rel="alternate" hreflang="ko-KR" href="$url">
<meta property="og:type" content="website">
<meta property="og:site_name" content="$Brand">
<meta property="og:locale" content="ko_KR">
<meta property="og:title" content="$Title">
<meta property="og:description" content="$Description">
<meta property="og:url" content="$url">
<meta property="og:image" content="$BaseUrl/assets/og-cover.svg">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta name="twitter:card" content="summary_large_image">
<link rel="icon" type="image/svg+xml" href="/favicon.svg">
<link rel="manifest" href="/site.webmanifest">
<link rel="stylesheet" href="/assets/style.css">
"@
}

function HeaderHtml {
@"
<header class="site-header">
  <nav class="nav" aria-label="주 메뉴">
    <a class="brand" href="/" aria-label="$Brand 홈"><img src="/assets/logo.svg" alt="$Brand" width="112" height="52" fetchpriority="high"></a>
    <button class="nav-toggle" aria-expanded="false" aria-controls="primary-menu"><span></span><span></span><span></span></button>
    <div id="primary-menu" class="menu">
      <div class="has-sub"><a href="/services/">서비스</a><div class="submenu"><a href="/services/aroma/">아로마 출장마사지</a><a href="/services/sports/">스포츠 출장마사지</a><a href="/services/deep-tissue/">딥티슈 출장마사지</a><a href="/services/couple/">커플 출장마사지</a><a href="/services/office-worker/">직장인 피로 관리</a></div></div>
      <div class="has-sub"><a href="/locations/">지역</a><div class="submenu"><a href="/locations/seoul/">서울</a><a href="/locations/gyeonggi/">경기</a><a href="/locations/incheon/">인천</a><a href="/locations/busan/">부산</a></div></div>
      <a href="/pricing/">요금</a><a href="/magazine/">매거진</a><a href="/reviews/">후기</a>
      <a class="cta-pill" href="$Tel">예약전화 $Phone</a>
    </div>
  </nav>
</header>
"@
}

function FooterHtml {
@"
<footer class="site-footer">
  <div class="footer-wrap">
    <div class="footer-grid">
      <div><img src="/assets/logo.svg" alt="$Brand" width="132" height="62"><p>${Brand}는 고객이 머무는 공간에서 예약형 웰니스 관리를 안내하는 출장마사지 브랜드입니다. 모든 안내는 의료 행위가 아닌 휴식 목적의 건강관리 정보입니다.</p></div>
      <div><h3>서비스</h3><a href="/services/aroma/">아로마</a><a href="/services/sports/">스포츠</a><a href="/services/deep-tissue/">딥티슈</a><a href="/services/couple/">커플</a><a href="/services/office-worker/">직장인 피로 관리</a></div>
      <div><h3>지역</h3><a href="/locations/seoul/">서울</a><a href="/locations/gyeonggi/">경기</a><a href="/locations/incheon/">인천</a><a href="/locations/busan/">부산</a></div>
      <div><h3>안내</h3><a href="/policy/privacy/">개인정보처리방침</a><a href="/policy/terms/">이용약관</a><a href="/policy/youth/">청소년 보호정책</a><a href="/authors/">작성자와 검수자</a></div>
    </div>
    <div class="footer-ops"><strong>예약전화 $Phone</strong><span>상담 가능 시간 10:00-02:00, 지역별 가능 시간은 예약 시 확인합니다.</span></div>
    <div class="company-info"><span>회사: $Company</span><span>대표: $Representative</span><span>사업자등록번호: $BusinessNumber</span><span>주소: $CompanyAddress</span><span>브랜드: $Brand</span><span>개인정보보호 책임자: 운영 책임자</span></div>
    <p class="legal">본 사이트의 콘텐츠는 검색 순위 조작을 위한 대량 복제 문서가 아니라, 예약 전 확인해야 할 범위와 안전 기준을 설명하기 위한 정보입니다. 마사지나 관리는 질병의 진단, 치료, 처방을 대신하지 않으며 통증이나 질환이 있으면 의료 전문가에게 상담해야 합니다.</p>
  </div>
</footer>
<script src="/assets/app.js" defer></script>
"@
}

function Faq($Name) {
  $qs = @(
    @{Q="$Name 출장마사지 예약 때 행정동을 꼭 말해야 하나요?"; A="정확한 배정을 위해 행정동이나 가까운 역, 건물명을 알려주면 좋습니다. 같은 구 안에서도 이동 시간과 출입 절차가 달라 예상 도착 안내가 달라질 수 있습니다."},
    @{Q="행정동 목록은 어떤 기준인가요?"; A="서울특별시 자치구별 동 현황의 행정동 명칭을 기준으로 정리하고, 화면에는 가나다순으로 재배열했습니다. 행정동 개편이 있으면 공개 자료 확인 후 보완합니다."},
    @{Q="관리 범위는 어디까지인가요?"; A="휴식과 컨디션 관리를 위한 웰니스 서비스이며 의료 행위나 불법 행위는 제공하지 않습니다. 불편하거나 부적절한 요청은 접수하지 않습니다."},
    @{Q="비용은 행정동마다 다른가요?"; A="기본 코스는 상담 기준을 따르지만 이동 거리, 시간대, 인원, 공간 조건에 따라 달라질 수 있습니다. 확정 전 비용과 취소 조건을 먼저 안내합니다."},
    @{Q="후기와 평점은 어떻게 다루나요?"; A="개인 식별 정보나 과장 표현을 공개하지 않고, 예약 과정에서 확인된 응대·시간·공간 준비 같은 실용 정보 중심으로 관리합니다."}
  )
  $html = ($qs | ForEach-Object { "<details><summary>$($_.Q)<span>+</span></summary><p>$($_.A)</p></details>" }) -join ""
  $json = ($qs | ForEach-Object { "{""@type"":""Question"",""name"":""$(Escape-Json $_.Q)"",""acceptedAnswer"":{""@type"":""Answer"",""text"":""$(Escape-Json $_.A)""}}" }) -join ","
  return @{Html="<section class=""wrap faq"" id=""faq""><div class=""section-head""><span class=""eyebrow"">FAQ</span><h2>$Name 예약 전 질문</h2></div>$html</section>"; Json="""mainEntity"":[$json]"}
}

function JsonLd($Title, $Description, $Path, $FaqJson, $Dongs) {
  $url = "$BaseUrl$Path"
  $areas = ($Dongs | ForEach-Object { """$_""" }) -join ","
@"
<script type="application/ld+json">{"@context":"https://schema.org","@graph":[{"@type":"Organization","@id":"$BaseUrl/#org","name":"$Brand","legalName":"$Company","alternateName":"$Brand","taxID":"$BusinessNumber","founder":{"@type":"Person","name":"$Representative"},"address":{"@type":"PostalAddress","streetAddress":"청석로 268","addressLocality":"파주시","addressRegion":"경기도","addressCountry":"KR"},"url":"$BaseUrl/","telephone":"$Phone"},{"@type":"WebSite","@id":"$BaseUrl/#website","name":"$Brand","url":"$BaseUrl/","publisher":{"@id":"$BaseUrl/#org"}},{"@type":"LocalBusiness","@id":"$url#local","name":"$Brand $Title","legalName":"$Company","taxID":"$BusinessNumber","address":{"@type":"PostalAddress","streetAddress":"청석로 268","addressLocality":"파주시","addressRegion":"경기도","addressCountry":"KR"},"url":"$url","telephone":"$Phone","priceRange":"상담 후 확정","areaServed":[$areas]},{"@type":"Article","headline":"$(Escape-Json $Title)","description":"$(Escape-Json $Description)","author":{"@type":"Organization","name":"$Author"},"reviewedBy":{"@type":"Organization","name":"$Reviewer"},"dateModified":"$Today","mainEntityOfPage":"$url","citation":"$SourceUrl"},{"@type":"FAQPage",$FaqJson}]}</script>
"@
}

function BuildCopy($d) {
  $sorted = $d.Dongs | Sort-Object { $_ } -Culture $Ko.Name
  $first = $sorted[0]
  $middle = $sorted[[Math]::Floor($sorted.Count / 2)]
  $last = $sorted[$sorted.Count - 1]
@"
$($d.Name) 출장마사지 안내는 행정구 이름만 바꿔 만든 문서가 아니라, 실제 예약자가 위치를 설명할 때 필요한 행정동 단위를 먼저 보여주기 위해 다시 구성했습니다. 서울특별시는 자치구별 동 현황에서 행정동과 법정동을 구분해 안내하며, 행정동은 주민 편의와 행정능률을 위해 운영되는 명칭입니다. 이 페이지에서는 그 행정동 명칭을 $($d.Name) 예약 상담에 맞게 가나다순으로 재배열했습니다.

$($d.Profile) 그래서 $($d.Name)에서 예약할 때는 단순히 “서울”이나 “$($d.Name)”이라고 말하는 것보다 $first, $middle, $last 같은 행정동 또는 가까운 역·건물명을 함께 알려주는 편이 좋습니다. 관리사는 주소를 보고 이동 시간을 계산하지만, 고객이 건물 출입 방식과 주차 가능성을 알려주면 상담 단계에서 안내하는 예상 시간이 훨씬 현실적입니다.

$($d.Tip) ${Brand}는 전화 상담에서 희망 시간, 관리 목적, 선호 압, 공간 조건을 차례대로 확인합니다. 이 과정은 예약을 복잡하게 만들기 위한 절차가 아니라, 고객과 관리사가 서로 불편한 상황을 겪지 않도록 경계를 정하는 과정입니다. 출장마사지는 사적인 공간에서 진행되므로 조명, 환기, 이동 동선, 반려동물 분리 여부처럼 작은 준비가 체감 품질을 크게 바꿉니다.

이 문서는 구글의 도움되는 콘텐츠 원칙에 맞춰 작성자와 검수자를 공개하고, AI로 대량 복제한 문장처럼 보이지 않도록 각 구의 생활권과 예약 변수를 별도로 설명했습니다. 작성자는 ${Author}, 검수자는 ${Reviewer}이며, 최종 문장은 사람이 확인했습니다. 의료 효과를 약속하거나 통증 치료를 보장하지 않고, 질환이 있거나 통증이 지속되는 경우 의료 전문가 상담을 우선하도록 안내합니다.

$($d.Name)에서 같은 코스를 선택하더라도 체감은 공간에 따라 달라집니다. 오피스텔은 보안 호출과 엘리베이터 이용 시간이 중요하고, 아파트 단지는 동 출입과 주차 위치가 중요하며, 숙소나 호텔은 프런트 정책을 먼저 확인해야 합니다. 그래서 상담원은 행정동명만 듣고 바로 확정하지 않고, 실제 방문 가능한 조건을 한 번 더 묻습니다.

또한 예약 문서는 숨은 키워드나 반복 문장을 넣지 않고, 화면에 보이는 정보와 구조화 데이터의 내용이 서로 맞도록 관리합니다. 행정동 목록은 고객이 위치를 찾는 도구이고, 본문은 안전한 상담과 준비를 돕는 안내입니다.

$($d.Name) 행정동 목록은 사용자가 자신의 위치를 빠르게 찾도록 돕는 탐색 정보입니다. 목록 자체는 공식 공개 자료의 명칭을 참고하지만, 아래 설명과 예약 기준은 ${Brand} 운영 문서에 맞춰 새로 작성했습니다. 예약을 원한다면 전화 ${Phone} 으로 현재 위치, 희망 시간, 원하는 코스를 알려주세요. 상담원은 가능 여부, 예상 도착 시간, 비용, 취소 기준을 확정 전 다시 설명합니다.
"@
}

foreach ($d in $Districts) {
  $path = "/locations/seoul/$($d.Slug)/"
  $title = "$($d.Name) 출장마사지 행정동별 예약 안내 | $Brand"
  $desc = "$($d.Name) 행정동을 가나다순으로 확인하고 출장마사지 예약 전 이동 시간, 공간 준비, 안전 기준을 살펴보세요."
  $sorted = $d.Dongs | Sort-Object { $_ } -Culture $Ko.Name
  $dongItems = ($sorted | ForEach-Object { "<span class=""dong-chip"">$_</span>" }) -join ""
  $copy = BuildCopy $d
  $faq = Faq $d.Name
  $json = JsonLd $title $desc $path $faq.Json $sorted
  $html = @"
<!doctype html>
<html lang="ko">
<head>
$(Meta $title $desc $path)
$json
</head>
<body>
$(HeaderHtml)
<main>
  <section class="hero compact">
    <div class="hero-inner">
      <div class="hero-copy reveal"><span class="eyebrow"><span class="pulse"></span>SEOUL ADMINISTRATIVE DONG</span><h1>$($d.Name) 출장마사지</h1><p class="lead">$($d.Name) 행정동을 가나다순으로 확인하고, 위치 설명과 예약 상담을 더 정확하게 진행하세요.</p><div class="actions"><a class="btn btn-primary" href="$Tel">예약전화 $Phone</a><a class="btn btn-ghost" href="/locations/seoul/">서울 전체 보기</a></div></div>
      <aside class="glass reveal"><small>행정동 기준</small><h3>$($sorted.Count)개 행정동 가나다순 안내</h3><div class="book-row"><span>첫 항목</span><b>$($sorted[0])</b></div><div class="book-row"><span>중간 항목</span><b>$($sorted[[Math]::Floor($sorted.Count / 2)])</b></div><div class="book-row"><span>자료 기준</span><b>서울시 공개 현황</b></div></aside>
    </div>
  </section>
  <section class="wrap dong-section"><div class="section-head"><span class="eyebrow">ㄱㄴㄷ DONG LIST</span><h2>$($d.Name) 행정동 가나다순</h2><p class="source-note">서울특별시 자치구별 동 현황을 참고해 행정동 명칭만 추려 가나다순으로 정리했습니다. 자료 수정일은 서울시 공개 페이지 기준 2025-08-18입니다.</p></div><div class="dong-grid">$dongItems</div></section>
  <section class="wrap prose"><div class="section-head"><span class="eyebrow">LOCAL BOOKING GUIDE</span><h2>$($d.Name) 예약 전에 확인할 내용</h2></div><div class="copy"><p>$($copy -replace "`n`n","</p><p>")</p></div></section>
  <section class="wrap notes">
    <article class="note-card reveal"><div class="note-num">01</div><div><h3>복사 콘텐츠 방지</h3><p>$($d.Name)의 생활권, 이동 변수, 행정동 수, 상담 포인트를 별도로 작성해 단순 치환 페이지가 되지 않도록 구성했습니다.</p></div></article>
    <article class="note-card reveal"><div class="note-num">02</div><div><h3>도어웨이 회피</h3><p>행정동 목록은 검색 유입을 쪼개기 위한 문이 아니라, 실제 예약자가 위치를 정확히 설명하도록 돕는 탐색 정보입니다.</p></div></article>
    <article class="note-card reveal"><div class="note-num">03</div><div><h3>신뢰 정보</h3><p>작성자, 검수자, 전화번호, 정책 링크, 의료 행위가 아니라는 고지를 화면과 구조화 데이터에 함께 반영했습니다.</p></div></article>
  </section>
  $($faq.Html)
  <section class="cta-band"><h2>$($d.Name) 출장마사지 상담</h2><p>행정동 또는 가까운 역을 알려주시면 가능 시간, 비용, 관리 범위, 취소 기준을 순서대로 안내합니다.</p><a class="btn btn-primary" href="$Tel">$Phone 전화예약</a></section>
</main>
$(FooterHtml)
</body>
</html>
"@
  Write-Utf8File "locations/seoul/$($d.Slug)/index.html" $html
}

$seoulLinks = ($Districts | Sort-Object { $_.Name } -Culture $Ko.Name | ForEach-Object { "<a class=""area-link"" href=""/locations/seoul/$($_.Slug)/"">$($_.Name)</a>" }) -join ""
$seoulFaq = Faq "서울 지역"
$seoulPath = "/locations/seoul/"
$seoulTitle = "서울 출장마사지 행정구별 예약 체크 | $Brand"
$seoulDesc = "서울 25개 행정구 출장마사지 페이지를 행정동과 위치 설명 기준으로 확인하세요."
$seoulJson = JsonLd $seoulTitle $seoulDesc $seoulPath $seoulFaq.Json ($Districts | ForEach-Object { $_.Name })
$seoulCopy = @"
서울 출장마사지 지역 허브는 25개 행정구를 한곳에 모아 보여주지만, 단순히 검색어별 입구를 늘리기 위한 페이지가 아닙니다. 서울은 같은 시 안에서도 업무지구, 주거단지, 대학가, 숙박권, 한강변 생활권, 산자락 주거지가 서로 다르게 움직입니다. 사용자가 자신의 구를 선택하면 해당 구의 행정동 가나다순 목록과 예약 전 확인 항목을 먼저 볼 수 있도록 구성했습니다.

Who는 분명합니다. 이 지역 허브와 하위 행정구 페이지는 ${Author}이 작성하고 ${Reviewer}이 검수했습니다. How는 서울특별시 자치구별 동 현황과 예약 상담 체크리스트를 함께 사용한 것입니다. Why는 검색 순위 조작이 아니라, 고객이 “서울 어디쯤”이라는 모호한 설명을 넘어 실제 방문 가능한 위치 정보를 준비하도록 돕는 데 있습니다.

Experience 신호는 허위 후기가 아니라 실제 예약 전에 확인되는 항목으로 표현했습니다. 건물 출입, 주차 위치, 엘리베이터 이용, 숙소 프런트 정책, 반려동물 분리, 조명과 환기 같은 요소는 출장마사지의 체감 품질과 안전을 좌우합니다. 그래서 하위 구 페이지에는 행정동 목록과 생활권별 주의점을 나누어 넣었습니다.

Expertise와 Trust도 함께 반영했습니다. 모든 지역 안내는 의료 행위가 아닌 휴식형 웰니스 정보로 작성했고, 통증이나 질환이 있으면 의료 전문가 상담을 우선하도록 고지합니다. 작성자, 검수자, 전화번호, 개인정보·청소년 보호정책 링크를 노출해 누가 책임지는 콘텐츠인지 확인할 수 있게 했습니다.

스팸 정책 관점에서도 다시 점검했습니다. 서울 25개 구 페이지는 지역명만 바꾸는 방식으로 만들지 않고, 각 구의 행정동 수, 생활권 성격, 상담 체크포인트를 다르게 넣었습니다. 숨은 텍스트, 키워드 스터핑, 허위 리뷰, 확인되지 않은 수치, 도어웨이식 유도 문구는 사용하지 않습니다. 화면에 보이는 본문과 JSON-LD의 주요 정보가 어긋나지 않도록 맞췄습니다.

페이지 경험도 고려했습니다. 행정구 링크는 HTML에 직접 들어 있어 JavaScript가 늦게 실행되어도 읽을 수 있고, 선호 이미지는 og:image로 지정했습니다. 모바일에서는 행정구 링크가 반응형 그리드로 정렬되며, 각 하위 페이지는 2,000자 이상 2,500자 이하 범위에서 읽기 쉬운 문단으로 구성했습니다.

서울에서 예약을 원한다면 먼저 아래 목록에서 행정구를 선택하세요. 해당 구 페이지에서 행정동명을 확인한 뒤 전화 ${Phone} 으로 현재 위치, 희망 시간, 관리 목적, 공간 조건을 알려주면 상담원이 가능 여부와 비용, 취소 기준을 순서대로 안내합니다.

서울 허브는 구글 뉴스 노출을 노린 기사 페이지가 아니며, 현재 사건 보도처럼 꾸미지도 않습니다. 순수 예약 안내 페이지이므로 제목과 본문은 홍보성 표현보다 위치 확인, 안전 고지, 상담 절차에 집중합니다. Discover나 검색 썸네일에서 일관된 이미지를 쓰도록 og:image를 지정했지만, 이미지보다 본문 정보가 먼저 이해되도록 구성했습니다.

JavaScript가 검색을 방해하지 않는다는 최신 안내를 고려하더라도, 이 페이지의 핵심 링크와 본문은 스크립트 없이 HTML에 바로 있습니다. 메뉴 열기와 스크롤 효과만 가벼운 JavaScript로 처리하고, 행정구 링크와 FAQ는 기본 마크업으로 남겨 모바일과 검색엔진이 같은 정보를 읽도록 했습니다.

사용자는 이 허브에서 바로 예약을 결정하지 않아도 됩니다. 먼저 자신의 행정구를 고르고, 하위 페이지에서 행정동 목록과 공간 준비 기준을 확인한 뒤 상담하면 됩니다. 이 흐름이 검색 방문자에게도 직접 방문자에게도 같은 도움을 주는 구조입니다.
"@
$seoulHtml = @"
<!doctype html>
<html lang="ko">
<head>
$(Meta $seoulTitle $seoulDesc $seoulPath)
$seoulJson
</head>
<body>
$(HeaderHtml)
<main>
  <section class="hero compact"><div class="hero-inner"><div class="hero-copy reveal"><span class="eyebrow"><span class="pulse"></span>SEOUL REGION HUB</span><h1>서울 출장마사지</h1><p class="lead">25개 행정구를 선택해 행정동, 위치 설명, 예약 전 안전 기준을 확인하세요.</p><div class="actions"><a class="btn btn-primary" href="$Tel">예약전화 $Phone</a><a class="btn btn-ghost" href="/locations/">전체 지역</a></div></div><aside class="glass reveal"><small>서울 기준</small><h3>25개 행정구와 427개 행정동 현황 반영</h3><div class="book-row"><span>작성</span><b>$Author</b></div><div class="book-row"><span>검수</span><b>$Reviewer</b></div></aside></div></section>
  <section class="wrap"><div class="section-head"><span class="eyebrow">DISTRICT LIST</span><h2>서울 행정구 선택</h2></div><div class="area-grid">$seoulLinks</div></section>
  <section class="wrap prose"><div class="section-head"><span class="eyebrow">QUALITY NOTE</span><h2>서울 지역 페이지 운영 기준</h2></div><div class="copy"><p>$($seoulCopy -replace "`n`n","</p><p>")</p></div></section>
  $($seoulFaq.Html)
  <section class="cta-band"><h2>서울 출장마사지 상담</h2><p>행정구와 행정동 또는 가까운 역을 알려주시면 가능 시간, 비용, 관리 범위, 취소 기준을 안내합니다.</p><a class="btn btn-primary" href="$Tel">$Phone 전화예약</a></section>
</main>
$(FooterHtml)
</body>
</html>
"@
Write-Utf8File "locations/seoul/index.html" $seoulHtml

Write-Host "Updated $($Districts.Count) Seoul district pages with sorted administrative dongs."
