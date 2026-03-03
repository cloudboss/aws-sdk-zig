const std = @import("std");

pub const Algorithm = enum {
    aes_128,
    aes_192,
    aes_256,

    pub const json_field_names = .{
        .aes_128 = "aes128",
        .aes_192 = "aes192",
        .aes_256 = "aes256",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aes_128 => "aes128",
            .aes_192 => "aes192",
            .aes_256 => "aes256",
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
