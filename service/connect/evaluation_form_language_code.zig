const std = @import("std");

pub const EvaluationFormLanguageCode = enum {
    de_de,
    en_us,
    es_es,
    fr_fr,
    it_it,
    pt_br,

    pub const json_field_names = .{
        .de_de = "de-DE",
        .en_us = "en-US",
        .es_es = "es-ES",
        .fr_fr = "fr-FR",
        .it_it = "it-IT",
        .pt_br = "pt-BR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .de_de => "de-DE",
            .en_us => "en-US",
            .es_es => "es-ES",
            .fr_fr => "fr-FR",
            .it_it => "it-IT",
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
