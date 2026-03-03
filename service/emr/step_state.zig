const std = @import("std");

pub const StepState = enum {
    pending,
    cancel_pending,
    running,
    completed,
    cancelled,
    failed,
    interrupted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .cancel_pending = "CANCEL_PENDING",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .interrupted = "INTERRUPTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .cancel_pending => "CANCEL_PENDING",
            .running => "RUNNING",
            .completed => "COMPLETED",
            .cancelled => "CANCELLED",
            .failed => "FAILED",
            .interrupted => "INTERRUPTED",
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
