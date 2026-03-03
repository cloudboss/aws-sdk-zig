const std = @import("std");

/// Specifies the type of AWS account permitted to manage VPC endpoints.:
///
/// * AWS_ACCOUNT: Indicates that the account is owned by an AWS user.
///
/// * AWS_SERVICE: Indicates the the account is owned by an AWS service.
pub const PrincipalType = enum {
    aws_account,
    aws_service,

    pub const json_field_names = .{
        .aws_account = "AWS_ACCOUNT",
        .aws_service = "AWS_SERVICE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_account => "AWS_ACCOUNT",
            .aws_service => "AWS_SERVICE",
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
