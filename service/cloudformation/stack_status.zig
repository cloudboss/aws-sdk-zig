const std = @import("std");

pub const StackStatus = enum {
    create_in_progress,
    create_failed,
    create_complete,
    rollback_in_progress,
    rollback_failed,
    rollback_complete,
    delete_in_progress,
    delete_failed,
    delete_complete,
    update_in_progress,
    update_complete_cleanup_in_progress,
    update_complete,
    update_failed,
    update_rollback_in_progress,
    update_rollback_failed,
    update_rollback_complete_cleanup_in_progress,
    update_rollback_complete,
    review_in_progress,
    import_in_progress,
    import_complete,
    import_rollback_in_progress,
    import_rollback_failed,
    import_rollback_complete,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .create_complete = "CREATE_COMPLETE",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_failed = "ROLLBACK_FAILED",
        .rollback_complete = "ROLLBACK_COMPLETE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .delete_complete = "DELETE_COMPLETE",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_complete_cleanup_in_progress = "UPDATE_COMPLETE_CLEANUP_IN_PROGRESS",
        .update_complete = "UPDATE_COMPLETE",
        .update_failed = "UPDATE_FAILED",
        .update_rollback_in_progress = "UPDATE_ROLLBACK_IN_PROGRESS",
        .update_rollback_failed = "UPDATE_ROLLBACK_FAILED",
        .update_rollback_complete_cleanup_in_progress = "UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS",
        .update_rollback_complete = "UPDATE_ROLLBACK_COMPLETE",
        .review_in_progress = "REVIEW_IN_PROGRESS",
        .import_in_progress = "IMPORT_IN_PROGRESS",
        .import_complete = "IMPORT_COMPLETE",
        .import_rollback_in_progress = "IMPORT_ROLLBACK_IN_PROGRESS",
        .import_rollback_failed = "IMPORT_ROLLBACK_FAILED",
        .import_rollback_complete = "IMPORT_ROLLBACK_COMPLETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "CREATE_IN_PROGRESS",
            .create_failed => "CREATE_FAILED",
            .create_complete => "CREATE_COMPLETE",
            .rollback_in_progress => "ROLLBACK_IN_PROGRESS",
            .rollback_failed => "ROLLBACK_FAILED",
            .rollback_complete => "ROLLBACK_COMPLETE",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .delete_failed => "DELETE_FAILED",
            .delete_complete => "DELETE_COMPLETE",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .update_complete_cleanup_in_progress => "UPDATE_COMPLETE_CLEANUP_IN_PROGRESS",
            .update_complete => "UPDATE_COMPLETE",
            .update_failed => "UPDATE_FAILED",
            .update_rollback_in_progress => "UPDATE_ROLLBACK_IN_PROGRESS",
            .update_rollback_failed => "UPDATE_ROLLBACK_FAILED",
            .update_rollback_complete_cleanup_in_progress => "UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS",
            .update_rollback_complete => "UPDATE_ROLLBACK_COMPLETE",
            .review_in_progress => "REVIEW_IN_PROGRESS",
            .import_in_progress => "IMPORT_IN_PROGRESS",
            .import_complete => "IMPORT_COMPLETE",
            .import_rollback_in_progress => "IMPORT_ROLLBACK_IN_PROGRESS",
            .import_rollback_failed => "IMPORT_ROLLBACK_FAILED",
            .import_rollback_complete => "IMPORT_ROLLBACK_COMPLETE",
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
