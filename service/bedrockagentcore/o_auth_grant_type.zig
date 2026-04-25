const std = @import("std");

pub const OAuthGrantType = enum {
    client_credentials,
    authorization_code,

    pub const json_field_names = .{
        .client_credentials = "CLIENT_CREDENTIALS",
        .authorization_code = "AUTHORIZATION_CODE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .client_credentials => "CLIENT_CREDENTIALS",
            .authorization_code => "AUTHORIZATION_CODE",
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
