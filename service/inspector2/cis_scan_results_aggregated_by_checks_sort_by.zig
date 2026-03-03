const std = @import("std");

pub const CisScanResultsAggregatedByChecksSortBy = enum {
    check_id,
    title,
    platform,
    failed_counts,
    security_level,

    pub const json_field_names = .{
        .check_id = "CHECK_ID",
        .title = "TITLE",
        .platform = "PLATFORM",
        .failed_counts = "FAILED_COUNTS",
        .security_level = "SECURITY_LEVEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .check_id => "CHECK_ID",
            .title => "TITLE",
            .platform => "PLATFORM",
            .failed_counts => "FAILED_COUNTS",
            .security_level => "SECURITY_LEVEL",
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
