const std = @import("std");

pub const SessionLifecycleStatus = enum {
    started,
    update_in_progress,
    update_succeeded,
    update_failed,
    ended,

    pub const json_field_names = .{
        .started = "STARTED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_succeeded = "UPDATE_SUCCEEDED",
        .update_failed = "UPDATE_FAILED",
        .ended = "ENDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .started => "STARTED",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .update_succeeded => "UPDATE_SUCCEEDED",
            .update_failed => "UPDATE_FAILED",
            .ended => "ENDED",
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
