const std = @import("std");

pub const LanguageCode = enum {
    en_us,
    en_gb,
    id_id,
    de_de,
    es_es,
    fr_fr,
    ja_jp,
    it_it,
    pt_pt,
    ko_kr,
    zh_cn,
    zh_tw,
    tr_tr,

    pub const json_field_names = .{
        .en_us = "en-US",
        .en_gb = "en-GB",
        .id_id = "id-ID",
        .de_de = "de-DE",
        .es_es = "es-ES",
        .fr_fr = "fr-FR",
        .ja_jp = "ja-JP",
        .it_it = "it-IT",
        .pt_pt = "pt-PT",
        .ko_kr = "ko-KR",
        .zh_cn = "zh-CN",
        .zh_tw = "zh-TW",
        .tr_tr = "tr-TR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .en_us => "en-US",
            .en_gb => "en-GB",
            .id_id => "id-ID",
            .de_de => "de-DE",
            .es_es => "es-ES",
            .fr_fr => "fr-FR",
            .ja_jp => "ja-JP",
            .it_it => "it-IT",
            .pt_pt => "pt-PT",
            .ko_kr => "ko-KR",
            .zh_cn => "zh-CN",
            .zh_tw => "zh-TW",
            .tr_tr => "tr-TR",
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
