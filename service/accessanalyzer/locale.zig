const std = @import("std");

pub const Locale = enum {
    de,
    en,
    es,
    fr,
    it,
    ja,
    ko,
    pt_br,
    zh_cn,
    zh_tw,

    pub const json_field_names = .{
        .de = "DE",
        .en = "EN",
        .es = "ES",
        .fr = "FR",
        .it = "IT",
        .ja = "JA",
        .ko = "KO",
        .pt_br = "PT_BR",
        .zh_cn = "ZH_CN",
        .zh_tw = "ZH_TW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .de => "DE",
            .en => "EN",
            .es => "ES",
            .fr => "FR",
            .it => "IT",
            .ja => "JA",
            .ko => "KO",
            .pt_br => "PT_BR",
            .zh_cn => "ZH_CN",
            .zh_tw => "ZH_TW",
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
