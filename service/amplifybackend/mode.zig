const std = @import("std");

pub const Mode = enum {
    api_key,
    aws_iam,
    amazon_cognito_user_pools,
    openid_connect,

    pub const json_field_names = .{
        .api_key = "API_KEY",
        .aws_iam = "AWS_IAM",
        .amazon_cognito_user_pools = "AMAZON_COGNITO_USER_POOLS",
        .openid_connect = "OPENID_CONNECT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .api_key => "API_KEY",
            .aws_iam => "AWS_IAM",
            .amazon_cognito_user_pools => "AMAZON_COGNITO_USER_POOLS",
            .openid_connect => "OPENID_CONNECT",
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
