const std = @import("std");

/// Dvb Sub Ocr Language
pub const DvbSubOcrLanguage = enum {
    deu,
    eng,
    fra,
    nld,
    por,
    spa,

    pub const json_field_names = .{
        .deu = "DEU",
        .eng = "ENG",
        .fra = "FRA",
        .nld = "NLD",
        .por = "POR",
        .spa = "SPA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deu => "DEU",
            .eng => "ENG",
            .fra => "FRA",
            .nld => "NLD",
            .por => "POR",
            .spa => "SPA",
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
