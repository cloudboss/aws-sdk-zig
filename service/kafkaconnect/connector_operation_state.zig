const std = @import("std");

pub const ConnectorOperationState = enum {
    pending,
    update_in_progress,
    update_complete,
    update_failed,
    rollback_in_progress,
    rollback_failed,
    rollback_complete,

    pub const json_field_names = .{
        .pending = "PENDING",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_complete = "UPDATE_COMPLETE",
        .update_failed = "UPDATE_FAILED",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_failed = "ROLLBACK_FAILED",
        .rollback_complete = "ROLLBACK_COMPLETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .update_complete => "UPDATE_COMPLETE",
            .update_failed => "UPDATE_FAILED",
            .rollback_in_progress => "ROLLBACK_IN_PROGRESS",
            .rollback_failed => "ROLLBACK_FAILED",
            .rollback_complete => "ROLLBACK_COMPLETE",
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
