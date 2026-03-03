const std = @import("std");

pub const LanguageCode = enum {
    en,
    es,
    fr,
    de,
    it,
    pt,
    ar,
    hi,
    ja,
    ko,
    zh,
    zh_tw,

    pub const json_field_names = .{
        .en = "en",
        .es = "es",
        .fr = "fr",
        .de = "de",
        .it = "it",
        .pt = "pt",
        .ar = "ar",
        .hi = "hi",
        .ja = "ja",
        .ko = "ko",
        .zh = "zh",
        .zh_tw = "zh-TW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .en => "en",
            .es => "es",
            .fr => "fr",
            .de => "de",
            .it => "it",
            .pt => "pt",
            .ar => "ar",
            .hi => "hi",
            .ja => "ja",
            .ko => "ko",
            .zh => "zh",
            .zh_tw => "zh-TW",
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
