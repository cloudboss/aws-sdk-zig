const std = @import("std");

pub const SigningAlgorithm = enum {
    rs256,
    ps256,
    es256,

    pub const json_field_names = .{
        .rs256 = "RS256",
        .ps256 = "PS256",
        .es256 = "ES256",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rs256 => "RS256",
            .ps256 => "PS256",
            .es256 => "ES256",
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
