const std = @import("std");

pub const TranscriptionLanguage = enum {
    eng,
    eng_au,
    eng_gb,
    eng_us,
    fra,
    ita,
    deu,
    spa,
    por,

    pub const json_field_names = .{
        .eng = "eng",
        .eng_au = "eng-au",
        .eng_gb = "eng-gb",
        .eng_us = "eng-us",
        .fra = "fra",
        .ita = "ita",
        .deu = "deu",
        .spa = "spa",
        .por = "por",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eng => "eng",
            .eng_au => "eng-au",
            .eng_gb => "eng-gb",
            .eng_us => "eng-us",
            .fra => "fra",
            .ita => "ita",
            .deu => "deu",
            .spa => "spa",
            .por => "por",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
