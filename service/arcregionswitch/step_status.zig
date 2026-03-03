const std = @import("std");

pub const StepStatus = enum {
    not_started,
    running,
    failed,
    completed,
    cancelled,
    skipped,
    pending_approval,

    pub const json_field_names = .{
        .not_started = "notStarted",
        .running = "running",
        .failed = "failed",
        .completed = "completed",
        .cancelled = "canceled",
        .skipped = "skipped",
        .pending_approval = "pendingApproval",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "notStarted",
            .running => "running",
            .failed => "failed",
            .completed => "completed",
            .cancelled => "canceled",
            .skipped => "skipped",
            .pending_approval => "pendingApproval",
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
