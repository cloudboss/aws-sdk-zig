const std = @import("std");

/// State of a workspace.
pub const WorkspaceStatusCode = enum {
    /// Workspace is being created. Deletion is disallowed until status is ACTIVE.
    creating,
    /// Workspace has been created and is usable.
    active,
    /// Workspace is being updated. Updates are allowed only when status is ACTIVE.
    updating,
    /// Workspace is being deleted. Deletions are allowed only when status is
    /// ACTIVE.
    deleting,
    /// Workspace creation failed. Refer to WorkspaceStatus.failureReason for more
    /// details.
    creation_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .creation_failed = "CREATION_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .creation_failed => "CREATION_FAILED",
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
