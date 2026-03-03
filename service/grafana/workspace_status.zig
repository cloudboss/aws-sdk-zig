const std = @import("std");

pub const WorkspaceStatus = enum {
    /// Workspace is active.
    active,
    /// Workspace is being created.
    creating,
    /// Workspace is being deleted.
    deleting,
    /// Workspace is in an invalid state, it can only and should be deleted.
    failed,
    /// Workspace is being updated.
    updating,
    /// Workspace is being upgraded to enterprise.
    upgrading,
    /// Workspace deletion failed.
    deletion_failed,
    /// Workspace creation failed.
    creation_failed,
    /// Workspace update failed.
    update_failed,
    /// Workspace upgrade failed.
    upgrade_failed,
    /// Failed to remove enterprise license from workspace.
    license_removal_failed,
    /// Workspace version is being updated.
    version_updating,
    /// Workspace version update failed.
    version_update_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .updating = "UPDATING",
        .upgrading = "UPGRADING",
        .deletion_failed = "DELETION_FAILED",
        .creation_failed = "CREATION_FAILED",
        .update_failed = "UPDATE_FAILED",
        .upgrade_failed = "UPGRADE_FAILED",
        .license_removal_failed = "LICENSE_REMOVAL_FAILED",
        .version_updating = "VERSION_UPDATING",
        .version_update_failed = "VERSION_UPDATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .creating => "CREATING",
            .deleting => "DELETING",
            .failed => "FAILED",
            .updating => "UPDATING",
            .upgrading => "UPGRADING",
            .deletion_failed => "DELETION_FAILED",
            .creation_failed => "CREATION_FAILED",
            .update_failed => "UPDATE_FAILED",
            .upgrade_failed => "UPGRADE_FAILED",
            .license_removal_failed => "LICENSE_REMOVAL_FAILED",
            .version_updating => "VERSION_UPDATING",
            .version_update_failed => "VERSION_UPDATE_FAILED",
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
