//
//  Storage.swift
//  Navigation
//
//  Created by Stepas Vilkelis on 24.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

struct PostData {
    let author: String
    var description: String?
    var image: String?
    var likes: Int = 0
    var views: Int = 0
}

struct PostSection {
    var title: String? = nil
    let posts: [PostData]
    var footer: String? = nil
}

struct catalogImage {
    var image: String?
}

struct Storage {
    static let catalogModel: [catalogImage] = {
        var array: [catalogImage] = []
        for i in 0...17 {
            array.append(catalogImage(image: "Image-\(i)"))
        }
        return array
    }()
    
    static let tableModel = [
        PostSection(
            posts: [
                PostData(
                    author: "Кто такие хипстеры: история, культура, тренды",
                    description: "В узком смысле хипстеры – странники, облаченные в бабушкины джемперы, завсегдатаи модных тусовок и художественных выставок. Эти ребята есть в каждом уголке планеты, и не заметить их невозможно, ведь они умеют выделяться в толпе, становясь невольными заложниками собственной идеологии. Не будь серой массой, выделяйся – этот пункт записан крафтовым пивом в контракте каждого хипстера.",
                    image: "cat_1",
                    likes: 10,
                    views: 20
                ),
                PostData(
                    author: "Эти ребята не делают ничего предосудительного",
                    description: "Однако часто вызывают хайп вокруг себя, причем не всегда в хорошем смысле этого слова. Так что же не так с этими модными парнями и девушками? Или, может, что-то не так со всеми нами?",
                    image: "cat_2",
                    likes: 11,
                    views: 222
                ),
                PostData(
                    author: "История возникновения культуры хипстеров",
                    description: "Субкультура хипстеров зародилась в Америке в конце 1940-х годов. «Отголосок второй мировой» изначально формировался, как тусовка молодых завсегдатаев джаз-клубов. Эти ребята старались жить здесь и сейчас, отвергая темное прошлое войны и не желая знать ничего о будущем. Как и в наши дни, хипстеры того периода также старались выглядеть стильно.",
                    image: "cat_3",
                    likes: 20,
                    views: 22
                ),
                PostData(
                    author: "Кто такие cовременные хипстеры",
                    description: "В начале нулевых на улицах вновь стали появляться стильные ребята, предпочитающие выставки и клубы алкоголю в парадном и турничкам во дворе. Современные хипстеры – неоднородная, многообразная и многонациональная культура, многие яркие представители которой сами не относят себя к числу хипстеров.",
                    image: "cat_4",
                    likes: 34,
                    views: 300
                )
            ]
        )
    ]
    
}
