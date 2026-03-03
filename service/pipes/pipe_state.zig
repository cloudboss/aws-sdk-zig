const std = @import("std");

pub const PipeState = enum {
    running,
    stopped,
    creating,
    updating,
    deleting,
    starting,
    stopping,
    create_failed,
    update_failed,
    start_failed,
    stop_failed,
    delete_failed,
    create_rollback_failed,
    delete_rollback_failed,
    update_rollback_failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .stopped = "STOPPED",
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .start_failed = "START_FAILED",
        .stop_failed = "STOP_FAILED",
        .delete_failed = "DELETE_FAILED",
        .create_rollback_failed = "CREATE_ROLLBACK_FAILED",
        .delete_rollback_failed = "DELETE_ROLLBACK_FAILED",
        .update_rollback_failed = "UPDATE_ROLLBACK_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .running => "RUNNING",
            .stopped => "STOPPED",
            .creating => "CREATING",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .starting => "STARTING",
            .stopping => "STOPPING",
            .create_failed => "CREATE_FAILED",
            .update_failed => "UPDATE_FAILED",
            .start_failed => "START_FAILED",
            .stop_failed => "STOP_FAILED",
            .delete_failed => "DELETE_FAILED",
            .create_rollback_failed => "CREATE_ROLLBACK_FAILED",
            .delete_rollback_failed => "DELETE_ROLLBACK_FAILED",
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
