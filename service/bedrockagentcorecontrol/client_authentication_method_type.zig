const std = @import("std");

pub const ClientAuthenticationMethodType = enum {
    client_secret_basic,
    client_secret_post,
    aws_iam_id_token_jwt,

    pub const json_field_names = .{
        .client_secret_basic = "CLIENT_SECRET_BASIC",
        .client_secret_post = "CLIENT_SECRET_POST",
        .aws_iam_id_token_jwt = "AWS_IAM_ID_TOKEN_JWT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .client_secret_basic => "CLIENT_SECRET_BASIC",
            .client_secret_post => "CLIENT_SECRET_POST",
            .aws_iam_id_token_jwt => "AWS_IAM_ID_TOKEN_JWT",
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
