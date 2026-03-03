const std = @import("std");

pub const CommandInvocationStatus = enum {
    pending,
    in_progress,
    delayed,
    success,
    cancelled,
    timed_out,
    failed,
    cancelling,

    pub const json_field_names = .{
        .pending = "Pending",
        .in_progress = "InProgress",
        .delayed = "Delayed",
        .success = "Success",
        .cancelled = "Cancelled",
        .timed_out = "TimedOut",
        .failed = "Failed",
        .cancelling = "Cancelling",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .in_progress => "InProgress",
            .delayed => "Delayed",
            .success => "Success",
            .cancelled => "Cancelled",
            .timed_out => "TimedOut",
            .failed => "Failed",
            .cancelling => "Cancelling",
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
