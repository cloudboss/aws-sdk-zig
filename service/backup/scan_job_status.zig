const std = @import("std");

pub const ScanJobStatus = enum {
    created,
    completed,
    completed_with_issues,
    running,
    failed,
    canceled,
    aggregate_all,
    any,

    pub const json_field_names = .{
        .created = "CREATED",
        .completed = "COMPLETED",
        .completed_with_issues = "COMPLETED_WITH_ISSUES",
        .running = "RUNNING",
        .failed = "FAILED",
        .canceled = "CANCELED",
        .aggregate_all = "AGGREGATE_ALL",
        .any = "ANY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .completed => "COMPLETED",
            .completed_with_issues => "COMPLETED_WITH_ISSUES",
            .running => "RUNNING",
            .failed => "FAILED",
            .canceled => "CANCELED",
            .aggregate_all => "AGGREGATE_ALL",
            .any => "ANY",
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
