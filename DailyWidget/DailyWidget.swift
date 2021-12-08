//
//  DailyWidget.swift
//  DailyWidget
//
//  Created by GoEun Jeong on 2020/12/02.
//  Copyright © 2020 jge. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DailyEntry {
        return DailyEntry(content: "하나님은 인생이 아니시니 식언치 않으시고 인자가 아니시니 후회가 없으시도다 어찌 그 말씀하신 바를 행치 않으시며 하신 말씀을 실행치 않으시랴.", bible: "민수기 23장 19절")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (DailyEntry) -> Void) {
        let entry = DailyEntry(content: "하나님은 인생이 아니시니 식언치 않으시고 인자가 아니시니 후회가 없으시도다 어찌 그 말씀하신 바를 행치 않으시며 하신 말씀을 실행치 않으시랴.", bible: "민수기 23장 19절")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let converter = Converter.shared
        
        let refreshDate = Calendar.current.date(byAdding: .hour, value: 6, to: Date())!
        let entry = DailyEntry(content: DailyRepositoryImpl.dailyData[converter.days-1].content,
                               bible: DailyRepositoryImpl.dailyData[converter.days-1].bible)
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
}

struct DailyEntry: TimelineEntry {
    var date: Date = Date()
    
    var content: String = ""
    var bible: String = ""
}

struct DailyWidgetEntryView: View {
    var entry: DailyEntry
    private let converter = Converter.shared
    
    var body: some View {
        VStack(spacing: 10) {
            Text(entry.content)
            Text(entry.bible)
        }.padding(.all, 10)
    }
}

@main
struct DailyWidget: Widget {
    let kind: String = "DailyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DailyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("데일리 성경")
        .description("오늘의 말씀을 볼 수 있습니다.")
        .supportedFamilies([.systemMedium])
    }
}

struct DailyWidget_Previews: PreviewProvider {
    static var previews: some View {
        DailyWidgetEntryView(entry: DailyEntry(content: "하나님은 인생이 아니시니 식언치 않으시고 인자가 아니시니 후회가 없으시도다 어찌 그 말씀하신 바를 행치 않으시며 하신 말씀을 실행치 않으시랴.", bible: "민수기 23장 19절"))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
