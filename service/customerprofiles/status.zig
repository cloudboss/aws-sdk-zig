const std = @import("std");

pub const Status = enum {
    not_started,
    in_progress,
    complete,
    failed,
    split,
    retry,
    cancelled,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .failed = "FAILED",
        .split = "SPLIT",
        .retry = "RETRY",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "NOT_STARTED",
            .in_progress => "IN_PROGRESS",
            .complete => "COMPLETE",
            .failed => "FAILED",
            .split => "SPLIT",
            .retry => "RETRY",
            .cancelled => "CANCELLED",
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
