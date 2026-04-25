const std = @import("std");

/// The locale code for localized content. Supported values include en_US,
/// de_DE, es_ES, fr_FR, id_ID, it_IT, ja_JP, ko_KR, pt_BR, zh_CN, and zh_TW.
pub const LocaleCode = enum {
    en_us,
    de_de,
    es_es,
    fr_fr,
    id_id,
    it_it,
    ja_jp,
    ko_kr,
    pt_br,
    zh_cn,
    zh_tw,

    pub const json_field_names = .{
        .en_us = "en_US",
        .de_de = "de_DE",
        .es_es = "es_ES",
        .fr_fr = "fr_FR",
        .id_id = "id_ID",
        .it_it = "it_IT",
        .ja_jp = "ja_JP",
        .ko_kr = "ko_KR",
        .pt_br = "pt_BR",
        .zh_cn = "zh_CN",
        .zh_tw = "zh_TW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .en_us => "en_US",
            .de_de => "de_DE",
            .es_es => "es_ES",
            .fr_fr => "fr_FR",
            .id_id => "id_ID",
            .it_it => "it_IT",
            .ja_jp => "ja_JP",
            .ko_kr => "ko_KR",
            .pt_br => "pt_BR",
            .zh_cn => "zh_CN",
            .zh_tw => "zh_TW",
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
