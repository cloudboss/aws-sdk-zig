const std = @import("std");

pub const EffectiveDeploymentExecutionStatus = enum {
    in_progress,
    queued,
    failed,
    completed,
    timed_out,
    canceled,
    rejected,
    succeeded,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .queued = "QUEUED",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .timed_out = "TIMED_OUT",
        .canceled = "CANCELED",
        .rejected = "REJECTED",
        .succeeded = "SUCCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .queued => "QUEUED",
            .failed => "FAILED",
            .completed => "COMPLETED",
            .timed_out => "TIMED_OUT",
            .canceled => "CANCELED",
            .rejected => "REJECTED",
            .succeeded => "SUCCEEDED",
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
