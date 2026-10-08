const std = @import("std");

pub const ListingBadgeType = enum {
    aws_free_tier,
    free_trial,
    deployed_on_aws,
    quick_launch,
    multi_product,

    pub const json_field_names = .{
        .aws_free_tier = "AWS_FREE_TIER",
        .free_trial = "FREE_TRIAL",
        .deployed_on_aws = "DEPLOYED_ON_AWS",
        .quick_launch = "QUICK_LAUNCH",
        .multi_product = "MULTI_PRODUCT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_free_tier => "AWS_FREE_TIER",
            .free_trial => "FREE_TRIAL",
            .deployed_on_aws => "DEPLOYED_ON_AWS",
            .quick_launch => "QUICK_LAUNCH",
            .multi_product => "MULTI_PRODUCT",
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
