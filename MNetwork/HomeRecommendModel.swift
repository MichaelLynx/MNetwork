//
//  HomeRecommendModel.swift
//  MNetwork
//
//  Created by Lynx on 03/04/2020.
//  Copyright © 2020 Lynx. All rights reserved.
//

import UIKit
import HandyJSON

struct FMHomeRecommendModel:HandyJSON {
    var msg:String?
    var ret:Int = 0
    var code:String?
    var list:[HomeRecommendModel]?
    
    //替换方法
    var id:String?
    mutating func mapping(mapper: HelpingMapper) {
        // 指定 id 字段用 "cat_id" 去解析.
        mapper.specify(property: &id, name: "cat_id")
    }
}

struct HomeRecommendModel:HandyJSON {
    var bottomHasMore: Bool = false
    var hasMore: Bool = false
    var list: [RecommendListModel]?
    var loopCount: Int = 0
    var moduleId: Int = 0
    var moduleType: String?
    var showInterestCard: Bool = false
    var title : String?
    
    var target: Target?
    var recWords: [RecWords]?
    
    var categoryId: Int = 0
    var direction: String?
    var keywords: [Keywords]?
}

struct Keywords: HandyJSON {
    var categoryId: Int = 0
    var categoryTitle: String?
    var keywordId: Int = 0
    var keywordName: String?
    var keywordType: Int = 0
    var materialType: String?
    var realCategoryId: Int = 0
}

struct RecWords: HandyJSON{
    var contentType: String?
    var properties:Properties?
    var title: String?
}

struct Target: HandyJSON{
    var groupId: Int = 0
    var categoryId: Int = 0
}

struct RecommendListModel: HandyJSON {
    var albumId: Int = 0
    var categoryId: Int = 0
    var commentsCount: Int = 0
    var commentScore: CGFloat = 0.0
    var discountedPrice: CGFloat = 0.0
    var displayDiscountedPrice: String?
    var displayPrice: String?
    var infoType: String?
    var isDraft: Bool = false
    var isFinished: Int = 0
    var isPaid: Bool = false
    var isVipFree: Bool = false
    var lastUptrackAt: Int = 0
    var materialType: String?
    var nickname: String?
    var pic: String?
    var playsCount: Int = 0
    var price: CGFloat = 0.0
    var priceTypeEnum: Int = 0
    var priceUnit: String?
    var recSrc: String?
    var recTrack: String?
    var refundSupportType: Int = 0
    var subtitle: String?
    var title: String?
    var tracksCount: Int = 0
    var vipFreeType: Int = 0
    var coverPath: String?
}

struct Properties: HandyJSON {
    var isPaid: Bool = false
    var type: String?
    var uri: String?
    var albumId: Int = 0
}
