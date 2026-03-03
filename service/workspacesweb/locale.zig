const std = @import("std");

pub const Locale = enum {
    de,
    en,
    es,
    fr,
    id,
    it,
    jp,
    kr,
    br,
    cn,
    tw,

    pub const json_field_names = .{
        .de = "de-DE",
        .en = "en-US",
        .es = "es-ES",
        .fr = "fr-FR",
        .id = "id-ID",
        .it = "it-IT",
        .jp = "ja-JP",
        .kr = "ko-KR",
        .br = "pt-BR",
        .cn = "zh-CN",
        .tw = "zh-TW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .de => "de-DE",
            .en => "en-US",
            .es => "es-ES",
            .fr => "fr-FR",
            .id => "id-ID",
            .it => "it-IT",
            .jp => "ja-JP",
            .kr => "ko-KR",
            .br => "pt-BR",
            .cn => "zh-CN",
            .tw => "zh-TW",
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
