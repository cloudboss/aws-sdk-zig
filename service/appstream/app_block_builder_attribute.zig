const std = @import("std");

pub const AppBlockBuilderAttribute = enum {
    iam_role_arn,
    access_endpoints,
    vpc_configuration_security_group_ids,

    pub const json_field_names = .{
        .iam_role_arn = "IAM_ROLE_ARN",
        .access_endpoints = "ACCESS_ENDPOINTS",
        .vpc_configuration_security_group_ids = "VPC_CONFIGURATION_SECURITY_GROUP_IDS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iam_role_arn => "IAM_ROLE_ARN",
            .access_endpoints => "ACCESS_ENDPOINTS",
            .vpc_configuration_security_group_ids => "VPC_CONFIGURATION_SECURITY_GROUP_IDS",
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
