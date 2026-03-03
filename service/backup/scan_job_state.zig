const std = @import("std");

pub const ScanJobState = enum {
    completed,
    completed_with_issues,
    failed,
    canceled,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .completed_with_issues = "COMPLETED_WITH_ISSUES",
        .failed = "FAILED",
        .canceled = "CANCELED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .completed => "COMPLETED",
            .completed_with_issues => "COMPLETED_WITH_ISSUES",
            .failed => "FAILED",
            .canceled => "CANCELED",
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
