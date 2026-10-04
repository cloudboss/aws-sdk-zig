const std = @import("std");

/// Placeholder documentation for Algorithm
pub const Algorithm = enum {
    aes128,
    aes192,
    aes256,

    pub const json_field_names = .{
        .aes128 = "AES128",
        .aes192 = "AES192",
        .aes256 = "AES256",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aes128 => "AES128",
            .aes192 => "AES192",
            .aes256 => "AES256",
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
