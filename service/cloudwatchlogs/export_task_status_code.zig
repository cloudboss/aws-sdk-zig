const std = @import("std");

pub const ExportTaskStatusCode = enum {
    cancelled,
    completed,
    failed,
    pending,
    pending_cancel,
    running,

    pub const json_field_names = .{
        .cancelled = "CANCELLED",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .pending = "PENDING",
        .pending_cancel = "PENDING_CANCEL",
        .running = "RUNNING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cancelled => "CANCELLED",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .pending => "PENDING",
            .pending_cancel => "PENDING_CANCEL",
            .running => "RUNNING",
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
