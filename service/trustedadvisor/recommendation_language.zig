const std = @import("std");

pub const RecommendationLanguage = enum {
    english,
    japanese,
    chinese,
    french,
    german,
    korean,
    traditional_chinese,
    italian,
    spanish,
    brazilian_portuguese,
    bahasa_indonesia,

    pub const json_field_names = .{
        .english = "en",
        .japanese = "ja",
        .chinese = "zh",
        .french = "fr",
        .german = "de",
        .korean = "ko",
        .traditional_chinese = "zh_TW",
        .italian = "it",
        .spanish = "es",
        .brazilian_portuguese = "pt_BR",
        .bahasa_indonesia = "id",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .english => "en",
            .japanese => "ja",
            .chinese => "zh",
            .french => "fr",
            .german => "de",
            .korean => "ko",
            .traditional_chinese => "zh_TW",
            .italian => "it",
            .spanish => "es",
            .brazilian_portuguese => "pt_BR",
            .bahasa_indonesia => "id",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
