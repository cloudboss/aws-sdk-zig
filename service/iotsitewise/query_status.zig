const std = @import("std");

/// The status of a query execution.
pub const QueryStatus = enum {
    submitted,
    running,
    completed,
    failed,
    canceled,
    canceling,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .canceled = "CANCELED",
        .canceling = "CANCELING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .running => "RUNNING",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .canceled => "CANCELED",
            .canceling => "CANCELING",
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
