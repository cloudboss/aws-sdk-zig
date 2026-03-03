const std = @import("std");

pub const DeploymentStatus = enum {
    completed,
    creating,
    delete_in_progress,
    delete_initiating,
    delete_failed,
    deleted,
    failed,
    in_progress,
    validating,
    update_in_progress,
    update_completed,
    update_failed,
    update_rollback_completed,
    update_rollback_failed,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .creating = "CREATING",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_initiating = "DELETE_INITIATING",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .validating = "VALIDATING",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_completed = "UPDATE_COMPLETED",
        .update_failed = "UPDATE_FAILED",
        .update_rollback_completed = "UPDATE_ROLLBACK_COMPLETED",
        .update_rollback_failed = "UPDATE_ROLLBACK_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .completed => "COMPLETED",
            .creating => "CREATING",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .delete_initiating => "DELETE_INITIATING",
            .delete_failed => "DELETE_FAILED",
            .deleted => "DELETED",
            .failed => "FAILED",
            .in_progress => "IN_PROGRESS",
            .validating => "VALIDATING",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .update_completed => "UPDATE_COMPLETED",
            .update_failed => "UPDATE_FAILED",
            .update_rollback_completed => "UPDATE_ROLLBACK_COMPLETED",
            .update_rollback_failed => "UPDATE_ROLLBACK_FAILED",
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
