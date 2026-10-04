const std = @import("std");

pub const VoiceAnalyticsLanguageCode = enum {
    en_us,

    pub const json_field_names = .{
        .en_us = "en-US",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .en_us => "en-US",
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
