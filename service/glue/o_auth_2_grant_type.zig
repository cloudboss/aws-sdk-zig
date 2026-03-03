const std = @import("std");

pub const OAuth2GrantType = enum {
    authorization_code,
    client_credentials,
    jwt_bearer,

    pub const json_field_names = .{
        .authorization_code = "AUTHORIZATION_CODE",
        .client_credentials = "CLIENT_CREDENTIALS",
        .jwt_bearer = "JWT_BEARER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .authorization_code => "AUTHORIZATION_CODE",
            .client_credentials => "CLIENT_CREDENTIALS",
            .jwt_bearer => "JWT_BEARER",
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
