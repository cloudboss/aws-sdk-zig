const std = @import("std");

/// A signal map's current status which is dependent on its lifecycle actions or
/// associated jobs.
pub const SignalMapStatus = enum {
    create_in_progress,
    create_complete,
    create_failed,
    update_in_progress,
    update_complete,
    update_reverted,
    update_failed,
    ready,
    not_ready,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_complete = "CREATE_COMPLETE",
        .create_failed = "CREATE_FAILED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_complete = "UPDATE_COMPLETE",
        .update_reverted = "UPDATE_REVERTED",
        .update_failed = "UPDATE_FAILED",
        .ready = "READY",
        .not_ready = "NOT_READY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "CREATE_IN_PROGRESS",
            .create_complete => "CREATE_COMPLETE",
            .create_failed => "CREATE_FAILED",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .update_complete => "UPDATE_COMPLETE",
            .update_reverted => "UPDATE_REVERTED",
            .update_failed => "UPDATE_FAILED",
            .ready => "READY",
            .not_ready => "NOT_READY",
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
