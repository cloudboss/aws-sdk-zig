const std = @import("std");

/// Type of authentication provider.
pub const AuthenticationProviderType = enum {
    /// Credentials stored in AWS Secrets Manager.
    secrets_manager,
    /// Credentials retrieved via AWS Lambda function.
    aws_lambda,
    /// Authentication using an AWS IAM role.
    aws_iam_role,
    /// Internal AWS authentication.
    aws_internal,

    pub const json_field_names = .{
        .secrets_manager = "SECRETS_MANAGER",
        .aws_lambda = "AWS_LAMBDA",
        .aws_iam_role = "AWS_IAM_ROLE",
        .aws_internal = "AWS_INTERNAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .secrets_manager => "SECRETS_MANAGER",
            .aws_lambda => "AWS_LAMBDA",
            .aws_iam_role => "AWS_IAM_ROLE",
            .aws_internal => "AWS_INTERNAL",
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
