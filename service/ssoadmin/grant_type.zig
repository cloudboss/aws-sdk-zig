const std = @import("std");

pub const GrantType = enum {
    authorization_code,
    refresh_token,
    jwt_bearer,
    token_exchange,

    pub const json_field_names = .{
        .authorization_code = "authorization_code",
        .refresh_token = "refresh_token",
        .jwt_bearer = "urn:ietf:params:oauth:grant-type:jwt-bearer",
        .token_exchange = "urn:ietf:params:oauth:grant-type:token-exchange",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .authorization_code => "authorization_code",
            .refresh_token => "refresh_token",
            .jwt_bearer => "urn:ietf:params:oauth:grant-type:jwt-bearer",
            .token_exchange => "urn:ietf:params:oauth:grant-type:token-exchange",
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
