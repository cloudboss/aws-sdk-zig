const std = @import("std");

pub const AuthenticationType = enum {
    password,
    token,
    x509,

    pub const json_field_names = .{
        .password = "PASSWORD",
        .token = "TOKEN",
        .x509 = "X509",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .password => "PASSWORD",
            .token => "TOKEN",
            .x509 => "X509",
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
