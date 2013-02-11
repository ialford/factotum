# encoding: utf-8
module MonographicOrderHelper
  def monographic_order_header(title = "Order Requests")
    content_for(:content_title, content_tag(:h1, title))
    content_title_links(link_to("New Order Request", new_monographic_order_path(), class: 'btn'))
  end

  def monographic_breadcrumb(*crumbs)
    crumbs.unshift(link_to("Order Requests", monographic_orders_path))
    breadcrumb(*crumbs)
  end
  
  def monographic_order_errors_on_rush_order?(monographic_order)
    [:rush_order, :rush_order_reason, :rush_order_reason_other].any?{|field| monographic_order.errors[field].present?}
  end
  
  def monographic_order_errors_on_cataloging_location?(monographic_order)
    [:cataloging_location, :cataloging_location_other].any?{|field| monographic_order.errors[field].present?}
  end
  
  def monographic_selector_options
    Selector.monographic.default_order.collect{|s| [s.last_first, s.netid]}
  end

  def monographic_creator_search_options
    current_user.monographic_orders.creators.collect{|u| [u.last_first, u.netid]}
  end

  def monographic_selector_search_options
    current_user.monographic_orders.selectors.collect{|u| [u.last_first, u.netid]}
  end
  
  def selector_fund_selects
    content = raw("")
    Selector.includes(:selector_funds).all.each do |selector|
      content += select_tag("selector_#{selector.netid}", options_for_select(selector_fund_options(selector)))
    end
    content
  end
  
  def selector_fund_options(selector)
    if selector
      selector.selector_funds.collect{|f| f.name}.sort
    else
      []
    end
  end
  
  def worldcat_icon
    raw %(<a href="http://www.worldcat.org/" target="_blank"><img border="0" src="https://www.worldcat.org/images/wc_badge_80x15.gif?ai=University_jkennel" width="80" height="15" alt="WorldCat lets people access the collections of libraries worldwide [WorldCat.org]" title="WorldCat lets people access the collections of libraries worldwide [WorldCat.org]"></a>)
  end
  
  def monographic_rush_order_reasons
    RUSH_REASONS
  end
  
  def monographic_formats
    FORMATS
  end
  
  def monographic_collection_codes
    COLLECTION_CODES
  end
  
  def monographic_price_options
    PRICE_OPTIONS
  end
  
  PRICE_OPTIONS = [
    ["USD - United States Dollar", "USD"],
    ["EUR - Euro Member Countries", "EUR"],
    ["AED - United Arab Emirates Dirham", "AED"],
    ["AFN - Afghanistan Afghani", "AFN"],
    ["ALL - Albania Lek", "ALL"],
    ["AMD - Armenia Dram", "AMD"],
    ["ANG - Netherlands Antilles Guilder", "ANG"],
    ["AOA - Angola Kwanza", "AOA"],
    ["ARS - Argentina Peso", "ARS"],
    ["AUD - Australia Dollar", "AUD"],
    ["AWG - Aruba Guilder", "AWG"],
    ["AZN - Azerbaijan New Manat", "AZN"],
    ["BAM - Bosnia and Herzegovina Convertible Marka", "BAM"],
    ["BBD - Barbados Dollar", "BBD"],
    ["BDT - Bangladesh Taka", "BDT"],
    ["BGN - Bulgaria Lev", "BGN"],
    ["BHD - Bahrain Dinar", "BHD"],
    ["BIF - Burundi Franc", "BIF"],
    ["BMD - Bermuda Dollar", "BMD"],
    ["BND - Brunei Darussalam Dollar", "BND"],
    ["BOB - Bolivia Boliviano", "BOB"],
    ["BRL - Brazil Real", "BRL"],
    ["BSD - Bahamas Dollar", "BSD"],
    ["BTN - Bhutan Ngultrum", "BTN"],
    ["BWP - Botswana Pula", "BWP"],
    ["BYR - Belarus Ruble", "BYR"],
    ["BZD - Belize Dollar", "BZD"],
    ["CAD - Canada Dollar", "CAD"],
    ["CDF - Congo/Kinshasa Franc", "CDF"],
    ["CHF - Switzerland Franc", "CHF"],
    ["CLP - Chile Peso", "CLP"],
    ["CNY - China Yuan Renminbi", "CNY"],
    ["COP - Colombia Peso", "COP"],
    ["CRC - Costa Rica Colon", "CRC"],
    ["CUC - Cuba Convertible Peso", "CUC"],
    ["CUP - Cuba Peso", "CUP"],
    ["CVE - Cape Verde Escudo", "CVE"],
    ["CZK - Czech Republic Koruna", "CZK"],
    ["DJF - Djibouti Franc", "DJF"],
    ["DKK - Denmark Krone", "DKK"],
    ["DOP - Dominican Republic Peso", "DOP"],
    ["DZD - Algeria Dinar", "DZD"],
    ["EGP - Egypt Pound", "EGP"],
    ["ERN - Eritrea Nakfa", "ERN"],
    ["ETB - Ethiopia Birr", "ETB"],
    ["FJD - Fiji Dollar", "FJD"],
    ["FKP - Falkland Islands (Malvinas) Pound", "FKP"],
    ["GBP - United Kingdom Pound", "GBP"],
    ["GEL - Georgia Lari", "GEL"],
    ["GGP - Guernsey Pound", "GGP"],
    ["GHS - Ghana Cedi", "GHS"],
    ["GIP - Gibraltar Pound", "GIP"],
    ["GMD - Gambia Dalasi", "GMD"],
    ["GNF - Guinea Franc", "GNF"],
    ["GTQ - Guatemala Quetzal", "GTQ"],
    ["GYD - Guyana Dollar", "GYD"],
    ["HKD - Hong Kong Dollar", "HKD"],
    ["HNL - Honduras Lempira", "HNL"],
    ["HRK - Croatia Kuna", "HRK"],
    ["HTG - Haiti Gourde", "HTG"],
    ["HUF - Hungary Forint", "HUF"],
    ["IDR - Indonesia Rupiah", "IDR"],
    ["ILS - Israel Shekel", "ILS"],
    ["IMP - Isle of Man Pound", "IMP"],
    ["INR - India Rupee", "INR"],
    ["IQD - Iraq Dinar", "IQD"],
    ["IRR - Iran Rial", "IRR"],
    ["ISK - Iceland Krona", "ISK"],
    ["JEP - Jersey Pound", "JEP"],
    ["JMD - Jamaica Dollar", "JMD"],
    ["JOD - Jordan Dinar", "JOD"],
    ["JPY - Japan Yen", "JPY"],
    ["KES - Kenya Shilling", "KES"],
    ["KGS - Kyrgyzstan Som", "KGS"],
    ["KHR - Cambodia Riel", "KHR"],
    ["KMF - Comoros Franc", "KMF"],
    ["KPW - Korea (North) Won", "KPW"],
    ["KRW - Korea (South) Won", "KRW"],
    ["KWD - Kuwait Dinar", "KWD"],
    ["KYD - Cayman Islands Dollar", "KYD"],
    ["KZT - Kazakhstan Tenge", "KZT"],
    ["LAK - Laos Kip", "LAK"],
    ["LBP - Lebanon Pound", "LBP"],
    ["LKR - Sri Lanka Rupee", "LKR"],
    ["LRD - Liberia Dollar", "LRD"],
    ["LSL - Lesotho Loti", "LSL"],
    ["LTL - Lithuania Litas", "LTL"],
    ["LVL - Latvia Lat", "LVL"],
    ["LYD - Libya Dinar", "LYD"],
    ["MAD - Morocco Dirham", "MAD"],
    ["MDL - Moldova Leu", "MDL"],
    ["MGA - Madagascar Ariary", "MGA"],
    ["MKD - Macedonia Denar", "MKD"],
    ["MMK - Myanmar (Burma) Kyat", "MMK"],
    ["MNT - Mongolia Tughrik", "MNT"],
    ["MOP - Macau Pataca", "MOP"],
    ["MRO - Mauritania Ouguiya", "MRO"],
    ["MUR - Mauritius Rupee", "MUR"],
    ["MVR - Maldives (Maldive Islands) Rufiyaa", "MVR"],
    ["MWK - Malawi Kwacha", "MWK"],
    ["MXN - Mexico Peso", "MXN"],
    ["MYR - Malaysia Ringgit", "MYR"],
    ["MZN - Mozambique Metical", "MZN"],
    ["NAD - Namibia Dollar", "NAD"],
    ["NGN - Nigeria Naira", "NGN"],
    ["NIO - Nicaragua Cordoba", "NIO"],
    ["NOK - Norway Krone", "NOK"],
    ["NPR - Nepal Rupee", "NPR"],
    ["NZD - New Zealand Dollar", "NZD"],
    ["OMR - Oman Rial", "OMR"],
    ["PAB - Panama Balboa", "PAB"],
    ["PEN - Peru Nuevo Sol", "PEN"],
    ["PGK - Papua New Guinea Kina", "PGK"],
    ["PHP - Philippines Peso", "PHP"],
    ["PKR - Pakistan Rupee", "PKR"],
    ["PLN - Poland Zloty", "PLN"],
    ["PYG - Paraguay Guarani", "PYG"],
    ["QAR - Qatar Riyal", "QAR"],
    ["RON - Romania New Leu", "RON"],
    ["RSD - Serbia Dinar", "RSD"],
    ["RUB - Russia Ruble", "RUB"],
    ["RWF - Rwanda Franc", "RWF"],
    ["SAR - Saudi Arabia Riyal", "SAR"],
    ["SBD - Solomon Islands Dollar", "SBD"],
    ["SCR - Seychelles Rupee", "SCR"],
    ["SDG - Sudan Pound", "SDG"],
    ["SEK - Sweden Krona", "SEK"],
    ["SGD - Singapore Dollar", "SGD"],
    ["SHP - Saint Helena Pound", "SHP"],
    ["SLL - Sierra Leone Leone", "SLL"],
    ["SOS - Somalia Shilling", "SOS"],
    ["SPL - 	Seborga Luigino", "SPL"],
    ["SRD - Suriname Dollar", "SRD"],
    ["STD - São Principe and Tome Dobra", "STD"],
    ["SVC - El Salvador Colon", "SVC"],
    ["SYP - Syria Pound", "SYP"],
    ["SZL - Swaziland Lilangeni", "SZL"],
    ["THB - Thailand Baht", "THB"],
    ["TJS - Tajikistan Somoni", "TJS"],
    ["TMT - Turkmenistan Manat", "TMT"],
    ["TND - Tunisia Dinar", "TND"],
    ["TOP - Tonga Pa'anga", "TOP"],
    ["TRY - Turkey Lira", "TRY"],
    ["TTD - Trinidad and Tobago Dollar", "TTD"],
    ["TVD - Tuvalu Dollar", "TVD"],
    ["TWD - Taiwan New Dollar", "TWD"],
    ["TZS - Tanzania Shilling", "TZS"],
    ["UAH - Ukraine Hryvna", "UAH"],
    ["UGX - Uganda Shilling", "UGX"],
    ["UYU - Uruguay Peso", "UYU"],
    ["UZS - Uzbekistan Som", "UZS"],
    ["VEF - Venezuela Bolivar Fuerte", "VEF"],
    ["VND - Viet Nam Dong", "VND"],
    ["VUV - Vanuatu Vatu", "VUV"],
    ["WST - Samoa Tala", "WST"],
    ["XAF - Communauté Financière Africaine (BEAC) CFA Franc BEAC", "XAF"],
    ["XCD - East Caribbean Dollar", "XCD"],
    ["XDR - International Monetary Fund (IMF) Special Drawing Rights", "XDR"],
    ["XOF - Communauté Financière Africaine (BCEAO) Franc", "XOF"],
    ["XPF - Comptoirs Français du Pacifique (CFP) Franc", "XPF"],
    ["YER - Yemen Rial", "YER"],
    ["ZAR - South Africa Rand", "ZAR"],
    ["ZMK - Zambia Kwacha", "ZMK"],
    ["ZWD - Zimbabwe Dollar", "ZWD"],
  ]
  
  FORMATS = [
    "Book",
    "Blu-ray",
    "DVD",
    "CD",
  ]
  
  RUSH_REASONS = [
    "Needed for class", 
    "Limited availability", 
    "For reserve"
  ]
  
  COLLECTION_CODES = [
    "ARCHT/ARCV",
    "ARCHT/ARDVD",
    "ARCHT/ARMAP",
    "ARCHT/ARVID",
    "ARCHT/CAR",
    "ARCHT/CLASS",
    "ARCHT/FLOV",
    "ARCHT/FURN",
    "ARCHT/GEN",
    "ARCHT/MORF",
    "ARCHT/OVER",
    "ARCHT/RARE",
    "ARCHT/REF",
    "ARCHT/REFOV",
    "ARCHT/RESTH",
    "AUDIO/CASS",
    "AUDIO/CD",
    "AUDIO/DVD",
    "AUDIO/GEN",
    "AUDIO/LASER",
    "AUDIO/REC",
    "AUDIO/REEL",
    "AUDIO/VIDEO",
    "BIC/GEN",
    "BIC/CARER",
    "BIC/MEDIA",
    "BIC/BICRF",
    "CAMPR/CPL",
    "CAMPR/CPLSE",
    "CAMPR/CSCNO",
    "CAMPR/GRC",
    "CAMPR/ILS",
    "CAMPR/ILSRA",
    "CAMPR/KANEB",
    "CAMPR/LABSR",
    "CAMPR/LANG",
    "CAMPR/MEDIA",
    "CAMPR/ROLFS",
    "CAMPR/SMART",
    "CAMPR/SMPHO",
    "CHEMP/GEN",
    "CHEMP/OVER",
    "CHEMP/SPEC",
    "CPC",
    "DOCS/EUCOM",
    "DOCS/EURCD",
    "ENGIN/GEN",
    "ENGIN/OVER",
    "ENGIN/REF",
    "ENGIN/RESV",
    "ENGIN/RREF",
    "HESB/ACQ",
    "HESB/ADMIN",
    "HESB/ANAS",
    "HESB/BIND",
    "HESB/BYZRF",
    "HESB/CAT",
    "HESB/CREO",
    "HESB/FLAT",
    "HESB/FLATL",
    "HESB/GEN",
    "HESB/ILL",
    "HESB/INET",
    "HESB/MARS",
    "HESB/MUS",
    "HESB/MUSOF",
    "HESB/MUSRF",
    "HESB/OCAT",
    "HESB/ONEIL",
    "HESB/OVER",
    "HESB/OVERL",
    "HESB/PRES",
    "HESB/RES",
    "HESB/SRCAT",
    "HESB/SRDEP",
    "HESB/STATS",
    "HESB/THREF",
    "HESB/THRFO",
    "KELLO/GEN",
    "KELLO/PEACE",
    "LIBNT/NT@ND",
    "LIBNT/WWW",
    "LIBNT/GOPHR",
    "LIBNT/TELNT",
    "LIBNT/FTP",
    "LIFES/OPEN",
    "LIFES/NORA",
    "MATH/GEN",
    "MATH/MORSE",
    "MATH/RARE",
    "MATH/REF",
    "MATH/RREF",
    "MATH/STATS",
    "MEDIN/715",
    "MEDIN/715Q",
    "MEDIN/AMBR",
    "MEDIN/BYZ",
    "MEDIN/BYZRF",
    "MEDIN/DUMON",
    "MEDIN/GEN",
    "MEDIN/OLD",
    "MEDIN/OVER",
    "MEDIN/UNIV",
    "MICRO/GEN",
    "MICRO/CLOSE",
    "MICRO/GUIDE",
    "MRARE/MRARE",
    "RADLB/GEN",
    "REF/ATLAS",
    "REF/CREF",
    "REF/GEN",
    "REF/OVER",
    "REF/RFDOC",
    "ROME/ARGEN",
    "SPEC/CAPAM",
    "SPEC/DANTE",
    "SPEC/DANTO",
    "SPEC/GILL",
    "SPEC/GOREY",
    "SPEC/GREEN",
    "SPEC/HESB",
    "SPEC/LATAM",
    "SPEC/MINI",
    "SPEC/ND",
    "SPEC/NDOV",
    "SPEC/PARHI",
    "SPEC/PAUL6",
    "SPEC/PENG",
    "SPEC/RARE",
    "SPEC/RBOV",
    "SPEC/REF",
    "SPEC/SHAW",
    "SPEC/SHAWO",
    "SPEC/SMITH",
    "SPEC/SPORT",
    "SPEC/SPTRF",
    "SPEC/VAT2",
    "SPEC/VAULT",
  ]
end
