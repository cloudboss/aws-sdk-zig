const std = @import("std");

pub const ListCisScansSortBy = enum {
    status,
    scheduled_by,
    scan_start_date,
    failed_checks,

    pub const json_field_names = .{
        .status = "STATUS",
        .scheduled_by = "SCHEDULED_BY",
        .scan_start_date = "SCAN_START_DATE",
        .failed_checks = "FAILED_CHECKS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .status => "STATUS",
            .scheduled_by => "SCHEDULED_BY",
            .scan_start_date => "SCAN_START_DATE",
            .failed_checks => "FAILED_CHECKS",
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
