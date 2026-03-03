const std = @import("std");

pub const DataKeySpec = enum {
    aes_256,
    aes_128,

    pub const json_field_names = .{
        .aes_256 = "AES_256",
        .aes_128 = "AES_128",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aes_256 => "AES_256",
            .aes_128 => "AES_128",
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
