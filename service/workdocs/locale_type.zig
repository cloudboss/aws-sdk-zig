const std = @import("std");

pub const LocaleType = enum {
    en,
    fr,
    ko,
    de,
    es,
    ja,
    ru,
    zh_cn,
    zh_tw,
    pt_br,
    default,

    pub const json_field_names = .{
        .en = "en",
        .fr = "fr",
        .ko = "ko",
        .de = "de",
        .es = "es",
        .ja = "ja",
        .ru = "ru",
        .zh_cn = "zh_CN",
        .zh_tw = "zh_TW",
        .pt_br = "pt_BR",
        .default = "default",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .en => "en",
            .fr => "fr",
            .ko => "ko",
            .de => "de",
            .es => "es",
            .ja => "ja",
            .ru => "ru",
            .zh_cn => "zh_CN",
            .zh_tw => "zh_TW",
            .pt_br => "pt_BR",
            .default => "default",
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
