const std = @import("std");

/// The status of a classification job. Possible values are:
pub const JobStatus = enum {
    running,
    paused,
    cancelled,
    complete,
    idle,
    user_paused,

    pub const json_field_names = .{
        .running = "RUNNING",
        .paused = "PAUSED",
        .cancelled = "CANCELLED",
        .complete = "COMPLETE",
        .idle = "IDLE",
        .user_paused = "USER_PAUSED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .running => "RUNNING",
            .paused => "PAUSED",
            .cancelled => "CANCELLED",
            .complete => "COMPLETE",
            .idle => "IDLE",
            .user_paused => "USER_PAUSED",
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
