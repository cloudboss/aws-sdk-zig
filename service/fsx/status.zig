const std = @import("std");

pub const Status = enum {
    failed,
    in_progress,
    pending,
    completed,
    updated_optimizing,
    optimizing,
    paused,
    cancelled,

    pub const json_field_names = .{
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .pending = "PENDING",
        .completed = "COMPLETED",
        .updated_optimizing = "UPDATED_OPTIMIZING",
        .optimizing = "OPTIMIZING",
        .paused = "PAUSED",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failed => "FAILED",
            .in_progress => "IN_PROGRESS",
            .pending => "PENDING",
            .completed => "COMPLETED",
            .updated_optimizing => "UPDATED_OPTIMIZING",
            .optimizing => "OPTIMIZING",
            .paused => "PAUSED",
            .cancelled => "CANCELLED",
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
