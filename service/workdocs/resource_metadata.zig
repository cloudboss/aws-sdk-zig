const UserMetadata = @import("user_metadata.zig").UserMetadata;
const ResourceType = @import("resource_type.zig").ResourceType;

/// Describes the metadata of a resource.
pub const ResourceMetadata = struct {
    /// The ID of the resource.
    id: ?[]const u8 = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    /// The original name of the resource before a rename operation.
    original_name: ?[]const u8 = null,

    /// The owner of the resource.
    owner: ?UserMetadata = null,

    /// The parent ID of the resource before a rename operation.
    parent_id: ?[]const u8 = null,

    /// The type of resource.
    @"type": ?ResourceType = null,

    /// The version ID of the resource. This is an optional field and is filled for
    /// action
    /// on document version.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
        .original_name = "OriginalName",
        .owner = "Owner",
        .parent_id = "ParentId",
        .@"type" = "Type",
        .version_id = "VersionId",
    };
};
