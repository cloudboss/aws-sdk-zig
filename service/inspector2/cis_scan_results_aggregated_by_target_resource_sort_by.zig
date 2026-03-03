const std = @import("std");

pub const CisScanResultsAggregatedByTargetResourceSortBy = enum {
    resource_id,
    failed_counts,
    account_id,
    platform,
    target_status,
    target_status_reason,

    pub const json_field_names = .{
        .resource_id = "RESOURCE_ID",
        .failed_counts = "FAILED_COUNTS",
        .account_id = "ACCOUNT_ID",
        .platform = "PLATFORM",
        .target_status = "TARGET_STATUS",
        .target_status_reason = "TARGET_STATUS_REASON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_id => "RESOURCE_ID",
            .failed_counts => "FAILED_COUNTS",
            .account_id => "ACCOUNT_ID",
            .platform => "PLATFORM",
            .target_status => "TARGET_STATUS",
            .target_status_reason => "TARGET_STATUS_REASON",
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
