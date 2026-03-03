const std = @import("std");

/// Supported language code for sending OTP message
pub const LanguageCodeString = enum {
    en_us,
    en_gb,
    es_419,
    es_es,
    de_de,
    fr_ca,
    fr_fr,
    it_it,
    jp_jp,
    pt_br,
    kr_kr,
    zh_cn,
    zh_tw,

    pub const json_field_names = .{
        .en_us = "en-US",
        .en_gb = "en-GB",
        .es_419 = "es-419",
        .es_es = "es-ES",
        .de_de = "de-DE",
        .fr_ca = "fr-CA",
        .fr_fr = "fr-FR",
        .it_it = "it-IT",
        .jp_jp = "ja-JP",
        .pt_br = "pt-BR",
        .kr_kr = "kr-KR",
        .zh_cn = "zh-CN",
        .zh_tw = "zh-TW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .en_us => "en-US",
            .en_gb => "en-GB",
            .es_419 => "es-419",
            .es_es => "es-ES",
            .de_de => "de-DE",
            .fr_ca => "fr-CA",
            .fr_fr => "fr-FR",
            .it_it => "it-IT",
            .jp_jp => "ja-JP",
            .pt_br => "pt-BR",
            .kr_kr => "kr-KR",
            .zh_cn => "zh-CN",
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
