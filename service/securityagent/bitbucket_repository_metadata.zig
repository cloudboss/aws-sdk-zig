const AccessType = @import("access_type.zig").AccessType;

/// Metadata for an integrated Bitbucket repository.
pub const BitbucketRepositoryMetadata = struct {
    access_type: ?AccessType = null,

    name: []const u8,

    provider_resource_id: []const u8,

    /// The workspace slug that owns the repository.
    workspace: []const u8,

    pub const json_field_names = .{
        .access_type = "accessType",
        .name = "name",
        .provider_resource_id = "providerResourceId",
        .workspace = "workspace",
    };
};
