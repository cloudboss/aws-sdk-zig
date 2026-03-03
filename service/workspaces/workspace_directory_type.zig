const std = @import("std");

pub const WorkspaceDirectoryType = enum {
    simple_ad,
    ad_connector,
    customer_managed,
    aws_iam_identity_center,

    pub const json_field_names = .{
        .simple_ad = "SIMPLE_AD",
        .ad_connector = "AD_CONNECTOR",
        .customer_managed = "CUSTOMER_MANAGED",
        .aws_iam_identity_center = "AWS_IAM_IDENTITY_CENTER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .simple_ad => "SIMPLE_AD",
            .ad_connector => "AD_CONNECTOR",
            .customer_managed => "CUSTOMER_MANAGED",
            .aws_iam_identity_center => "AWS_IAM_IDENTITY_CENTER",
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
