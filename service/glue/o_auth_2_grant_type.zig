const std = @import("std");

pub const OAuth2GrantType = enum {
    authorization_code,
    client_credentials,
    jwt_bearer,
    refresh_token,

    pub const json_field_names = .{
        .authorization_code = "AUTHORIZATION_CODE",
        .client_credentials = "CLIENT_CREDENTIALS",
        .jwt_bearer = "JWT_BEARER",
        .refresh_token = "REFRESH_TOKEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .authorization_code => "AUTHORIZATION_CODE",
            .client_credentials => "CLIENT_CREDENTIALS",
            .jwt_bearer => "JWT_BEARER",
            .refresh_token => "REFRESH_TOKEN",
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
