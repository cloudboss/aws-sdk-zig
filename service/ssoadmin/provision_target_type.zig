const std = @import("std");

pub const ProvisionTargetType = enum {
    aws_account,
    all_provisioned_accounts,

    pub const json_field_names = .{
        .aws_account = "AWS_ACCOUNT",
        .all_provisioned_accounts = "ALL_PROVISIONED_ACCOUNTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_account => "AWS_ACCOUNT",
            .all_provisioned_accounts => "ALL_PROVISIONED_ACCOUNTS",
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
