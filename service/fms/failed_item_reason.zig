const std = @import("std");

pub const FailedItemReason = enum {
    not_valid_arn,
    not_valid_partition,
    not_valid_region,
    not_valid_service,
    not_valid_resource_type,
    not_valid_account_id,

    pub const json_field_names = .{
        .not_valid_arn = "NOT_VALID_ARN",
        .not_valid_partition = "NOT_VALID_PARTITION",
        .not_valid_region = "NOT_VALID_REGION",
        .not_valid_service = "NOT_VALID_SERVICE",
        .not_valid_resource_type = "NOT_VALID_RESOURCE_TYPE",
        .not_valid_account_id = "NOT_VALID_ACCOUNT_ID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_valid_arn => "NOT_VALID_ARN",
            .not_valid_partition => "NOT_VALID_PARTITION",
            .not_valid_region => "NOT_VALID_REGION",
            .not_valid_service => "NOT_VALID_SERVICE",
            .not_valid_resource_type => "NOT_VALID_RESOURCE_TYPE",
            .not_valid_account_id => "NOT_VALID_ACCOUNT_ID",
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
