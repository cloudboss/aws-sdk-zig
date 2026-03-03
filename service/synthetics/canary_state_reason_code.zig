const std = @import("std");

pub const CanaryStateReasonCode = enum {
    invalid_permissions,
    create_pending,
    create_in_progress,
    create_failed,
    update_pending,
    update_in_progress,
    update_complete,
    rollback_complete,
    rollback_failed,
    delete_in_progress,
    delete_failed,
    sync_delete_in_progress,

    pub const json_field_names = .{
        .invalid_permissions = "INVALID_PERMISSIONS",
        .create_pending = "CREATE_PENDING",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .update_pending = "UPDATE_PENDING",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_complete = "UPDATE_COMPLETE",
        .rollback_complete = "ROLLBACK_COMPLETE",
        .rollback_failed = "ROLLBACK_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .sync_delete_in_progress = "SYNC_DELETE_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_permissions => "INVALID_PERMISSIONS",
            .create_pending => "CREATE_PENDING",
            .create_in_progress => "CREATE_IN_PROGRESS",
            .create_failed => "CREATE_FAILED",
            .update_pending => "UPDATE_PENDING",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .update_complete => "UPDATE_COMPLETE",
            .rollback_complete => "ROLLBACK_COMPLETE",
            .rollback_failed => "ROLLBACK_FAILED",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .delete_failed => "DELETE_FAILED",
            .sync_delete_in_progress => "SYNC_DELETE_IN_PROGRESS",
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
