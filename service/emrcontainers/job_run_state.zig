const std = @import("std");

pub const JobRunState = enum {
    pending,
    submitted,
    running,
    failed,
    cancelled,
    cancel_pending,
    completed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .submitted = "SUBMITTED",
        .running = "RUNNING",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
        .cancel_pending = "CANCEL_PENDING",
        .completed = "COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .submitted => "SUBMITTED",
            .running => "RUNNING",
            .failed => "FAILED",
            .cancelled => "CANCELLED",
            .cancel_pending => "CANCEL_PENDING",
            .completed => "COMPLETED",
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
