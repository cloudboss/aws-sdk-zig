const std = @import("std");

pub const Locale = enum {
    de_de,
    en_us,
    en_gb,
    es_es,
    fr_fr,
    it_it,
    ja_jp,
    ko_kr,
    pt_br,
    zh_cn,
    zh_tw,

    pub const json_field_names = .{
        .de_de = "DE_DE",
        .en_us = "EN_US",
        .en_gb = "EN_GB",
        .es_es = "ES_ES",
        .fr_fr = "FR_FR",
        .it_it = "IT_IT",
        .ja_jp = "JA_JP",
        .ko_kr = "KO_KR",
        .pt_br = "PT_BR",
        .zh_cn = "ZH_CN",
        .zh_tw = "ZH_TW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .de_de => "DE_DE",
            .en_us => "EN_US",
            .en_gb => "EN_GB",
            .es_es => "ES_ES",
            .fr_fr => "FR_FR",
            .it_it => "IT_IT",
            .ja_jp => "JA_JP",
            .ko_kr => "KO_KR",
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
