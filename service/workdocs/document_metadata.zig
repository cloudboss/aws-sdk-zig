const DocumentVersionMetadata = @import("document_version_metadata.zig").DocumentVersionMetadata;
const ResourceStateType = @import("resource_state_type.zig").ResourceStateType;

/// Describes the document.
pub const DocumentMetadata = struct {
    /// The time when the document was created.
    created_timestamp: ?i64 = null,

    /// The ID of the creator.
    creator_id: ?[]const u8 = null,

    /// The ID of the document.
    id: ?[]const u8 = null,

    /// List of labels on the document.
    labels: ?[]const []const u8 = null,

    /// The latest version of the document.
    latest_version_metadata: ?DocumentVersionMetadata = null,

    /// The time when the document was updated.
    modified_timestamp: ?i64 = null,

    /// The ID of the parent folder.
    parent_folder_id: ?[]const u8 = null,

    /// The resource state.
    resource_state: ?ResourceStateType = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .creator_id = "CreatorId",
        .id = "Id",
        .labels = "Labels",
        .latest_version_metadata = "LatestVersionMetadata",
        .modified_timestamp = "ModifiedTimestamp",
        .parent_folder_id = "ParentFolderId",
        .resource_state = "ResourceState",
    };
};
