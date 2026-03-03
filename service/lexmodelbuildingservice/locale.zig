const std = @import("std");

pub const Locale = enum {
    de_de,
    en_au,
    en_gb,
    en_in,
    en_us,
    es_419,
    es_es,
    es_us,
    fr_fr,
    fr_ca,
    it_it,
    ja_jp,
    ko_kr,

    pub const json_field_names = .{
        .de_de = "de-DE",
        .en_au = "en-AU",
        .en_gb = "en-GB",
        .en_in = "en-IN",
        .en_us = "en-US",
        .es_419 = "es-419",
        .es_es = "es-ES",
        .es_us = "es-US",
        .fr_fr = "fr-FR",
        .fr_ca = "fr-CA",
        .it_it = "it-IT",
        .ja_jp = "ja-JP",
        .ko_kr = "ko-KR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .de_de => "de-DE",
            .en_au => "en-AU",
            .en_gb => "en-GB",
            .en_in => "en-IN",
            .en_us => "en-US",
            .es_419 => "es-419",
            .es_es => "es-ES",
            .es_us => "es-US",
            .fr_fr => "fr-FR",
            .fr_ca => "fr-CA",
            .it_it => "it-IT",
            .ja_jp => "ja-JP",
            .ko_kr => "ko-KR",
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
