const std = @import("std");

pub const JobStatus = enum {
    active,
    cancelled,
    cancelling,
    complete,
    completing,
    failed,
    failing,
    new,
    paused,
    pausing,
    preparing,
    ready,
    suspended,

    pub const json_field_names = .{
        .active = "Active",
        .cancelled = "Cancelled",
        .cancelling = "Cancelling",
        .complete = "Complete",
        .completing = "Completing",
        .failed = "Failed",
        .failing = "Failing",
        .new = "New",
        .paused = "Paused",
        .pausing = "Pausing",
        .preparing = "Preparing",
        .ready = "Ready",
        .suspended = "Suspended",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "Active",
            .cancelled => "Cancelled",
            .cancelling => "Cancelling",
            .complete => "Complete",
            .completing => "Completing",
            .failed => "Failed",
            .failing => "Failing",
            .new => "New",
            .paused => "Paused",
            .pausing => "Pausing",
            .preparing => "Preparing",
            .ready => "Ready",
            .suspended => "Suspended",
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
