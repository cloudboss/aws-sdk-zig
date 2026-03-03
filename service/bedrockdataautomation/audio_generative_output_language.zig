const std = @import("std");

/// Configuration for Audio output language
pub const AudioGenerativeOutputLanguage = enum {
    default,
    en,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .en = "EN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .en => "EN",
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
