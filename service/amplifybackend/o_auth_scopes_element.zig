const std = @import("std");

pub const OAuthScopesElement = enum {
    phone,
    email,
    openid,
    profile,
    aws_cognito_signin_user_admin,

    pub const json_field_names = .{
        .phone = "PHONE",
        .email = "EMAIL",
        .openid = "OPENID",
        .profile = "PROFILE",
        .aws_cognito_signin_user_admin = "AWS_COGNITO_SIGNIN_USER_ADMIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .phone => "PHONE",
            .email => "EMAIL",
            .openid => "OPENID",
            .profile => "PROFILE",
            .aws_cognito_signin_user_admin => "AWS_COGNITO_SIGNIN_USER_ADMIN",
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
