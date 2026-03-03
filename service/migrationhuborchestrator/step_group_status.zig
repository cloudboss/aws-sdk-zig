const std = @import("std");

pub const StepGroupStatus = enum {
    awaiting_dependencies,
    ready,
    in_progress,
    completed,
    failed,
    paused,
    pausing,
    user_attention_required,

    pub const json_field_names = .{
        .awaiting_dependencies = "AWAITING_DEPENDENCIES",
        .ready = "READY",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .paused = "PAUSED",
        .pausing = "PAUSING",
        .user_attention_required = "USER_ATTENTION_REQUIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .awaiting_dependencies => "AWAITING_DEPENDENCIES",
            .ready => "READY",
            .in_progress => "IN_PROGRESS",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .paused => "PAUSED",
            .pausing => "PAUSING",
            .user_attention_required => "USER_ATTENTION_REQUIRED",
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
