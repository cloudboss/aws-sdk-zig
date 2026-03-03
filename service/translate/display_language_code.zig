const std = @import("std");

pub const DisplayLanguageCode = enum {
    de,
    en,
    es,
    fr,
    it,
    ja,
    ko,
    pt,
    zh,
    zh_tw,

    pub const json_field_names = .{
        .de = "de",
        .en = "en",
        .es = "es",
        .fr = "fr",
        .it = "it",
        .ja = "ja",
        .ko = "ko",
        .pt = "pt",
        .zh = "zh",
        .zh_tw = "zh-TW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .de => "de",
            .en => "en",
            .es => "es",
            .fr => "fr",
            .it => "it",
            .ja => "ja",
            .ko => "ko",
            .pt => "pt",
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
