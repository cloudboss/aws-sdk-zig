const std = @import("std");

pub const KbIngestionStatus = enum {
    queued,
    running,
    failed,
    completed,
    incomplete,
    cancelled,
    cancelling,
    timeout,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .running = "RUNNING",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .incomplete = "INCOMPLETE",
        .cancelled = "CANCELLED",
        .cancelling = "CANCELLING",
        .timeout = "TIMEOUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queued => "QUEUED",
            .running => "RUNNING",
            .failed => "FAILED",
            .completed => "COMPLETED",
            .incomplete => "INCOMPLETE",
            .cancelled => "CANCELLED",
            .cancelling => "CANCELLING",
            .timeout => "TIMEOUT",
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
