const std = @import("std");

pub const ActionTypeEnum = enum {
    forward,
    authenticate_oidc,
    authenticate_cognito,
    redirect,
    fixed_response,
    jwt_validation,

    pub const json_field_names = .{
        .forward = "forward",
        .authenticate_oidc = "authenticate-oidc",
        .authenticate_cognito = "authenticate-cognito",
        .redirect = "redirect",
        .fixed_response = "fixed-response",
        .jwt_validation = "jwt-validation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .forward => "forward",
            .authenticate_oidc => "authenticate-oidc",
            .authenticate_cognito => "authenticate-cognito",
            .redirect => "redirect",
            .fixed_response => "fixed-response",
            .jwt_validation => "jwt-validation",
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
