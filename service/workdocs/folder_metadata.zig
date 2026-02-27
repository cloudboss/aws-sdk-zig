const ResourceStateType = @import("resource_state_type.zig").ResourceStateType;

/// Describes a folder.
pub const FolderMetadata = struct {
    /// The time when the folder was created.
    created_timestamp: ?i64,

    /// The ID of the creator.
    creator_id: ?[]const u8,

    /// The ID of the folder.
    id: ?[]const u8,

    /// List of labels on the folder.
    labels: ?[]const []const u8,

    /// The size of the latest version of the folder metadata.
    latest_version_size: ?i64,

    /// The time when the folder was updated.
    modified_timestamp: ?i64,

    /// The name of the folder.
    name: ?[]const u8,

    /// The ID of the parent folder.
    parent_folder_id: ?[]const u8,

    /// The resource state of the folder.
    resource_state: ?ResourceStateType,

    /// The unique identifier created from the subfolders and documents of the
    /// folder.
    signature: ?[]const u8,

    /// The size of the folder metadata.
    size: ?i64,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .creator_id = "CreatorId",
        .id = "Id",
        .labels = "Labels",
        .latest_version_size = "LatestVersionSize",
        .modified_timestamp = "ModifiedTimestamp",
        .name = "Name",
        .parent_folder_id = "ParentFolderId",
        .resource_state = "ResourceState",
        .signature = "Signature",
        .size = "Size",
    };
};
