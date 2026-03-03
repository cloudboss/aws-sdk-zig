const std = @import("std");

pub const SchemaExtensionStatus = enum {
    initializing,
    creating_snapshot,
    updating_schema,
    replicating,
    cancel_in_progress,
    rollback_in_progress,
    cancelled,
    failed,
    completed,

    pub const json_field_names = .{
        .initializing = "Initializing",
        .creating_snapshot = "CreatingSnapshot",
        .updating_schema = "UpdatingSchema",
        .replicating = "Replicating",
        .cancel_in_progress = "CancelInProgress",
        .rollback_in_progress = "RollbackInProgress",
        .cancelled = "Cancelled",
        .failed = "Failed",
        .completed = "Completed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "Initializing",
            .creating_snapshot => "CreatingSnapshot",
            .updating_schema => "UpdatingSchema",
            .replicating => "Replicating",
            .cancel_in_progress => "CancelInProgress",
            .rollback_in_progress => "RollbackInProgress",
            .cancelled => "Cancelled",
            .failed => "Failed",
            .completed => "Completed",
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
