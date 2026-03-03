const std = @import("std");

pub const ResourceStatus = enum {
    create_in_progress,
    create_failed,
    create_complete,
    delete_in_progress,
    delete_failed,
    delete_complete,
    delete_skipped,
    update_in_progress,
    update_failed,
    update_complete,
    import_failed,
    import_complete,
    import_in_progress,
    import_rollback_in_progress,
    import_rollback_failed,
    import_rollback_complete,
    export_failed,
    export_complete,
    export_in_progress,
    export_rollback_in_progress,
    export_rollback_failed,
    export_rollback_complete,
    update_rollback_in_progress,
    update_rollback_complete,
    update_rollback_failed,
    rollback_in_progress,
    rollback_complete,
    rollback_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .create_complete = "CREATE_COMPLETE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .delete_complete = "DELETE_COMPLETE",
        .delete_skipped = "DELETE_SKIPPED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_failed = "UPDATE_FAILED",
        .update_complete = "UPDATE_COMPLETE",
        .import_failed = "IMPORT_FAILED",
        .import_complete = "IMPORT_COMPLETE",
        .import_in_progress = "IMPORT_IN_PROGRESS",
        .import_rollback_in_progress = "IMPORT_ROLLBACK_IN_PROGRESS",
        .import_rollback_failed = "IMPORT_ROLLBACK_FAILED",
        .import_rollback_complete = "IMPORT_ROLLBACK_COMPLETE",
        .export_failed = "EXPORT_FAILED",
        .export_complete = "EXPORT_COMPLETE",
        .export_in_progress = "EXPORT_IN_PROGRESS",
        .export_rollback_in_progress = "EXPORT_ROLLBACK_IN_PROGRESS",
        .export_rollback_failed = "EXPORT_ROLLBACK_FAILED",
        .export_rollback_complete = "EXPORT_ROLLBACK_COMPLETE",
        .update_rollback_in_progress = "UPDATE_ROLLBACK_IN_PROGRESS",
        .update_rollback_complete = "UPDATE_ROLLBACK_COMPLETE",
        .update_rollback_failed = "UPDATE_ROLLBACK_FAILED",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_complete = "ROLLBACK_COMPLETE",
        .rollback_failed = "ROLLBACK_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "CREATE_IN_PROGRESS",
            .create_failed => "CREATE_FAILED",
            .create_complete => "CREATE_COMPLETE",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .delete_failed => "DELETE_FAILED",
            .delete_complete => "DELETE_COMPLETE",
            .delete_skipped => "DELETE_SKIPPED",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .update_failed => "UPDATE_FAILED",
            .update_complete => "UPDATE_COMPLETE",
            .import_failed => "IMPORT_FAILED",
            .import_complete => "IMPORT_COMPLETE",
            .import_in_progress => "IMPORT_IN_PROGRESS",
            .import_rollback_in_progress => "IMPORT_ROLLBACK_IN_PROGRESS",
            .import_rollback_failed => "IMPORT_ROLLBACK_FAILED",
            .import_rollback_complete => "IMPORT_ROLLBACK_COMPLETE",
            .export_failed => "EXPORT_FAILED",
            .export_complete => "EXPORT_COMPLETE",
            .export_in_progress => "EXPORT_IN_PROGRESS",
            .export_rollback_in_progress => "EXPORT_ROLLBACK_IN_PROGRESS",
            .export_rollback_failed => "EXPORT_ROLLBACK_FAILED",
            .export_rollback_complete => "EXPORT_ROLLBACK_COMPLETE",
            .update_rollback_in_progress => "UPDATE_ROLLBACK_IN_PROGRESS",
            .update_rollback_complete => "UPDATE_ROLLBACK_COMPLETE",
            .update_rollback_failed => "UPDATE_ROLLBACK_FAILED",
            .rollback_in_progress => "ROLLBACK_IN_PROGRESS",
            .rollback_complete => "ROLLBACK_COMPLETE",
            .rollback_failed => "ROLLBACK_FAILED",
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
