const std = @import("std");

pub const CallAnalyticsLanguageCode = enum {
    en_us,
    en_gb,
    es_us,
    fr_ca,
    fr_fr,
    en_au,
    it_it,
    de_de,
    pt_br,

    pub const json_field_names = .{
        .en_us = "en-US",
        .en_gb = "en-GB",
        .es_us = "es-US",
        .fr_ca = "fr-CA",
        .fr_fr = "fr-FR",
        .en_au = "en-AU",
        .it_it = "it-IT",
        .de_de = "de-DE",
        .pt_br = "pt-BR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .en_us => "en-US",
            .en_gb => "en-GB",
            .es_us => "es-US",
            .fr_ca => "fr-CA",
            .fr_fr => "fr-FR",
            .en_au => "en-AU",
            .it_it => "it-IT",
            .de_de => "de-DE",
            .pt_br => "pt-BR",
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
