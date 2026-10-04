const std = @import("std");

pub const JobExecutionStatus = enum {
    queued,
    in_progress,
    succeeded,
    failed,
    timed_out,
    rejected,
    removed,
    canceled,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .rejected = "REJECTED",
        .removed = "REMOVED",
        .canceled = "CANCELED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queued => "QUEUED",
            .in_progress => "IN_PROGRESS",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .timed_out => "TIMED_OUT",
            .rejected => "REJECTED",
            .removed => "REMOVED",
            .canceled => "CANCELED",
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
