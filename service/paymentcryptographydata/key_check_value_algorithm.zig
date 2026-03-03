const std = @import("std");

pub const KeyCheckValueAlgorithm = enum {
    cmac,
    ansi_x9_24,
    hmac,
    sha_1,

    pub const json_field_names = .{
        .cmac = "CMAC",
        .ansi_x9_24 = "ANSI_X9_24",
        .hmac = "HMAC",
        .sha_1 = "SHA_1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cmac => "CMAC",
            .ansi_x9_24 => "ANSI_X9_24",
            .hmac => "HMAC",
            .sha_1 => "SHA_1",
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
