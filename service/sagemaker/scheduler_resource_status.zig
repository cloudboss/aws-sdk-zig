const std = @import("std");

pub const SchedulerResourceStatus = enum {
    creating,
    create_failed,
    create_rollback_failed,
    created,
    updating,
    update_failed,
    update_rollback_failed,
    updated,
    deleting,
    delete_failed,
    delete_rollback_failed,
    deleted,

    pub const json_field_names = .{
        .creating = "Creating",
        .create_failed = "CreateFailed",
        .create_rollback_failed = "CreateRollbackFailed",
        .created = "Created",
        .updating = "Updating",
        .update_failed = "UpdateFailed",
        .update_rollback_failed = "UpdateRollbackFailed",
        .updated = "Updated",
        .deleting = "Deleting",
        .delete_failed = "DeleteFailed",
        .delete_rollback_failed = "DeleteRollbackFailed",
        .deleted = "Deleted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .create_failed => "CreateFailed",
            .create_rollback_failed => "CreateRollbackFailed",
            .created => "Created",
            .updating => "Updating",
            .update_failed => "UpdateFailed",
            .update_rollback_failed => "UpdateRollbackFailed",
            .updated => "Updated",
            .deleting => "Deleting",
            .delete_failed => "DeleteFailed",
            .delete_rollback_failed => "DeleteRollbackFailed",
            .deleted => "Deleted",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
