const std = @import("std");

pub const StatusType = enum {
    succeeded,
    failed,
    fault,
    timed_out,
    in_progress,
    stopped,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .fault = "FAULT",
        .timed_out = "TIMED_OUT",
        .in_progress = "IN_PROGRESS",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .fault => "FAULT",
            .timed_out => "TIMED_OUT",
            .in_progress => "IN_PROGRESS",
            .stopped => "STOPPED",
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
