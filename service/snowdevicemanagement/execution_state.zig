const std = @import("std");

pub const ExecutionState = enum {
    queued,
    in_progress,
    canceled,
    failed,
    succeeded,
    rejected,
    timed_out,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .canceled = "CANCELED",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .rejected = "REJECTED",
        .timed_out = "TIMED_OUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queued => "QUEUED",
            .in_progress => "IN_PROGRESS",
            .canceled => "CANCELED",
            .failed => "FAILED",
            .succeeded => "SUCCEEDED",
            .rejected => "REJECTED",
            .timed_out => "TIMED_OUT",
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
