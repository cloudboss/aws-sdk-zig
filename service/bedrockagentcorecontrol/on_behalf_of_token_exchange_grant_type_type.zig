const std = @import("std");

pub const OnBehalfOfTokenExchangeGrantTypeType = enum {
    /// RFC 8693 token exchange, adopted by the majority of identity providers
    /// supporting on-behalf-of flows.
    token_exchange,
    /// RFC 7523 JWT authorization grant, adopted by Microsoft Entra ID.
    jwt_authorization_grant,

    pub const json_field_names = .{
        .token_exchange = "TOKEN_EXCHANGE",
        .jwt_authorization_grant = "JWT_AUTHORIZATION_GRANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .token_exchange => "TOKEN_EXCHANGE",
            .jwt_authorization_grant => "JWT_AUTHORIZATION_GRANT",
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
