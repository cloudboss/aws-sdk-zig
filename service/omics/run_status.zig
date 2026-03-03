const std = @import("std");

pub const RunStatus = enum {
    pending,
    starting,
    running,
    stopping,
    completed,
    deleted,
    cancelled,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .starting = "STARTING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .completed = "COMPLETED",
        .deleted = "DELETED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .starting => "STARTING",
            .running => "RUNNING",
            .stopping => "STOPPING",
            .completed => "COMPLETED",
            .deleted => "DELETED",
            .cancelled => "CANCELLED",
            .failed => "FAILED",
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
