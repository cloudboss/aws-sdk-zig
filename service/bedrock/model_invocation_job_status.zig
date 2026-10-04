const std = @import("std");

pub const ModelInvocationJobStatus = enum {
    submitted,
    in_progress,
    completed,
    failed,
    stopping,
    stopped,
    partially_completed,
    expired,
    validating,
    scheduled,

    pub const json_field_names = .{
        .submitted = "Submitted",
        .in_progress = "InProgress",
        .completed = "Completed",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .partially_completed = "PartiallyCompleted",
        .expired = "Expired",
        .validating = "Validating",
        .scheduled = "Scheduled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "Submitted",
            .in_progress => "InProgress",
            .completed => "Completed",
            .failed => "Failed",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .partially_completed => "PartiallyCompleted",
            .expired => "Expired",
            .validating => "Validating",
            .scheduled => "Scheduled",
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
