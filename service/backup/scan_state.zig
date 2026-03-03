const std = @import("std");

pub const ScanState = enum {
    canceled,
    completed,
    completed_with_issues,
    created,
    failed,
    running,

    pub const json_field_names = .{
        .canceled = "CANCELED",
        .completed = "COMPLETED",
        .completed_with_issues = "COMPLETED_WITH_ISSUES",
        .created = "CREATED",
        .failed = "FAILED",
        .running = "RUNNING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .canceled => "CANCELED",
            .completed => "COMPLETED",
            .completed_with_issues => "COMPLETED_WITH_ISSUES",
            .created => "CREATED",
            .failed => "FAILED",
            .running => "RUNNING",
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
