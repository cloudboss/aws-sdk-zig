const std = @import("std");

pub const SftpAuthenticationMethods = enum {
    password,
    public_key,
    public_key_or_password,
    public_key_and_password,

    pub const json_field_names = .{
        .password = "PASSWORD",
        .public_key = "PUBLIC_KEY",
        .public_key_or_password = "PUBLIC_KEY_OR_PASSWORD",
        .public_key_and_password = "PUBLIC_KEY_AND_PASSWORD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .password => "PASSWORD",
            .public_key => "PUBLIC_KEY",
            .public_key_or_password => "PUBLIC_KEY_OR_PASSWORD",
            .public_key_and_password => "PUBLIC_KEY_AND_PASSWORD",
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
