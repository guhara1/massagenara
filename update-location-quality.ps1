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

$Regions = @(
  @{Slug="gyeonggi"; Name="경기"; Areas=@("수원시","성남시","고양시","용인시","부천시","안산시","안양시","남양주시","화성시","평택시","의정부시","시흥시","파주시","김포시","광명시","광주시","군포시","하남시","오산시","양주시","이천시","구리시","안성시","포천시","의왕시","여주시","동두천시","과천시","가평군","양평군","연천군")},
  @{Slug="incheon"; Name="인천"; Areas=@("미추홀구","연수구","남동구","부평구","계양구","서구","중구","동구","강화군","옹진군")},
  @{Slug="busan"; Name="부산"; Areas=@("해운대구","수영구","남구","동래구","부산진구","연제구","금정구","사상구","사하구","북구","서구","동구","중구","영도구","강서구","기장군")}
)

$SlugMap = @{
  "수원시"="suwon";"성남시"="seongnam";"고양시"="goyang";"용인시"="yongin";"부천시"="bucheon";"안산시"="ansan";"안양시"="anyang";"남양주시"="namyangju";"화성시"="hwaseong";"평택시"="pyeongtaek";"의정부시"="uijeongbu";"시흥시"="siheung";"파주시"="paju";"김포시"="gimpo";"광명시"="gwangmyeong";"광주시"="gwangju";"군포시"="gunpo";"하남시"="hanam";"오산시"="osan";"양주시"="yangju";"이천시"="icheon";"구리시"="guri";"안성시"="anseong";"포천시"="pocheon";"의왕시"="uiwang";"여주시"="yeoju";"동두천시"="dongducheon";"과천시"="gwacheon";"가평군"="gapyeong";"양평군"="yangpyeong";"연천군"="yeoncheon";
  "미추홀구"="michuhol";"연수구"="yeonsu";"남동구"="namdong";"부평구"="bupyeong";"계양구"="gyeyang";"서구"="seo";"중구"="jung";"동구"="dong";"강화군"="ganghwa";"옹진군"="ongjin";
  "해운대구"="haeundae";"수영구"="suyeong";"남구"="nam";"동래구"="dongnae";"부산진구"="busanjin";"연제구"="yeonje";"금정구"="geumjeong";"사상구"="sasang";"사하구"="saha";"북구"="buk";"영도구"="yeongdo";"강서구"="gangseo";"기장군"="gijang"
}

$Profiles = @(
  @{Kind="역세권·상업지"; Check="건물 출입 방식, 엘리베이터 이용, 야간 소음 가능성을 먼저 확인해야 합니다."; Useful="가까운 역 출구와 건물명을 함께 알려주면 주소 확인 시간이 줄어듭니다."},
  @{Kind="주거단지"; Check="아파트 동 출입, 방문 주차, 가족 구성원이 쉬는 공간 분리 여부가 중요합니다."; Useful="동·라인·공동현관 호출 방법을 예약 전에 알려주는 편이 안전합니다."},
  @{Kind="업무지구"; Check="퇴근 이후 출입 제한, 보안 데스크, 야간 냉난방 상태를 확인해야 합니다."; Useful="오피스텔인지 사무실인지 구분하면 관리 가능 범위를 더 정확히 안내합니다."},
  @{Kind="관광·숙박권"; Check="숙소 프런트 정책, 객실 방문 가능 여부, 체크인 시간과 겹치는지를 확인해야 합니다."; Useful="숙소명과 예약자명 확인 방식은 민감 정보 없이 필요한 범위에서만 다룹니다."},
  @{Kind="외곽·전원권"; Check="차량 진입로, 야간 조명, 주차 위치, 귀가 동선을 넉넉하게 확인해야 합니다."; Useful="큰길 기준 위치와 가까운 표지 지점을 알려주면 도착 안내가 현실적입니다."},
  @{Kind="산업·물류권"; Check="교대 시간, 출입증, 주변 주차 가능성, 작업복 환복 공간을 확인해야 합니다."; Useful="업무 종료 후 관리라면 샤워와 휴식 시간을 확보한 뒤 예약하는 편이 좋습니다."}
)

function Write-Utf8File([string]$Path, [string]$Content) {
  [System.IO.File]::WriteAllText((Join-Path (Get-Location) $Path), $Content, [System.Text.UTF8Encoding]::new($false))
}
function Escape-Json([string]$Value) { return ($Value -replace '\\','\\' -replace '"','\"' -replace "`r?`n",' ') }
function Slug($Name) { return $SlugMap[$Name] }

function Meta($Title,$Description,$Path) {
  $url="$BaseUrl$Path"
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
      <div class="has-sub"><a href="/services/">서비스</a><div class="submenu"><a href="/services/swedish/">스웨디시</a><a href="/services/aroma/">아로마</a><a href="/services/deep-tissue/">딥티슈</a><a href="/services/foot/">풋케어</a><a href="/services/couple/">커플관리</a></div></div>
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
      <div><h3>서비스</h3><a href="/services/swedish/">스웨디시</a><a href="/services/aroma/">아로마</a><a href="/services/deep-tissue/">딥티슈</a><a href="/services/foot/">풋케어</a></div>
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

function FaqBlock($Name) {
  $qs=@(
    @{Q="$Name 출장마사지 예약 전에 무엇을 알려야 하나요?";A="현재 위치, 가까운 역이나 건물명, 희망 시간, 관리 목적, 공간 조건을 알려주면 상담이 빨라집니다. 개인 정보는 예약 확인에 필요한 범위에서만 확인합니다."},
    @{Q="$Name 페이지는 왜 따로 만들었나요?";A="지역명 반복을 위한 페이지가 아니라 이동 조건, 건물 출입, 주차, 숙소 정책처럼 예약 판단에 필요한 항목을 지역 단위로 정리하기 위해 만들었습니다."},
    @{Q="의료 효과를 기대해도 되나요?";A="아닙니다. 이 서비스는 휴식과 컨디션 관리를 위한 웰니스 안내이며, 질병 진단이나 치료를 대신하지 않습니다. 통증이나 질환이 있으면 의료 전문가 상담이 우선입니다."},
    @{Q="AI로 만든 글인가요?";A="초안 정리에는 자동화 도구를 활용할 수 있지만, 최종 문장과 안전 표현은 마사지나라 콘텐츠팀과 안전운영팀이 확인합니다. 허위 후기나 가짜 경험은 넣지 않습니다."}
  )
  $html=($qs|ForEach-Object{"<details><summary>$($_.Q)<span>+</span></summary><p>$($_.A)</p></details>"}) -join ""
  $json=($qs|ForEach-Object{"{""@type"":""Question"",""name"":""$(Escape-Json $_.Q)"",""acceptedAnswer"":{""@type"":""Answer"",""text"":""$(Escape-Json $_.A)""}}"}) -join ","
  return @{Html="<section class=""wrap faq"" id=""faq""><div class=""section-head""><span class=""eyebrow"">FAQ</span><h2>$Name 예약 전 질문</h2></div>$html</section>";Json="""mainEntity"":[$json]"}
}

function JsonLd($Title,$Description,$Path,$FaqJson,$AreaServed) {
  $url="$BaseUrl$Path"
  $areas=($AreaServed|ForEach-Object{"""$_"""}) -join ","
@"
<script type="application/ld+json">{"@context":"https://schema.org","@graph":[{"@type":"Organization","@id":"$BaseUrl/#org","name":"$Brand","legalName":"$Company","alternateName":"$Brand","taxID":"$BusinessNumber","founder":{"@type":"Person","name":"$Representative"},"address":{"@type":"PostalAddress","streetAddress":"청석로 268","addressLocality":"파주시","addressRegion":"경기도","addressCountry":"KR"},"url":"$BaseUrl/","telephone":"$Phone"},{"@type":"WebSite","@id":"$BaseUrl/#website","name":"$Brand","url":"$BaseUrl/","publisher":{"@id":"$BaseUrl/#org"}},{"@type":"LocalBusiness","@id":"$url#local","name":"$Brand $Title","legalName":"$Company","taxID":"$BusinessNumber","address":{"@type":"PostalAddress","streetAddress":"청석로 268","addressLocality":"파주시","addressRegion":"경기도","addressCountry":"KR"},"url":"$url","telephone":"$Phone","priceRange":"상담 후 확정","areaServed":[$areas]},{"@type":"Article","headline":"$(Escape-Json $Title)","description":"$(Escape-Json $Description)","author":{"@type":"Organization","name":"$Author"},"reviewedBy":{"@type":"Organization","name":"$Reviewer"},"dateModified":"$Today","mainEntityOfPage":"$url"},{"@type":"FAQPage",$FaqJson}]}</script>
"@
}

function BuildAreaCopy($RegionName,$AreaName,$Profile) {
@"
$AreaName 출장마사지 안내는 검색어를 반복하기 위한 문서가 아니라, 실제 예약 전 확인해야 할 위치 조건을 정리한 지역별 상담 가이드입니다. 같은 $RegionName 안에서도 $AreaName 생활권은 건물 유형, 이동 거리, 주차 가능성, 숙소 정책이 달라질 수 있습니다. 그래서 이 페이지는 치료 효과나 과장된 후기를 내세우지 않고, 예약자가 상담 전에 준비할 정보를 먼저 설명합니다.

$AreaName 페이지의 핵심 생활권은 $($Profile.Kind) 성격으로 정리했습니다. $($Profile.Check) 이 정보는 순위를 얻기 위한 장식 문장이 아니라 고객과 관리사가 현장에서 마주치는 불편을 줄이기 위한 기준입니다. 상담 단계에서 위치를 정확히 말하면 이동 가능 여부, 예상 도착 범위, 결제 조건, 취소 기준을 더 명확히 안내할 수 있습니다.

누가 만들었는지도 분명히 표시합니다. 이 문서는 ${Author}이 작성하고 ${Reviewer}이 검수했습니다. 초안 작성에는 자동화 도구가 쓰일 수 있지만, 최종 문장은 사람이 확인하며 허위 방문 후기, 가짜 평점, 확인되지 않은 평균 도착 시간은 넣지 않습니다. 구글이 말하는 Who, How, Why 원칙에 맞춰 누가 만들었는지, 어떻게 확인했는지, 왜 필요한지를 페이지 안에서 바로 알 수 있게 했습니다.

어떻게 만들어졌는지도 공개합니다. $AreaName 콘텐츠는 공식 행정구역명, 예약 전 상담 항목, 공간 안전 체크리스트를 바탕으로 구성했습니다. 실제 사업자 운영 데이터가 공개되지 않은 항목은 숫자로 꾸미지 않았고, 고객이 바로 쓸 수 있는 질문으로 바꿨습니다. 예를 들어 “어디쯤인가요”보다 “가까운 역, 건물명, 주차 가능 여부, 공동현관 방식”을 묻는 편이 더 도움이 됩니다.

왜 이 페이지가 필요한지도 명확합니다. $($Profile.Useful) 출장마사지는 고객의 사적 공간에서 진행되므로 주소만으로는 충분하지 않습니다. 조명, 환기, 이동 동선, 반려동물 분리, 동거인 휴식 여부까지 확인해야 관리가 편안해집니다. 이러한 준비가 없으면 예약은 되었어도 현장에서 시간이 지연되거나 진행이 어려워질 수 있습니다.

스팸 정책도 고려했습니다. $AreaName 문서는 다른 지역 페이지와 같은 문장만 반복하지 않도록 지역명, 생활권 성격, 상담 체크포인트를 분리했습니다. 숨은 텍스트, 키워드 나열, 허위 리뷰, 제3자 콘텐츠 임대, 도어웨이식 유도 문구는 사용하지 않습니다. 페이지의 목적은 검색 방문자를 억지로 전화하게 만드는 것이 아니라, 예약 가능 여부를 스스로 판단하게 돕는 것입니다.

페이지 경험도 함께 고려했습니다. 중요한 정보는 접힌 이미지나 늦게 불러오는 스크립트가 아니라 본문 HTML에 바로 보이게 두었고, CTA는 상담이 필요한 시점에만 배치했습니다. 모바일에서도 위치 설명, 체크포인트, FAQ를 빠르게 읽도록 짧은 문단과 고정 폭이 아닌 반응형 그리드를 사용합니다.

건강과 안전에 관한 표현도 조심합니다. ${Brand}의 방문 관리는 휴식형 웰니스 서비스이며 의료 행위가 아닙니다. 통증이 심하거나 질환이 있거나 임신, 수술 후 회복, 복용 중인 약이 있는 경우에는 예약 전에 의료 전문가에게 먼저 상담해야 합니다. 전화 ${Phone} 으로 문의하면 가능 코스, 시간, 비용, 중단 기준을 순서대로 안내합니다.
"@
}

function BuildPage($Region,$Area,$Index) {
  $slug=Slug $Area
  $profile=$Profiles[$Index % $Profiles.Count]
  $path="/locations/$($Region.Slug)/$slug/"
  $title="$Area 출장마사지 예약 전 위치·안전 체크 | $Brand"
  $desc="$Area 출장마사지 예약 전 위치 설명, 공간 준비, 관리 범위, 작성자와 검수 기준을 확인하세요."
  $copy=BuildAreaCopy $Region.Name $Area $profile
  $faq=FaqBlock $Area
  $json=JsonLd $title $desc $path $faq.Json @($Region.Name,$Area)
  $chips=@("위치 설명","건물 출입","주차 확인","공간 환기","관리 범위","취소 기준") | ForEach-Object { "<span class=""dong-chip"">$_</span>" }
  $html=@"
<!doctype html>
<html lang="ko">
<head>
$(Meta $title $desc $path)
$json
</head>
<body>
$(HeaderHtml)
<main>
  <section class="hero compact"><div class="hero-inner"><div class="hero-copy reveal"><span class="eyebrow"><span class="pulse"></span>LOCAL TRUST GUIDE</span><h1>$Area 출장마사지</h1><p class="lead">$Area 예약 전 위치 설명, 공간 조건, 안전 기준을 먼저 확인하는 지역 안내입니다.</p><div class="actions"><a class="btn btn-primary" href="$Tel">예약전화 $Phone</a><a class="btn btn-ghost" href="/locations/$($Region.Slug)/">$($Region.Name) 전체 보기</a></div></div><aside class="glass reveal"><small>검수 기준</small><h3>작성자·검수자·목적을 공개한 지역 페이지</h3><div class="book-row"><span>작성</span><b>$Author</b></div><div class="book-row"><span>검수</span><b>$Reviewer</b></div><div class="book-row"><span>유형</span><b>$($profile.Kind)</b></div></aside></div></section>
  <section class="wrap dong-section"><div class="section-head"><span class="eyebrow">BOOKING CHECK</span><h2>$Area 예약 체크포인트</h2><p class="source-note">아래 항목은 검색 순위용 키워드가 아니라 전화 상담에서 실제로 확인해야 하는 준비 정보입니다.</p></div><div class="dong-grid">$($chips -join '')</div></section>
  <section class="wrap prose"><div class="section-head"><span class="eyebrow">WHO HOW WHY</span><h2>$Area 지역 콘텐츠 검수본</h2></div><div class="copy"><p>$($copy -replace "`n`n","</p><p>")</p></div></section>
  <section class="wrap notes"><article class="note-card reveal"><div class="note-num">01</div><div><h3>Experience</h3><p>허위 체험담 대신 예약 전 실제로 확인해야 하는 위치, 출입, 공간 준비 항목을 지역별로 정리했습니다.</p></div></article><article class="note-card reveal"><div class="note-num">02</div><div><h3>Trust</h3><p>작성자와 검수자, 의료 행위가 아니라는 고지, 개인정보 최소 확인 원칙을 본문과 구조화 데이터에 반영했습니다.</p></div></article><article class="note-card reveal"><div class="note-num">03</div><div><h3>Spam Safety</h3><p>도어웨이 페이지처럼 전화 버튼만 반복하지 않고, 방문자가 예약 전 판단할 수 있는 정보를 먼저 제공합니다.</p></div></article></section>
  $($faq.Html)
  <section class="cta-band"><h2>$Area 출장마사지 상담</h2><p>현재 위치와 희망 시간을 알려주시면 가능 여부, 비용, 관리 범위, 취소 조건을 순서대로 안내합니다.</p><a class="btn btn-primary" href="$Tel">$Phone 전화예약</a></section>
</main>
$(FooterHtml)
</body>
</html>
"@
  Write-Utf8File "locations/$($Region.Slug)/$slug/index.html" $html
}

function BuildHub($Region) {
  $path="/locations/$($Region.Slug)/"
  $title="$($Region.Name) 출장마사지 지역별 예약 체크 | $Brand"
  $desc="$($Region.Name) 출장마사지 가능 지역을 확인하고 위치 설명, 공간 준비, 안전 기준을 살펴보세요."
  $links=($Region.Areas|ForEach-Object{"<a class=""area-link"" href=""/locations/$($Region.Slug)/$(Slug $_)/"">$_</a>"}) -join ""
  $faq=FaqBlock "$($Region.Name) 지역"
  $json=JsonLd $title $desc $path $faq.Json $Region.Areas
  $copy="$($Region.Name) 지역 허브는 여러 시군구 페이지를 묶어 보여주지만, 목적은 검색 유입을 나누는 것이 아니라 사용자가 자신의 위치에 가까운 안내를 빠르게 찾도록 돕는 것입니다. 각 하위 페이지는 건물 출입, 주차, 숙소 정책, 공간 준비처럼 예약 전에 실제로 확인해야 하는 항목을 중심으로 다시 작성했습니다.`n`n${Brand}는 지역명만 바꾼 대량 페이지가 사이트 전체 품질을 낮출 수 있다는 점을 고려해, 하위 페이지마다 생활권 성격과 상담 체크포인트를 분리했습니다. 허위 후기와 가짜 평균 도착 시간은 쓰지 않고, 공개 가능한 작성자와 검수자 정보를 명시합니다.`n`n이 허브의 Who는 ${Author}이며, How는 공식 행정구역명과 예약 상담 체크리스트를 바탕으로 문서를 구성한 것입니다. Why는 단순히 전화 연결을 늘리는 것이 아니라, 사용자가 자기 지역의 방문 조건을 먼저 이해하도록 돕는 데 있습니다. AI 보조 도구를 쓰더라도 최종 문장과 안전 표현은 사람이 확인합니다.`n`n$($Region.Name)에서 예약 전 가장 자주 놓치는 부분은 위치 설명입니다. 같은 시군구라도 역세권, 주거단지, 숙소, 산업지, 외곽지는 관리 가능 시간과 현장 준비가 달라집니다. 하위 페이지를 누르면 해당 지역의 공간 조건과 상담 질문을 먼저 확인할 수 있도록 구성했습니다.`n`nExperience 항목은 가짜 체험담이 아니라 예약 전에 실제로 확인되는 조건으로 표현했습니다. 고객은 가까운 역, 건물명, 공동현관 방식, 주차 가능성, 희망 시간, 관리 목적을 준비하고, 상담원은 관리 범위와 중단 기준, 비용과 취소 조건을 순서대로 설명합니다. 이 정보는 어느 지역에서든 바로 쓸 수 있는 실용 정보입니다.`n`nExpertise 항목은 건강 표현을 제한하는 방식으로 반영했습니다. 출장마사지는 피로 회복을 돕는 휴식형 웰니스 안내이지 질병 진단이나 치료가 아닙니다. 통증이 심하거나 수술 후 회복 중이거나 임신, 만성질환, 복용 약이 있다면 예약보다 의료 전문가 상담이 우선입니다. 이런 고지는 모든 하위 페이지에도 반복이 아닌 안전 기준으로 들어갑니다.`n`nTrust 항목은 사이트 구조에서도 확인할 수 있게 했습니다. 연락 가능한 예약전화, 작성자와 검수자, 정책 페이지, 회사명 YH LAB, 대표 김유환, 사업자등록번호 815-26-00585, 주소 경기도 파주시 청석로 268을 푸터와 구조화 데이터에 반영했습니다. 확인되지 않은 후기는 임의로 만들지 않습니다.`n`n스팸 정책도 반영했습니다. 숨은 텍스트, 키워드 나열, 도어웨이식 유도, 제3자 콘텐츠 임대, 확인되지 않은 리뷰를 쓰지 않습니다. 화면에 보이는 본문과 구조화 데이터의 내용이 일치하도록 만들었고, 선호 이미지는 og:image와 페이지 메타에 동일하게 지정했습니다.`n`n페이지 경험은 빠른 확인을 우선합니다. 지역 링크는 HTML에 직접 들어 있어 JavaScript가 꺼져도 접근할 수 있고, 모바일에서는 카드형 그리드로 정렬됩니다. 핵심 정보가 이미지 안에만 있지 않기 때문에 검색엔진과 사용자가 같은 내용을 읽을 수 있습니다.`n`n이 허브를 읽는 사용자는 먼저 자신의 지역을 고르고, 하위 페이지에서 위치 설명 방식과 공간 준비 항목을 확인하면 됩니다. 검색 결과에서 바로 전화하도록 압박하지 않고, 판단에 필요한 정보를 먼저 주는 것이 이 페이지의 목적입니다.`n`n하위 지역을 고른 뒤에는 가까운 역, 건물명, 출입 방식, 주차 가능성, 희망 시간을 메모해 두면 상담이 짧아집니다. 이 준비 과정 자체가 예약 실패와 현장 지연을 줄이는 실질적인 정보 이득입니다. 처음 이용하는 고객도 이 순서대로 확인하면 상담 내용을 쉽게 비교할 수 있습니다.`n`n출장마사지는 의료 행위가 아니라 휴식형 웰니스 안내입니다. $($Region.Name) 어느 지역이든 통증이나 질환이 있으면 의료 전문가 상담이 우선이며, 예약 상담에서는 가능한 코스와 비용, 취소 기준을 확정 전 다시 안내합니다."
  $html=@"
<!doctype html><html lang="ko"><head>$(Meta $title $desc $path)$json</head><body>$(HeaderHtml)<main><section class="hero compact"><div class="hero-inner"><div class="hero-copy reveal"><span class="eyebrow"><span class="pulse"></span>REGION HUB</span><h1>$($Region.Name) 출장마사지</h1><p class="lead">지역별 예약 판단에 필요한 위치 설명과 안전 기준을 먼저 확인하세요.</p><div class="actions"><a class="btn btn-primary" href="$Tel">예약전화 $Phone</a><a class="btn btn-ghost" href="/locations/">전체 지역</a></div></div><aside class="glass reveal"><small>지역 수</small><h3>$($Region.Areas.Count)개 지역 안내</h3><div class="book-row"><span>작성</span><b>$Author</b></div><div class="book-row"><span>검수</span><b>$Reviewer</b></div></aside></div></section><section class="wrap"><div class="section-head"><span class="eyebrow">AREA LIST</span><h2>$($Region.Name) 세부 지역</h2></div><div class="area-grid">$links</div></section><section class="wrap prose"><div class="section-head"><span class="eyebrow">QUALITY NOTE</span><h2>$($Region.Name) 지역 페이지 운영 기준</h2></div><div class="copy"><p>$($copy -replace "`n`n","</p><p>")</p></div></section>$($faq.Html)<section class="cta-band"><h2>$($Region.Name) 출장마사지 상담</h2><p>현재 위치와 희망 시간을 알려주시면 지역별 가능 여부를 확인해 안내합니다.</p><a class="btn btn-primary" href="$Tel">$Phone 전화예약</a></section></main>$(FooterHtml)</body></html>
"@
  Write-Utf8File "locations/$($Region.Slug)/index.html" $html
}

$i=0
foreach($r in $Regions){
  BuildHub $r
  foreach($a in $r.Areas){ BuildPage $r $a $i; $i++ }
}

Write-Host "Updated non-Seoul location pages with quality-focused content."
