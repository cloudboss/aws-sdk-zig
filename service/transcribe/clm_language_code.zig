const std = @import("std");

pub const CLMLanguageCode = enum {
    en_us,
    hi_in,
    es_us,
    en_gb,
    en_au,
    de_de,
    ja_jp,

    pub const json_field_names = .{
        .en_us = "en-US",
        .hi_in = "hi-IN",
        .es_us = "es-US",
        .en_gb = "en-GB",
        .en_au = "en-AU",
        .de_de = "de-DE",
        .ja_jp = "ja-JP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .en_us => "en-US",
            .hi_in => "hi-IN",
            .es_us => "es-US",
            .en_gb => "en-GB",
            .en_au => "en-AU",
            .de_de => "de-DE",
            .ja_jp => "ja-JP",
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
