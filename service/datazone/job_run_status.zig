const std = @import("std");

pub const JobRunStatus = enum {
    scheduled,
    in_progress,
    success,
    partially_succeeded,
    failed,
    aborted,
    timed_out,
    canceled,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .partially_succeeded = "PARTIALLY_SUCCEEDED",
        .failed = "FAILED",
        .aborted = "ABORTED",
        .timed_out = "TIMED_OUT",
        .canceled = "CANCELED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scheduled => "SCHEDULED",
            .in_progress => "IN_PROGRESS",
            .success => "SUCCESS",
            .partially_succeeded => "PARTIALLY_SUCCEEDED",
            .failed => "FAILED",
            .aborted => "ABORTED",
            .timed_out => "TIMED_OUT",
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
