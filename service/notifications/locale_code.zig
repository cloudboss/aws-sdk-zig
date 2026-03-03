const std = @import("std");

pub const LocaleCode = enum {
    /// German (Germany)
    de_de,
    /// English (Canada)
    en_ca,
    /// English (United States). This is the default locale.
    en_us,
    /// English (United Kingdom)
    en_uk,
    /// Spanish (Spain)
    es_es,
    /// French (Canada)
    fr_ca,
    /// French (France)
    fr_fr,
    /// Bahasa Indonesian (Indonesia)
    id_id,
    /// Italian (Italy)
    it_it,
    /// Japanese (Japan)
    ja_jp,
    /// Korean (Korea)
    ko_kr,
    /// Portuguese (Brazil)
    pt_br,
    /// Turkish (Turkey)
    tr_tr,
    /// Chinese (China)
    zh_cn,
    /// Chinese (Taiwan)
    zh_tw,

    pub const json_field_names = .{
        .de_de = "de_DE",
        .en_ca = "en_CA",
        .en_us = "en_US",
        .en_uk = "en_UK",
        .es_es = "es_ES",
        .fr_ca = "fr_CA",
        .fr_fr = "fr_FR",
        .id_id = "id_ID",
        .it_it = "it_IT",
        .ja_jp = "ja_JP",
        .ko_kr = "ko_KR",
        .pt_br = "pt_BR",
        .tr_tr = "tr_TR",
        .zh_cn = "zh_CN",
        .zh_tw = "zh_TW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .de_de => "de_DE",
            .en_ca => "en_CA",
            .en_us => "en_US",
            .en_uk => "en_UK",
            .es_es => "es_ES",
            .fr_ca => "fr_CA",
            .fr_fr => "fr_FR",
            .id_id => "id_ID",
            .it_it => "it_IT",
            .ja_jp => "ja_JP",
            .ko_kr => "ko_KR",
            .pt_br => "pt_BR",
            .tr_tr => "tr_TR",
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
