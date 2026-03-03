const std = @import("std");

pub const AutomatedReasoningPolicyTestRunStatus = enum {
    not_started,
    scheduled,
    in_progress,
    completed,
    failed,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .scheduled = "SCHEDULED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "NOT_STARTED",
            .scheduled => "SCHEDULED",
            .in_progress => "IN_PROGRESS",
            .completed => "COMPLETED",
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
