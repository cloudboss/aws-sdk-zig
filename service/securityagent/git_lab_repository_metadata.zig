const AccessType = @import("access_type.zig").AccessType;

/// Metadata for an integrated GitLab repository.
pub const GitLabRepositoryMetadata = struct {
    access_type: ?AccessType = null,

    name: []const u8,

    /// The namespace (group or user path) that owns the project.
    namespace: []const u8,

    provider_resource_id: []const u8,

    pub const json_field_names = .{
        .access_type = "accessType",
        .name = "name",
        .namespace = "namespace",
        .provider_resource_id = "providerResourceId",
    };
};
