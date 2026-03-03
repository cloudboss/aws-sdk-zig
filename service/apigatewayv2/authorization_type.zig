const std = @import("std");

/// The authorization type. For WebSocket APIs, valid values are NONE for open
/// access, AWS_IAM for using AWS IAM permissions, and CUSTOM for using a Lambda
/// authorizer. For HTTP APIs, valid values are NONE for open access, JWT for
/// using JSON Web Tokens, AWS_IAM for using AWS IAM permissions, and CUSTOM for
/// using a Lambda authorizer.
pub const AuthorizationType = enum {
    none,
    aws_iam,
    custom,
    jwt,

    pub const json_field_names = .{
        .none = "NONE",
        .aws_iam = "AWS_IAM",
        .custom = "CUSTOM",
        .jwt = "JWT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .aws_iam => "AWS_IAM",
            .custom => "CUSTOM",
            .jwt => "JWT",
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
