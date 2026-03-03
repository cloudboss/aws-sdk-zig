const std = @import("std");

pub const QuantumTaskStatus = enum {
    created,
    queued,
    running,
    completed,
    failed,
    cancelling,
    cancelled,

    pub const json_field_names = .{
        .created = "CREATED",
        .queued = "QUEUED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .queued => "QUEUED",
            .running => "RUNNING",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .cancelling => "CANCELLING",
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
