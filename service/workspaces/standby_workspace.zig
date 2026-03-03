const DataReplication = @import("data_replication.zig").DataReplication;
const Tag = @import("tag.zig").Tag;

/// Describes a standby WorkSpace.
pub const StandbyWorkspace = struct {
    /// Indicates whether data replication is enabled, and if enabled, the type of
    /// data replication.
    data_replication: ?DataReplication = null,

    /// The identifier of the directory for the standby WorkSpace.
    directory_id: []const u8,

    /// The identifier of the standby WorkSpace.
    primary_workspace_id: []const u8,

    /// The tags associated with the standby WorkSpace.
    tags: ?[]const Tag = null,

    /// The volume encryption key of the standby WorkSpace.
    volume_encryption_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_replication = "DataReplication",
        .directory_id = "DirectoryId",
        .primary_workspace_id = "PrimaryWorkspaceId",
        .tags = "Tags",
        .volume_encryption_key = "VolumeEncryptionKey",
    };
};
