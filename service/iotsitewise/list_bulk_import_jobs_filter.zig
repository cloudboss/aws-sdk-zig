const std = @import("std");

pub const ListBulkImportJobsFilter = enum {
    all,
    pending,
    running,
    cancelled,
    failed,
    completed_with_failures,
    completed,

    pub const json_field_names = .{
        .all = "ALL",
        .pending = "PENDING",
        .running = "RUNNING",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .completed_with_failures = "COMPLETED_WITH_FAILURES",
        .completed = "COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "ALL",
            .pending => "PENDING",
            .running => "RUNNING",
            .cancelled => "CANCELLED",
            .failed => "FAILED",
            .completed_with_failures => "COMPLETED_WITH_FAILURES",
            .completed => "COMPLETED",
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
