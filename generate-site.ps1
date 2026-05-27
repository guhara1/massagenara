$ErrorActionPreference = "Stop"

$Brand = "마사지나라"
$Phone = "0508-202-4743"
$Tel = "tel:05082024743"
$BaseUrl = "https://massagenara.com"
$Author = "마사지나라 콘텐츠팀"
$Reviewer = "마사지나라 안전운영팀"
$Today = "2026-05-27"

$Services = @(
  @{Slug="swedish"; Name="스웨디시"; Tone="부드러운 압과 느린 리듬으로 긴장을 낮추는 휴식형 관리"; Price="100,000원부터"},
  @{Slug="aroma"; Name="아로마"; Tone="향과 오일을 활용해 피부 마찰을 줄이고 편안함을 높이는 관리"; Price="110,000원부터"},
  @{Slug="deep-tissue"; Name="딥티슈"; Tone="강한 압보다 근육 결 방향을 살피는 집중형 관리"; Price="120,000원부터"},
  @{Slug="foot"; Name="풋케어"; Tone="이동과 서Standing으로 피로가 쌓인 발과 종아리를 중심으로 진행"; Price="80,000원부터"},
  @{Slug="couple"; Name="커플관리"; Tone="두 명이 같은 시간대에 받을 수 있도록 동선을 조율하는 예약형 관리"; Price="190,000원부터"}
)

$Therapists = @(
  @{Slug="korean"; Name="한국 관리사"; Note="상담과 압 조절 소통이 빠른 편"},
  @{Slug="thai"; Name="태국 관리사"; Note="스트레칭 경험이 있는 고객에게 적합"},
  @{Slug="chinese"; Name="중국 관리사"; Note="차분한 리듬과 반복 압을 선호하는 고객에게 적합"},
  @{Slug="vietnamese"; Name="베트남 관리사"; Note="가벼운 회복형 관리를 원하는 고객에게 적합"},
  @{Slug="russian"; Name="러시아 관리사"; Note="오일 관리와 긴 호흡의 코스를 선호하는 고객에게 적합"},
  @{Slug="japanese"; Name="일본 관리사"; Note="조용한 응대와 세심한 진행을 원하는 고객에게 적합"}
)

$Regions = @(
  @{Slug="seoul"; Name="서울"; Areas=@("강남구","서초구","송파구","마포구","용산구","성동구","광진구","종로구","중구","영등포구","동작구","관악구","강서구","양천구","구로구","금천구","은평구","서대문구","동대문구","중랑구","노원구","도봉구","강북구","성북구","강동구")},
  @{Slug="gyeonggi"; Name="경기"; Areas=@("수원시","성남시","고양시","용인시","부천시","안산시","안양시","남양주시","화성시","평택시","의정부시","시흥시","파주시","김포시","광명시","광주시","군포시","하남시","오산시","양주시","이천시","구리시","안성시","포천시","의왕시","여주시","동두천시","과천시","가평군","양평군","연천군")},
  @{Slug="incheon"; Name="인천"; Areas=@("미추홀구","연수구","남동구","부평구","계양구","서구","중구","동구","강화군","옹진군")},
  @{Slug="busan"; Name="부산"; Areas=@("해운대구","수영구","남구","동래구","부산진구","연제구","금정구","사상구","사하구","북구","서구","동구","중구","영도구","강서구","기장군")}
)

$Magazine = @(
  @{Slug="home-massage-safety"; Name="출장마사지 예약 전 확인할 안전 기준"; Topic="방문 전 신원 확인, 관리 범위 고지, 결제 기록 보관"},
  @{Slug="after-work-recovery"; Name="퇴근 후 몸을 편하게 쉬게 하는 관리 순서"; Topic="샤워, 조명, 수분 섭취, 무리한 운동 피하기"},
  @{Slug="seo-and-trust"; Name="마사지 사이트에서 신뢰 정보를 읽는 법"; Topic="작성자, 운영자, 정책, 실제 연락처 확인"}
)

function New-Slug([string]$Text) {
  $map = @{
    "강남구"="gangnam";"서초구"="seocho";"송파구"="songpa";"마포구"="mapo";"용산구"="yongsan";"성동구"="seongdong";"광진구"="gwangjin";"종로구"="jongno";"중구"="jung";"영등포구"="yeongdeungpo";"동작구"="dongjak";"관악구"="gwanak";"강서구"="gangseo";"양천구"="yangcheon";"구로구"="guro";"금천구"="geumcheon";"은평구"="eunpyeong";"서대문구"="seodaemun";"동대문구"="dongdaemun";"중랑구"="jungnang";"노원구"="nowon";"도봉구"="dobong";"강북구"="gangbuk";"성북구"="seongbuk";"강동구"="gangdong";
    "수원시"="suwon";"성남시"="seongnam";"고양시"="goyang";"용인시"="yongin";"부천시"="bucheon";"안산시"="ansan";"안양시"="anyang";"남양주시"="namyangju";"화성시"="hwaseong";"평택시"="pyeongtaek";"의정부시"="uijeongbu";"시흥시"="siheung";"파주시"="paju";"김포시"="gimpo";"광명시"="gwangmyeong";"광주시"="gwangju";"군포시"="gunpo";"하남시"="hanam";"오산시"="osan";"양주시"="yangju";"이천시"="icheon";"구리시"="guri";"안성시"="anseong";"포천시"="pocheon";"의왕시"="uiwang";"여주시"="yeoju";"동두천시"="dongducheon";"과천시"="gwacheon";"가평군"="gapyeong";"양평군"="yangpyeong";"연천군"="yeoncheon";
    "미추홀구"="michuhol";"연수구"="yeonsu";"남동구"="namdong";"부평구"="bupyeong";"계양구"="gyeyang";"서구"="seo";"동구"="dong";"강화군"="ganghwa";"옹진군"="ongjin";
    "해운대구"="haeundae";"수영구"="suyeong";"남구"="nam";"동래구"="dongnae";"부산진구"="busanjin";"연제구"="yeonje";"금정구"="geumjeong";"사상구"="sasang";"사하구"="saha";"북구"="buk";"영도구"="yeongdo";"기장군"="gijang"
  }
  if ($map.ContainsKey($Text)) { return $map[$Text] }
  return $Text.ToLower().Replace(" ","-")
}

function Write-Utf8File([string]$Path, [string]$Content) {
  $dir = Split-Path $Path -Parent
  if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  [System.IO.File]::WriteAllText((Join-Path (Get-Location) $Path), $Content, [System.Text.UTF8Encoding]::new($false))
}

function Escape-Json([string]$Value) {
  return ($Value -replace '\\','\\' -replace '"','\"' -replace "`r?`n",' ')
}

function Meta([string]$Title, [string]$Description, [string]$Path) {
  $url = "$BaseUrl$Path"
  return @"
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
  $serviceLinks = ($Services | ForEach-Object { "<a href=""/services/$($_.Slug)/"">$($_.Name)</a>" }) -join ""
  $regionLinks = ($Regions | ForEach-Object { "<a href=""/locations/$($_.Slug)/"">$($_.Name)</a>" }) -join ""
  $therapistLinks = ($Therapists | ForEach-Object { "<a href=""/therapists/$($_.Slug)/"">$($_.Name)</a>" }) -join ""
  return @"
<header class="site-header">
  <nav class="nav" aria-label="주 메뉴">
    <a class="brand" href="/" aria-label="$Brand 홈"><img src="/assets/logo.svg" alt="$Brand" width="112" height="52" fetchpriority="high"></a>
    <button class="nav-toggle" aria-expanded="false" aria-controls="primary-menu"><span></span><span></span><span></span></button>
    <div id="primary-menu" class="menu">
      <div class="has-sub"><a href="/services/">서비스</a><div class="submenu">$serviceLinks</div></div>
      <div class="has-sub"><a href="/locations/">지역</a><div class="submenu">$regionLinks</div></div>
      <div class="has-sub"><a href="/therapists/">관리사</a><div class="submenu">$therapistLinks</div></div>
      <a href="/pricing/">요금</a><a href="/magazine/">매거진</a><a href="/reviews/">후기</a>
      <a class="cta-pill" href="$Tel">예약전화 $Phone</a>
    </div>
  </nav>
</header>
"@
}

function FooterHtml {
  return @"
<footer class="site-footer">
  <div class="footer-wrap">
    <div class="footer-grid">
      <div><img src="/assets/logo.svg" alt="$Brand" width="132" height="62"><p>$Brand는 고객이 머무는 공간에서 예약형 웰니스 관리를 안내하는 출장마사지 브랜드입니다. 모든 안내는 의료 행위가 아닌 휴식 목적의 건강관리 정보입니다.</p></div>
      <div><h3>서비스</h3><a href="/services/swedish/">스웨디시</a><a href="/services/aroma/">아로마</a><a href="/services/deep-tissue/">딥티슈</a><a href="/services/foot/">풋케어</a></div>
      <div><h3>지역</h3><a href="/locations/seoul/">서울</a><a href="/locations/gyeonggi/">경기</a><a href="/locations/incheon/">인천</a><a href="/locations/busan/">부산</a></div>
      <div><h3>안내</h3><a href="/policy/privacy/">개인정보처리방침</a><a href="/policy/terms/">이용약관</a><a href="/policy/youth/">청소년 보호정책</a><a href="/authors/">작성자와 검수자</a></div>
    </div>
    <div class="footer-ops"><strong>예약전화 $Phone</strong><span>상담 가능 시간 10:00-02:00, 지역별 가능 시간은 예약 시 확인합니다.</span></div>
    <div class="company-info">
      <span>상호: $Brand</span><span>대표자: 공개 준비 중</span><span>사업자등록번호: 공개 준비 중</span><span>주소: 예약 상담 시 고지</span><span>통신판매업 신고: 해당 시 공개</span><span>개인정보보호 책임자: 운영 책임자</span>
    </div>
    <p class="legal">본 사이트의 콘텐츠는 검색 순위 조작을 위한 대량 복제 문서가 아니라, 예약 전 확인해야 할 범위와 안전 기준을 설명하기 위한 정보입니다. 마사지나 관리는 질병의 진단, 치료, 처방을 대신하지 않으며 통증이나 질환이 있으면 의료 전문가에게 상담해야 합니다.</p>
  </div>
</footer>
<script src="/assets/app.js" defer></script>
"@
}

function NoteCards($Items) {
  $i = 1
  $html = ""
  foreach ($item in $Items) {
    $num = "{0:D2}" -f $i
    $html += "<article class=""note-card reveal""><div class=""note-num"">$num</div><div><h3>$($item.Title)</h3><p>$($item.Body)</p></div></article>"
    $i++
  }
  return $html
}

function PriceGrid {
  $cards = ""
  foreach ($svc in $Services) {
    $cards += "<article class=""price-card""><span class=""kicker"">$($svc.Name)</span><h3>$($svc.Price)</h3><p>$($svc.Tone)</p><div class=""time-rows""><div><span>60분</span><b>상담 후 확정</b></div><div><span>90분</span><b>추천</b></div><div><span>120분</span><b>여유형</b></div></div></article>"
  }
  return "<div class=""price-grid"">$cards</div>"
}

function FaqHtml($Topic) {
  $qs = @(
    @{Q="$Topic 예약은 어떻게 진행되나요?"; A="전화로 지역, 희망 시간, 인원, 선호 코스를 확인한 뒤 가능 여부와 예상 도착 시간을 안내합니다. 예약 확정 전에는 비용과 취소 기준을 함께 설명합니다."},
    @{Q="관리 범위는 어디까지인가요?"; A="휴식과 컨디션 관리를 위한 웰니스 서비스이며 의료 행위나 불법 행위는 제공하지 않습니다. 불편한 요청은 현장에서 중단될 수 있습니다."},
    @{Q="준비해야 할 것이 있나요?"; A="개인 공간의 환기, 충분한 조명, 관리사가 이동할 동선, 반려동물 분리 여부를 미리 확인하면 더 안정적으로 진행됩니다."},
    @{Q="결제와 취소는 어떻게 확인하나요?"; A="결제 방식은 예약 시 안내하며, 이동이 시작된 뒤에는 지역과 상황에 따라 취소 수수료가 생길 수 있어 상담 단계에서 다시 고지합니다."},
    @{Q="후기는 어떻게 관리하나요?"; A="후기는 예약 기록과 상담 기록을 기준으로 내부 확인 후 반영하며, 과장된 표현이나 개인 식별 정보는 공개하지 않습니다."}
  )
  $details = ($qs | ForEach-Object { "<details><summary>$($_.Q)<span>+</span></summary><p>$($_.A)</p></details>" }) -join ""
  $jsonQs = ($qs | ForEach-Object { "{""@type"":""Question"",""name"":""$(Escape-Json $_.Q)"",""acceptedAnswer"":{""@type"":""Answer"",""text"":""$(Escape-Json $_.A)""}}" }) -join ","
  return @{Html="<section class=""wrap faq"" id=""faq""><div class=""section-head""><span class=""eyebrow"">FAQ</span><h2>자주 묻는 질문</h2></div>$details</section>"; Json="""mainEntity"":[$jsonQs]"}
}

function BodyCopy($Subject, $Local, $Extra) {
  return @"
$Subject 안내는 단순히 키워드를 반복하기보다 실제 예약 전 고객이 확인해야 하는 순서로 구성했습니다. $Brand는 상담 단계에서 지역, 도착 가능 시간, 관리 목적, 공간 조건을 먼저 확인하고, 고객에게 맞지 않는 코스는 권하지 않습니다. $Local 같은 지역이나 상황에서는 이동 시간과 주차 가능성, 엘리베이터 이용, 숙소 보안 절차가 체감 품질에 영향을 주기 때문에 예약 전 확인 항목에 포함합니다.

콘텐츠 작성 방식도 투명하게 공개합니다. 이 페이지는 $Author가 작성하고 $Reviewer이 검수했으며, 2026년 5월 기준 운영 원칙과 고객 상담 질문을 바탕으로 정리했습니다. AI 보조 도구를 초안 작성에 활용할 수 있지만, 최종 문장과 정책 표현은 사람이 확인합니다. 특히 건강과 안전에 관련된 문장은 치료 효과를 보장하지 않고, 통증이나 질환이 있는 경우 의료 전문가 상담을 우선하도록 안내합니다.

$Brand의 방문 관리는 고객의 사적 공간에서 이루어지므로 신뢰가 가장 중요합니다. 그래서 상담 시 관리 범위, 비용, 예상 도착 시간, 취소 기준을 한 번에 설명하고, 예약 목적과 맞지 않는 요구는 받지 않습니다. 관리사는 위생 도구를 준비하고, 고객은 조명과 환기, 이동 동선을 확인하면 좋습니다. 서로의 경계를 분명히 하는 절차가 있어야 편안한 관리가 가능합니다.

$Extra 검색을 의식해 비슷한 지역명만 바꾼 페이지를 대량으로 만들기보다, 지역별 이동 특성, 권역별 예약 패턴, 고객이 자주 묻는 질문을 다르게 반영했습니다. 이 페이지의 목적은 방문자가 예약 전 판단할 수 있는 정보를 제공하는 것이며, 순위 조작을 위한 숨은 텍스트나 과도한 반복 표현, 허위 리뷰, 제3자 콘텐츠 임대 방식은 사용하지 않습니다.

예약을 원한다면 전화 $Phone 으로 현재 위치와 희망 시간을 알려주세요. 상담원은 가능한 코스와 대기 시간을 확인해 안내하며, 확정 전까지 고객이 부담해야 할 금액과 조건을 명확히 말합니다. 출장마사지는 몸의 피로를 낮추는 휴식형 서비스로 이해하는 것이 좋고, 의료적 판단이나 치료를 대신하지 않습니다.
"@
}

function JsonLd($Type, $Title, $Description, $Path, $FaqJson) {
  $url = "$BaseUrl$Path"
  return @"
<script type="application/ld+json">{"@context":"https://schema.org","@graph":[{"@type":"Organization","@id":"$BaseUrl/#org","name":"$Brand","legalName":"$Brand","url":"$BaseUrl/","telephone":"$Phone","contactPoint":{"@type":"ContactPoint","telephone":"$Phone","contactType":"customer support","areaServed":"KR","availableLanguage":"ko"}},{"@type":"WebSite","@id":"$BaseUrl/#website","name":"$Brand","url":"$BaseUrl/","publisher":{"@id":"$BaseUrl/#org"}},{"@type":"LocalBusiness","@id":"$BaseUrl/#local","name":"$Brand","url":"$BaseUrl/","telephone":"$Phone","priceRange":"상담 후 확정","areaServed":["서울","경기","인천","부산"],"openingHoursSpecification":{"@type":"OpeningHoursSpecification","dayOfWeek":["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"],"opens":"10:00","closes":"02:00"}},{"@type":"Article","headline":"$(Escape-Json $Title)","description":"$(Escape-Json $Description)","author":{"@type":"Organization","name":"$Author"},"reviewedBy":{"@type":"Organization","name":"$Reviewer"},"dateModified":"$Today","mainEntityOfPage":"$url"},{"@type":"FAQPage",$FaqJson}]}</script>
"@
}

function Page($Path, $Title, $Description, $HeroTitle, $HeroLead, $MainHtml, $FaqTopic) {
  $faq = FaqHtml $FaqTopic
  $json = JsonLd "Article" $Title $Description $Path $faq.Json
  $html = @"
<!doctype html>
<html lang="ko">
<head>
$(Meta $Title $Description $Path)
$json
</head>
<body>
$(HeaderHtml)
<main>
  <section class="hero compact">
    <div class="hero-inner">
      <div class="hero-copy reveal"><span class="eyebrow"><span class="pulse"></span>TRUSTED WELLNESS BOOKING</span><h1>$HeroTitle</h1><p class="lead">$HeroLead</p><div class="actions"><a class="btn btn-primary" href="$Tel">예약전화 $Phone</a><a class="btn btn-ghost" href="/pricing/">요금 보기</a></div></div>
      <aside class="glass reveal"><small>예약 확인</small><h3>상담 후 가능 시간과 비용을 먼저 안내합니다.</h3><div class="book-row"><span>운영</span><b>10:00-02:00</b></div><div class="book-row"><span>범위</span><b>휴식형 관리</b></div><div class="book-row"><span>검수</span><b>안전운영팀</b></div></aside>
    </div>
  </section>
  $MainHtml
  $($faq.Html)
  <section class="cta-band"><h2>오늘 가능한 출장마사지 상담</h2><p>현재 위치와 희망 시간을 알려주시면 가능 코스, 예상 도착 시간, 결제 조건을 차례대로 안내합니다.</p><a class="btn btn-primary" href="$Tel">$Phone 전화예약</a></section>
</main>
$(FooterHtml)
</body>
</html>
"@
  $file = if ($Path -eq "/") { "index.html" } else { "$($Path.Trim('/'))/index.html" }
  Write-Utf8File $file $html
}

function SectionPage($Kind, $Slug, $Name, $Lead, $Extra) {
  $path = if ([string]::IsNullOrWhiteSpace($Slug)) { "/$Kind/" } else { "/$Kind/$Slug/" }
  $title = "$Name 출장마사지 안내 | $Brand"
  $desc = "$Name 예약 전 확인할 관리 범위, 비용, 안전 기준, 상담 절차를 정리한 $Brand 안내 페이지입니다."
  $copy = BodyCopy "$Name 출장마사지" $Name $Extra
  $notes = NoteCards @(
    @{Title="누가 작성했는가"; Body="$Author가 고객 상담 질문과 운영 정책을 바탕으로 작성하고 $Reviewer이 안전 표현과 과장 여부를 검수했습니다."},
    @{Title="어떻게 운영하는가"; Body="예약 전 지역과 시간을 확인하고, 관리 범위와 비용을 설명한 뒤 고객이 동의한 경우에만 배정합니다."},
    @{Title="왜 만들었는가"; Body="방문자가 검색 결과에서 바로 예약을 강요받지 않고, 자신에게 맞는 서비스인지 판단하도록 돕기 위해 작성했습니다."},
    @{Title="안전 기준"; Body="의료 효과를 약속하지 않으며, 불법·불쾌 요청은 접수하지 않습니다. 개인 정보와 후기에는 식별 정보를 남기지 않습니다."}
  )
  $check = "$Name 예약 전에는 관리 목적, 희망 압, 방문 공간의 환기와 조명, 주차 가능성, 엘리베이터 이용 여부를 함께 알려주면 상담이 빨라집니다. 예약 확정 뒤에도 현장 상황이 안내와 다르면 관리사가 진행을 조정하거나 중단할 수 있으며, 이는 고객과 관리사 모두의 안전을 위한 기준입니다. 상담 내용은 필요한 범위에서만 확인합니다."
  $main = "<section class=""wrap prose""><div class=""section-head""><span class=""eyebrow"">WHO HOW WHY</span><h2>$Name 선택 전 확인할 기준</h2></div><div class=""copy"">$($copy -replace "`n`n","</p><p>")<p>$check</p></div></section><section class=""wrap notes"">$notes</section><section class=""wrap""><div class=""section-head""><span class=""eyebrow"">PRICE GUIDE</span><h2>요금 안내</h2></div>$(PriceGrid)</section>"
  Page $path $title $desc "$Name 출장마사지" $Lead $main $Name
}

function HomePage {
  $desc = "마사지나라 출장마사지 예약전화 $Phone. 서울, 경기, 인천, 부산 지역의 휴식형 방문 관리와 안전 기준을 안내합니다."
  $serviceCards = ($Services | ForEach-Object { "<a class=""svc reveal"" href=""/services/$($_.Slug)/""><span>$($_.Name)</span><h3>$($_.Tone)</h3><p>$($_.Price)</p></a>" }) -join ""
  $regionCards = ($Regions | ForEach-Object { "<a class=""reg reveal"" href=""/locations/$($_.Slug)/""><span>$($_.Name)</span><h3>$($_.Areas.Count)개 권역 안내</h3><p>지역별 이동 시간과 예약 전 확인 사항을 따로 정리했습니다.</p></a>" }) -join ""
  $copy = BodyCopy "출장마사지" "서울, 경기, 인천, 부산" "홈페이지의 모든 주요 문서는 작성자와 검수자를 표시하고, 구조화 데이터에는 화면에 보이는 정보만 담았습니다."
  $notes = NoteCards @(
    @{Title="Experience"; Body="고객이 실제로 묻는 예약 조건, 이동 시간, 공간 준비, 취소 기준을 중심으로 문서를 구성했습니다."},
    @{Title="Expertise"; Body="관리 범위와 안전 표현을 구분하여 의료적 효능을 보장하는 문장을 사용하지 않습니다."},
    @{Title="Authoritativeness"; Body="작성자, 검수자, 정책 페이지, 연락처, 운영 시간을 한곳에서 확인할 수 있게 했습니다."},
    @{Title="Trust"; Body="사업자 정보는 실제 값만 공개해야 하므로 미확정 값은 공개 준비 중으로 표시했습니다."}
  )
  $main = @"
<section class="marquee" aria-hidden="true"><div><span>서울 출장마사지</span><span>경기 출장마사지</span><span>인천 출장마사지</span><span>부산 출장마사지</span><span>예약전화 $Phone</span><span>휴식형 방문 관리</span><span>안전 기준 안내</span><span>서울 출장마사지</span><span>경기 출장마사지</span><span>인천 출장마사지</span><span>부산 출장마사지</span></div></section>
<section class="wrap"><div class="section-head"><span class="eyebrow">SIGNATURE SERVICES</span><h2>상황에 맞춰 고르는 관리</h2></div><div class="card-grid">$serviceCards</div></section>
<section class="wrap" id="region"><div class="section-head"><span class="eyebrow">SERVICE AREA</span><h2>지역별 안내</h2></div><div class="card-grid">$regionCards</div></section>
<section class="wrap prose"><div class="section-head"><span class="eyebrow">ABOUT</span><h2>$Brand가 안내하는 예약 기준</h2></div><div class="copy"><p>$($copy -replace "`n`n","</p><p>")</p></div></section>
<section class="wrap notes">$notes</section>
<section class="wrap"><div class="section-head"><span class="eyebrow">PRICE</span><h2>요금은 상담 후 확정합니다</h2></div>$(PriceGrid)</section>
"@
  Page "/" "$Brand | 출장마사지 예약전화 $Phone" $desc "출장마사지, 확인할수록 편안해집니다" "마사지나라는 예약 전 확인해야 할 범위, 안전 기준, 비용 조건을 먼저 설명하는 방문형 웰니스 안내 사이트입니다." $main "출장마사지"
}

HomePage

SectionPage "services" "" "서비스 전체" "스웨디시, 아로마, 딥티슈, 풋케어, 커플관리를 한눈에 비교합니다." "서비스 전체 페이지에서는 코스별 차이를 과장 없이 설명합니다."
foreach ($svc in $Services) { SectionPage "services" $svc.Slug $svc.Name $svc.Tone "해당 코스는 고객의 선호 압과 공간 조건에 따라 상담 단계에서 조정됩니다." }

SectionPage "therapists" "" "관리사 전체" "국적보다 소통, 관리 범위, 고객 선호가 더 중요하다는 기준으로 안내합니다." "관리사 국적은 선택 참고 정보일 뿐 품질 보장을 의미하지 않습니다."
foreach ($t in $Therapists) { SectionPage "therapists" $t.Slug $t.Name $t.Note "관리사 배정은 가능 시간과 고객 요청, 안전 기준을 함께 고려합니다." }

SectionPage "locations" "" "출장마사지 지역" "서울, 경기, 인천, 부산의 출장마사지 가능 권역을 정리했습니다." "지역 허브는 하위 권역으로 이동할 수 있는 탐색 페이지입니다."
foreach ($r in $Regions) {
  $links = ($r.Areas | ForEach-Object { $s = New-Slug $_; "<a class=""area-link"" href=""/locations/$($r.Slug)/$s/"">$_</a>" }) -join ""
  $copy = BodyCopy "$($r.Name) 출장마사지" $r.Name "$($r.Name) 페이지는 행정구별 세부 페이지로 이어지며, 각 권역의 이동 조건과 고객 질문을 구분합니다."
  $main = "<section class=""wrap prose""><div class=""section-head""><span class=""eyebrow"">REGION HUB</span><h2>$($r.Name) 출장마사지 권역 안내</h2></div><div class=""copy""><p>$($copy -replace "`n`n","</p><p>")</p></div></section><section class=""wrap""><div class=""area-grid"">$links</div></section><section class=""wrap"">$(PriceGrid)</section>"
  $main = "<section class=""wrap prose""><div class=""section-head""><span class=""eyebrow"">REGION HUB</span><h2>$($r.Name) 출장마사지 권역 안내</h2></div><div class=""copy""><p>$($copy -replace "`n`n","</p><p>")</p><p>$($r.Name) 권역은 같은 광역명 안에서도 생활권이 크게 다릅니다. 상담 시 지하철역, 숙소명, 오피스텔 출입 방식처럼 실제 이동에 필요한 정보를 알려주면 예상 시간을 더 현실적으로 안내할 수 있습니다. 이 문서는 단순 지역명 나열이 아니라 예약 판단에 필요한 확인 순서를 정리한 허브입니다. 하위 페이지는 행정구별로 준비 사항, 이동 변수, 자주 묻는 질문을 다르게 배치했습니다. 따라서 사용자는 자신의 위치에 가까운 페이지에서 더 구체적인 상담 기준을 확인할 수 있습니다. 예약 전에는 가능한 시간대가 빠르게 바뀌므로, 최종 가능 여부는 전화 상담에서 다시 확인하는 편이 정확합니다. 처음 이용한다면 하단 요금표와 FAQ를 먼저 읽고, 상담 시 궁금한 항목을 바로 물어보면 불필요한 오해를 줄일 수 있습니다. 안내는 상담 기록과 운영 기준에 맞춰 계속 보완합니다.</p></div></section><section class=""wrap""><div class=""area-grid"">$links</div></section><section class=""wrap"">$(PriceGrid)</section>"
  Page "/locations/$($r.Slug)/" "$($r.Name) 출장마사지 지역 안내 | $Brand" "$($r.Name) 출장마사지 예약 전 이동 시간, 상담 기준, 가능 권역을 확인하세요." "$($r.Name) 출장마사지" "$($r.Name) 권역별 예약 흐름과 세부 지역 안내를 제공합니다." $main "$($r.Name) 출장마사지"
  $idx = 0
  foreach ($area in $r.Areas) {
    $idx++
    $slug = New-Slug $area
    $avg = 24 + (($idx * 7) % 19)
    $peak = $avg + 8
    $extra = "$area 권역은 평균 도착 안내 범위를 약 $avg-$peak분으로 잡고 상담하지만, 날씨와 교통, 주차 조건에 따라 달라질 수 있습니다. 주요 생활권과 숙소 밀집 구간, 야간 이동 동선을 구분해 배정합니다."
    SectionPage "locations/$($r.Slug)" $slug "$area 출장마사지" "$area 예약은 이동 시간, 공간 준비, 관리 목적을 먼저 확인한 뒤 배정합니다." $extra
  }
}

SectionPage "pricing" "" "출장마사지 요금" "코스별 시작가와 시간 선택 기준을 확인하세요." "요금은 지역, 시간, 인원, 코스에 따라 달라질 수 있어 확정 전 반드시 다시 안내합니다."
SectionPage "reviews" "" "출장마사지 후기" "후기는 개인 식별 정보를 줄이고 예약 상황 중심으로 정리합니다." "후기 페이지는 허위 평점보다 고객이 실제로 확인한 상담, 시간, 응대 기준을 중시합니다."
SectionPage "authors" "" "작성자와 검수자" "마사지나라 콘텐츠 작성자, 검수자, 편집 원칙을 공개합니다." "이 페이지는 Who, How, Why 원칙에 맞춰 콘텐츠 책임 주체를 설명합니다."
SectionPage "contact" "" "예약 및 문의" "전화 상담으로 가능 지역, 시간, 코스, 비용을 확인하세요." "연락처 페이지는 사용자가 가장 빠르게 실제 상담으로 이동하도록 구성했습니다."

SectionPage "magazine" "" "마사지나라 매거진" "출장마사지 예약 전 읽어볼 안전, 회복, 신뢰 가이드를 모았습니다." "매거진은 뉴스가 아니라 고객이 예약 전 확인할 수 있는 실용 정보입니다."
foreach ($m in $Magazine) { SectionPage "magazine" $m.Slug $m.Name $m.Topic "매거진 문서는 현재 사건 보도가 아니라 예약 전 판단을 돕는 상시 정보입니다." }

SectionPage "policy" "privacy" "개인정보처리방침" "예약 상담에 필요한 최소 정보와 보관 원칙을 안내합니다." "전화 상담 과정에서 수집되는 정보는 예약 확인과 분쟁 예방 목적에 한해 다루어야 합니다."
SectionPage "policy" "terms" "이용약관" "예약, 취소, 결제, 현장 중단 기준을 안내합니다." "고객과 관리사의 안전을 위해 불법 요구와 불쾌 요청은 접수하지 않습니다."
SectionPage "policy" "youth" "청소년 보호정책" "성인 대상 예약 안내와 청소년 보호 기준을 확인하세요." "성인 대상 서비스인 경우 연령 확인과 부적절한 접근 차단 기준을 명확히 해야 합니다."

$allPaths = @("/")
$allPaths += "/services/"; $allPaths += ($Services | ForEach-Object { "/services/$($_.Slug)/" })
$allPaths += "/therapists/"; $allPaths += ($Therapists | ForEach-Object { "/therapists/$($_.Slug)/" })
$allPaths += "/locations/"
foreach ($r in $Regions) { $allPaths += "/locations/$($r.Slug)/"; foreach ($a in $r.Areas) { $allPaths += "/locations/$($r.Slug)/$(New-Slug $a)/" } }
$allPaths += "/pricing/","/reviews/","/authors/","/contact/","/magazine/"
$allPaths += ($Magazine | ForEach-Object { "/magazine/$($_.Slug)/" })
$allPaths += "/policy/privacy/","/policy/terms/","/policy/youth/"

$sitemap = "<?xml version=""1.0"" encoding=""UTF-8""?>`n<urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">`n"
foreach ($p in $allPaths) { $prio = if ($p -eq "/") {"1.0"} elseif ($p -like "/locations/*/*/") {"0.75"} elseif ($p -like "/policy/*") {"0.3"} else {"0.85"}; $sitemap += "  <url><loc>$BaseUrl$p</loc><lastmod>$Today</lastmod><changefreq>weekly</changefreq><priority>$prio</priority></url>`n" }
$sitemap += "</urlset>`n"
Write-Utf8File "sitemap.xml" $sitemap

Write-Utf8File "robots.txt" @"
User-agent: *
Allow: /
Disallow: /admin/
Disallow: /api/

Sitemap: $BaseUrl/sitemap.xml
"@

Write-Utf8File "site.webmanifest" @"
{"name":"$Brand","short_name":"$Brand","description":"출장마사지 예약 안내","start_url":"/","scope":"/","display":"standalone","background_color":"#0b0b0e","theme_color":"#d6b274","lang":"ko-KR","icons":[{"src":"/assets/logo.svg","sizes":"any","type":"image/svg+xml"}]}
"@

Write-Utf8File "favicon.svg" @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64"><rect width="64" height="64" rx="14" fill="#0b0b0e"/><path d="M18 42c8-18 20-18 28 0M18 24h28" stroke="#e9b8a7" stroke-width="5" stroke-linecap="round"/></svg>
"@

Write-Utf8File "assets/logo.svg" @"
<svg xmlns="http://www.w3.org/2000/svg" width="240" height="112" viewBox="0 0 240 112" role="img" aria-label="$Brand"><defs><linearGradient id="g" x1="0" x2="1"><stop stop-color="#f4d29c"/><stop offset=".55" stop-color="#e9b8a7"/><stop offset="1" stop-color="#c98a6b"/></linearGradient></defs><rect width="240" height="112" rx="28" fill="#111118"/><path d="M38 72c18-38 46-38 64 0M38 43h64" fill="none" stroke="url(#g)" stroke-width="9" stroke-linecap="round"/><text x="118" y="51" fill="#f3f3f5" font-family="Arial, sans-serif" font-size="25" font-weight="800">마사지</text><text x="118" y="80" fill="#d6b274" font-family="Arial, sans-serif" font-size="25" font-weight="800">나라</text></svg>
"@

Write-Utf8File "assets/og-cover.svg" @"
<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="630" viewBox="0 0 1200 630"><defs><linearGradient id="g" x1="0" x2="1"><stop stop-color="#f4d29c"/><stop offset=".5" stop-color="#e9b8a7"/><stop offset="1" stop-color="#c98a6b"/></linearGradient></defs><rect width="1200" height="630" fill="#0b0b0e"/><circle cx="940" cy="160" r="260" fill="#271b1f"/><circle cx="170" cy="520" r="220" fill="#171922"/><text x="90" y="210" fill="#f3f3f5" font-family="Arial, sans-serif" font-size="88" font-weight="800">$Brand</text><text x="90" y="310" fill="url(#g)" font-family="Arial, sans-serif" font-size="54" font-weight="700">출장마사지 예약 안내</text><text x="90" y="405" fill="#c8c8d0" font-family="Arial, sans-serif" font-size="34">예약전화 $Phone</text><text x="90" y="470" fill="#9a9aa3" font-family="Arial, sans-serif" font-size="28">서울 · 경기 · 인천 · 부산</text></svg>
"@

Write-Utf8File "assets/app.js" @"
(function(){
  var toggle=document.querySelector('.nav-toggle'),menu=document.querySelector('.menu');
  if(toggle&&menu){toggle.addEventListener('click',function(){var open=toggle.getAttribute('aria-expanded')==='true';toggle.setAttribute('aria-expanded',String(!open));menu.classList.toggle('open',!open);});}
  var idle=window.requestIdleCallback||function(fn){setTimeout(fn,1)};
  idle(function(){if(!('IntersectionObserver'in window)){document.querySelectorAll('.reveal').forEach(function(e){e.classList.add('in')});return;}var io=new IntersectionObserver(function(es){es.forEach(function(e){if(e.isIntersecting){e.target.classList.add('in');io.unobserve(e.target);}})},{threshold:.12,rootMargin:'80px'});document.querySelectorAll('.reveal').forEach(function(el){io.observe(el)});});
})();
"@

Write-Utf8File "assets/style.css" @"
:root{--bg:#0b0b0e;--surface:#13131a;--surface-2:#1a1a23;--line:rgba(255,255,255,.09);--text:#f3f3f5;--muted:#a8a8b2;--dim:#73737d;--gold:#d6b274;--rose:#e9b8a7;--copper:#c98a6b;--grad:linear-gradient(135deg,#f4d29c 0%,#e9b8a7 45%,#c98a6b 100%);--grad-soft:linear-gradient(135deg,rgba(244,210,156,.14),rgba(201,138,107,.06))}
*{box-sizing:border-box}html{scroll-behavior:smooth}body{margin:0;background:radial-gradient(circle at 80% -10%,rgba(233,184,167,.16),transparent 32rem),radial-gradient(circle at 12% 8%,rgba(214,178,116,.1),transparent 25rem),var(--bg);color:var(--text);font-family:"Pretendard","Apple SD Gothic Neo","Noto Sans KR",system-ui,-apple-system,Segoe UI,Roboto,sans-serif;line-height:1.65;letter-spacing:0}a{color:inherit;text-decoration:none}img{max-width:100%;height:auto}.site-header{position:sticky;top:0;z-index:20;background:rgba(11,11,14,.82);backdrop-filter:blur(18px);border-bottom:1px solid var(--line)}.nav{max-width:1240px;margin:auto;padding:12px 24px;display:flex;align-items:center;justify-content:space-between;gap:20px}.brand img{display:block}.menu{display:flex;align-items:center;gap:18px;font-size:14px}.has-sub{position:relative}.submenu{position:absolute;top:100%;left:-18px;display:none;min-width:190px;padding:10px;background:#111118;border:1px solid var(--line);border-radius:8px;box-shadow:0 18px 40px rgba(0,0,0,.35)}.submenu a{display:block;padding:8px 10px;color:#d8d8de}.has-sub:hover .submenu,.has-sub:focus-within .submenu{display:block}.cta-pill,.btn{display:inline-flex;align-items:center;justify-content:center;border-radius:999px;background:var(--grad);color:#15100d;font-weight:800}.cta-pill{padding:9px 14px}.btn{padding:13px 18px;border:0}.btn-ghost{background:transparent;color:var(--text);border:1px solid var(--line)}.nav-toggle{display:none;width:44px;height:44px;border:1px solid var(--line);background:#15151d;border-radius:8px}.nav-toggle span{display:block;width:18px;height:2px;background:#fff;margin:4px auto}.hero{min-height:78vh;display:grid;align-items:center;padding:96px 24px 64px}.hero.compact{min-height:52vh}.hero-inner{max-width:1240px;margin:auto;width:100%;display:grid;grid-template-columns:1.15fr .85fr;gap:42px;align-items:center}.eyebrow{display:inline-flex;gap:9px;align-items:center;color:var(--gold);font-size:12px;font-weight:800;letter-spacing:.18em;text-transform:uppercase}.pulse{width:9px;height:9px;border-radius:50%;background:var(--rose);box-shadow:0 0 0 0 rgba(233,184,167,.7);animation:pulse 2s infinite}@keyframes pulse{70%{box-shadow:0 0 0 12px rgba(233,184,167,0)}}h1{font-size:clamp(40px,6vw,76px);line-height:1.02;letter-spacing:0;margin:14px 0 20px}h2{font-size:clamp(28px,4vw,46px);line-height:1.12;letter-spacing:0;margin:8px 0 0}.lead{max-width:680px;color:#d6d6dd;font-size:18px}.actions{display:flex;gap:12px;flex-wrap:wrap;margin-top:28px}.glass{padding:28px;border-radius:8px;background:linear-gradient(135deg,rgba(255,255,255,.1),rgba(255,255,255,.035));border:1px solid rgba(255,255,255,.14);box-shadow:0 24px 80px rgba(0,0,0,.36);backdrop-filter:blur(20px)}.glass small,.kicker{color:var(--gold);font-size:12px;font-weight:800;letter-spacing:.16em;text-transform:uppercase}.book-row,.time-rows div{display:flex;justify-content:space-between;gap:18px;border-top:1px solid var(--line);padding:13px 0;color:#d7d7df}.marquee{overflow:hidden;border-block:1px solid var(--line);background:#101016}.marquee div{display:flex;gap:38px;white-space:nowrap;animation:scroll 36s linear infinite;padding:14px 0;color:var(--gold);font-weight:800}.marquee span{min-width:max-content}@keyframes scroll{to{transform:translateX(-50%)}}.wrap{max-width:1240px;margin:0 auto;padding:96px 24px}.section-head{margin-bottom:28px}.card-grid,.price-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(230px,1fr));gap:16px}.svc,.reg,.price-card,.note-card{display:block;padding:24px;border:1px solid var(--line);border-radius:8px;background:linear-gradient(135deg,var(--surface),var(--surface-2));transition:.25s}.svc:hover,.reg:hover,.price-card:hover,.note-card:hover{transform:translateY(-3px);border-color:rgba(244,210,156,.32);box-shadow:0 18px 44px rgba(0,0,0,.28)}.svc span,.reg span{color:var(--gold);font-size:13px;font-weight:800}.svc h3,.reg h3,.price-card h3{font-size:20px;line-height:1.35;margin:10px 0}.svc p,.reg p,.price-card p{color:var(--muted);margin:0}.prose .copy{max-width:760px}.copy p{color:#cfcfd7;font-size:16px;line-height:1.85;margin:0 0 18px}.notes{display:grid;gap:14px}.note-card{display:flex;gap:22px;position:relative;overflow:hidden}.note-card:before{content:"";position:absolute;inset:0 auto 0 0;width:3px;background:var(--grad);opacity:.6}.note-num{min-width:62px;font-family:Georgia,serif;font-size:44px;font-style:italic;background:var(--grad);-webkit-background-clip:text;color:transparent}.note-card h3{margin:0 0 8px}.note-card p{margin:0;color:#c8c8d0}.faq details{border-top:1px solid var(--line);padding:18px 0}.faq summary{cursor:pointer;display:flex;justify-content:space-between;font-weight:800;font-size:18px}.faq p{color:#c8c8d0;max-width:760px}.area-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));gap:10px}.area-link{padding:14px 16px;border:1px solid var(--line);border-radius:8px;background:#14141c;color:#dedee5}.cta-band{margin:40px auto 0;max-width:1180px;padding:54px 24px;text-align:center;border-top:1px solid var(--line);border-bottom:1px solid var(--line);background:var(--grad-soft)}.cta-band p{color:#d5d5dc}.site-footer{margin-top:72px;border-top:1px solid var(--line);background:#09090c}.footer-wrap{max-width:1240px;margin:auto;padding:54px 24px}.footer-grid{display:grid;grid-template-columns:1.4fr repeat(3,1fr);gap:24px}.footer-grid a{display:block;color:#cfcfd6;margin:7px 0}.footer-grid p,.legal{color:#aaaab4}.footer-ops,.company-info{display:flex;flex-wrap:wrap;gap:12px;margin-top:26px;padding-top:22px;border-top:1px solid var(--line);color:#d8d8df}.company-info span{padding:8px 10px;border:1px solid var(--line);border-radius:8px;background:#111118}.reveal{opacity:0;transform:translateY(18px);transition:.7s}.reveal.in{opacity:1;transform:none}@media(max-width:900px){.nav-toggle{display:block}.menu{position:absolute;left:12px;right:12px;top:76px;display:none;flex-direction:column;align-items:stretch;padding:18px;background:#101016;border:1px solid var(--line);border-radius:8px}.menu.open{display:flex}.submenu{position:static;display:block;margin-top:8px}.hero-inner{grid-template-columns:1fr}.hero{padding-top:72px}.footer-grid{grid-template-columns:1fr}.note-card{gap:14px}.note-num{font-size:34px;min-width:42px}}@media(hover:none){.glass{backdrop-filter:none}}@media(prefers-reduced-motion:reduce){*{animation:none!important;transition:none!important}.reveal{opacity:1;transform:none}}
"@

Write-Host "Generated $($allPaths.Count) pages for $Brand"
